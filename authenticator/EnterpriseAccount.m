//
//  EnterpriseAccount.m
//  authenticator
//
//  Created by Serge Golubenko on 16.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import "EnterpriseAccount.h"
#import "NSDate+ISO8601.h"
#import "NSDictionary+Validate.h"

@implementation EnterpriseAccount

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

/*{
 AccountName = "Sanctuary AG";
 Created = "2016-08-12T12:04:44.147";
 CustomerNumber = "<null>";
 Enabled = 1;
 Id = "1c87769c-fa0c-422a-9e12-c57013a05947";
 IsValid = 0;
 LogoSasUrl = "<null>";
 };*/

- (void)setDataFromDictionary:(NSDictionary *)dictionary {
    if ([dictionary validValueForKey:@"AccountName"]) {
        _accountName = dictionary[@"AccountName"];
    }

    if ([dictionary validValueForKey:@"Id"]) {
        _identifier = dictionary[@"Id"];
    }

    if ([dictionary validValueForKey:@"Created"]) {
        _creationDate = [NSDate dateWithISO8601String:dictionary[@"Created"]];
    }

    if ([dictionary validValueForKey:@"CustomerNumber"]) {
        _customerNumber = dictionary[@"CustomerNumber"];
    }

    if ([dictionary validValueForKey:@"LogoSasUrl"]) {
        _logoURL = dictionary[@"LogoSasUrl"];
    }

    if ([dictionary validValueForKey:@"Enabled"]) {
        _enabled = [dictionary[@"Enabled"] boolValue];
    }

    if ([dictionary validValueForKey:@"IsValid"]) {
        _valid = [dictionary[@"IsValid"] boolValue];
    }
}

- (NSString *)creationString {
    NSString *result = @"";

    if (self.creationDate) {
        result = [NSDateFormatter localizedStringFromDate:self.creationDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
    }

    return result;
}

@end
