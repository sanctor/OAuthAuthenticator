//
//  AuthAPIManager.h
//  authenticator
//
//  Created by Serge Golubenko on 15.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import "UserProfile.h"
#import <Foundation/Foundation.h>

@interface AuthAPIManager : NSObject

+ (AuthAPIManager *)shared;

@property (nonatomic, readonly, strong) UserProfile *userProfile;

@property (nonatomic, readonly, copy) NSURL *loginURL;
@property (nonatomic, getter=isAuthenticated, readonly) BOOL authenticated;

- (void)authenticateWithCode:(NSString *)authCode
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

- (void)loadUserDataSuccess:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;

@end
