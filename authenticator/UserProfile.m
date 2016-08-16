//
//  UserProfile.m
//  authenticator
//
//  Created by Serge Golubenko on 15.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import "UserProfile.h"
#import "NSDate+ISO8601.h"
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

/*{
 ActivationHandler = "<null>";
 AvatarSasUrl = "https://m42acs.blob.core.windows.net/accounts/avatars/sanctor@ukr.net/avatar?sv=2014-02-14&sr=b&sig=WGYB5bxTW2n18LRhk2u08V7zbOMjszgKS0KhohVTfk0%3D&st=2016-08-16T07%3A48%3A37Z&se=2016-08-16T07%3A50%3A37Z&sp=r";
 ChangePasswordOnNextLogin = 0;
 City = Kiev;
 CompanyName = "Sanctuary AG";
 Country = UA;
 Created = "2016-08-12T12:04:06.013";
 CultureString = "<null>";
 EnterpriseAccount =     {
                             AccountName = "Sanctuary AG";
                             Created = "2016-08-12T12:04:44.147";
                             CustomerNumber = "<null>";
                             Enabled = 1;
                             Id = "1c87769c-fa0c-422a-9e12-c57013a05947";
                             IsValid = 0;
                             LogoSasUrl = "<null>";
                             };
 FirstName = Serge;
 IsActivated = 1;
 IsInOrganization = 1;
 IsLocked = 0;
 IsValid = 0;
 LastName = Green;
 MailAddress = "sanctor@ukr.net";
 Password = "<null>";
 Phone = "+380503556265";
 Salutation = Mr;
 Street = "34 Freedom ave";
 Street2 = "<null>";
 ZipCode = 04108;
 }*/

- (void)setDataFromDictionary:(NSDictionary *)dictionary {

    if ([dictionary validValueForKey:@"Created"]) {
        _creationDate = [NSDate dateWithISO8601String:dictionary[@"Created"]];
    }

    if ([dictionary validValueForKey:@"Salutation"]) {
        _salutation = dictionary[@"Salutation"];
    }

    if ([dictionary validValueForKey:@"FirstName"]) {
        _firstName = dictionary[@"FirstName"];
    }

    if ([dictionary validValueForKey:@"LastName"]) {
        _lastName = dictionary[@"LastName"];
    }

    if ([dictionary validValueForKey:@"CultureString"]) {
        _culture = dictionary[@"CultureString"];
    }

    if ([dictionary validValueForKey:@"Phone"]) {
        _phone = dictionary[@"Phone"];
    }

    if ([dictionary validValueForKey:@"MailAddress"]) {
        _eMail = dictionary[@"MailAddress"];
    }

    if ([dictionary validValueForKey:@"AvatarSasUrl"]) {
        _profileImageURL = dictionary[@"AvatarSasUrl"];
    }

    if ([dictionary validValueForKey:@"Country"]) {
        _countryCode = dictionary[@"Country"];
    }

    if ([dictionary validValueForKey:@"City"]) {
        _city = dictionary[@"City"];
    }

    if ([dictionary validValueForKey:@"Street"]) {
        _street = dictionary[@"Street"];
    }

    if ([dictionary validValueForKey:@"Street2"]) {
        _street2 = dictionary[@"Street2"];
    }

    if ([dictionary validValueForKey:@"ZipCode"]) {
        _zipCode = dictionary[@"ZipCode"];
    }

    if ([dictionary validValueForKey:@"CompanyName"]) {
        _companyName = dictionary[@"CompanyName"];
    }

    if ([dictionary validValueForKey:@"EnterpriseAccount"]) {
        NSDictionary *dic = dictionary[@"EnterpriseAccount"];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            _enterpriseAccount = [[EnterpriseAccount alloc] initWithDictionary:dic];
        }
    }

    if ([dictionary validValueForKey:@"IsActivated"]) {
        _activated = [dictionary[@"IsActivated"] boolValue];
    }

    if ([dictionary validValueForKey:@"IsInOrganization"]) {
        _inOrganization = [dictionary[@"IsInOrganization"] boolValue];
    }

    if ([dictionary validValueForKey:@"IsLocked"]) {
        _locked = [dictionary[@"IsLocked"] boolValue];
    }

    if ([dictionary validValueForKey:@"IsValid"]) {
        _valid = [dictionary[@"IsValid"] boolValue];
    }
}

- (NSString *)name {

    NSMutableArray *nameArr = [NSMutableArray new];

    if (self.salutation.length) {
        [nameArr addObject:self.salutation];
    }

    if (self.firstName.length) {
        [nameArr addObject:self.firstName];
    }

    if (self.lastName.length) {
        [nameArr addObject:self.lastName];
    }

    NSString *result = [nameArr componentsJoinedByString:@" "];

    return result;
}

- (NSString *)language {
    NSString *result = NSLocalizedString(@"Language", nil);

    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:self.culture];
    if (locale) {
        result = [locale displayNameForKey:NSLocaleIdentifier value:self.culture];
    }

    return result;
}

- (NSString *)creationString {
    NSString *result = @"";

    if (self.creationDate) {
        result = [NSDateFormatter localizedStringFromDate:self.creationDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
    }

    return result;
}

@end
