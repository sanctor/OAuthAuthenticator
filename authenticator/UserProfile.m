//
//  UserProfile.m
//  authenticator
//
//  Created by Serge Golubenko on 15.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import "UserProfile.h"
#import "NSDictionary+Validate.h"

@implementation UserProfile

- (instancetype)init {
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self) {
        if (dictionary.allKeys.count) {
            [self setDataFromDictionary:dictionary];
        }
    }
    return self;
}

- (void)setDataFromDictionary:(NSDictionary *)dictionary {
    if ([dictionary validValueForKey:@"MailAddress"]) {
        _eMail = dictionary[@"MailAddress"];
    }

    if ([dictionary validValueForKey:@"FirstName"]) {
        _firstName = dictionary[@"FirstName"];
    }

    if ([dictionary validValueForKey:@"LastName"]) {
        _lastName = dictionary[@"LastName"];
    }

    if ([dictionary validValueForKey:@"AvatarSasUrl"]) {
        _profileImageURL = dictionary[@"AvatarSasUrl"];
    }

    if ([dictionary validValueForKey:@"Country"]) {
        _countryCode = dictionary[@"Country"];
    }
}

- (NSString *)name {
    NSString *result = nil;

    if (self.lastName.length) {
        if (self.firstName.length) {
            result = [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
        } else {
            result = [NSString stringWithFormat:@"%@", self.lastName];
        }
    } else if (self.firstName.length) {
        result = [NSString stringWithFormat:@"%@", self.firstName];
    }

    return result;
}

@end
