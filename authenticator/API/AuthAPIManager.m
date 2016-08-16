//
//  AuthAPIManager.m
//  authenticator
//
//  Created by Serge Golubenko on 15.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import "AuthAPIManager.h"
#import "AFOAuth2Manager.h"
#import "NSString+URLEncode.h"
#import "Utils.h"

#define API_HOST @"https://accounts.matrix42.com"
#define API_CLIENT_ID @"2602af7f-f6a4-43db-a871-c63d01689541"
#define API_CLIENT_SECRET @"t7MAa7DdLeHzsbFPnuQHLbBihMnlhNkKMWylw9Iii+o="
#define API_SCOPE_ID @"urn:df09449a-1e7d-4d89-94c3-48c659881cf6"
#define API_REDIRECT_URI @"sgauth://oauth2Callback"

@interface AuthAPIManager ()
@property (nonatomic, strong) AFOAuth2Manager *manager;
@property (nonatomic, strong) AFOAuthCredential *credential;
@end

@implementation AuthAPIManager

+ (AuthAPIManager *)shared {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
      AuthAPIManager *instance = [[AuthAPIManager alloc] init];
      return instance;
    });
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager = [[AFOAuth2Manager alloc] initWithBaseURL:[NSURL URLWithString:API_HOST] clientID:API_CLIENT_ID secret:API_CLIENT_SECRET];

        self.credential = [AFOAuthCredential retrieveCredentialWithIdentifier:API_HOST];
    }
    return self;
}

- (BOOL)isAuthenticated {
    if (self.credential) {
        return self.credential.accessToken && !self.credential.isExpired;
    }
    return NO;
}

- (NSString *)loginURLString {
    NSString *urlString = [NSString stringWithFormat:@"%@/issue/oauth2/authorize?client_id=%@&scope=%@&redirect_uri=%@&response_type=code", API_HOST, API_CLIENT_ID, API_SCOPE_ID, API_REDIRECT_URI];

    return urlString;
}

- (NSURL *)loginURL {
    NSString *urlString = [self loginURLString].URLEncode;

    return [NSURL URLWithString:urlString];
}

#pragma mark -

- (NSError *)fixError:(NSError *)error errorDomain:(NSString *)errorDomain {
    NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    if (errorData) {
        NSString *errString = [[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding];

        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:errorData options:kNilOptions error:nil];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSInteger code = error.code;
            if (responseObject[@"error_code"]) {
                code = [responseObject[@"error_code"] integerValue];
            }
            if (responseObject[@"error_msg"]) {
                error = [NSError errorWithDomain:errorDomain
                                            code:code
                                        userInfo:@{ NSLocalizedDescriptionKey : NSLocalizedString(responseObject[@"error_msg"], nil),
                                                    NSLocalizedFailureReasonErrorKey : NSLocalizedString(responseObject[@"error_msg"], nil) }];
            }
        } else {
            NSLog(@"Error string = %@", errString);
        }
    }

    if ([error.domain isEqualToString:NSURLErrorDomain]) {
        error = [NSError errorWithDomain:NSURLErrorDomain
                                    code:error.code
                                userInfo:@{ NSLocalizedDescriptionKey : NSLocalizedString(@"Connection Error. Please try again later. If the problem persists, please contact support", nil) }];
    }

    return error;
}

#pragma mark -

- (void)loadUserDataSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self.manager GET:@"api/session/profile"
        parameters:nil
        progress:nil
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
          NSLog(@"Response: %@", responseObject);
          if ([responseObject isKindOfClass:[NSDictionary class]]) {
              _userProfile = [[UserProfile alloc] initWithDictionary:(NSDictionary *)responseObject];
          }

          if (success) {
              success(responseObject);
          }
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
          [self logout];

          error = [self fixError:error errorDomain:@"user_data"];
          NSLog(@"User data error: %@", error);
          if (failure) {
              failure(error);
          }
        }];
}

- (void)authenticateWithCode:(NSString *)authCode success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self.manager authenticateUsingOAuthWithURLString:@"issue/oauth2/token/"
        code:authCode
        redirectURI:API_REDIRECT_URI
        success:^(AFOAuthCredential *_Nonnull credential) {
          NSLog(@"Credentials: %@", credential);
          self.credential = credential;
          [AFOAuthCredential storeCredential:credential withIdentifier:API_HOST];
          [self loadUserDataSuccess:nil failure:nil];
          if (success) {
              success(credential);
          }
        }
        failure:^(NSError *_Nonnull error) {
          error = [self fixError:error errorDomain:@"user_auth"];
          NSLog(@"Auth error: %@", error);
          if (failure) {
              failure(error);
          }
        }];
}

- (void)logout {
    self.credential = nil;
    [AFOAuthCredential deleteCredentialWithIdentifier:API_HOST];

    _userProfile = nil;
}

#pragma mark -

- (void)dealloc {
    self.manager = nil;
    self.credential = nil;

    _userProfile = nil;
}

@end
