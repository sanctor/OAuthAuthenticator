//
//  UserProfile.h
//  authenticator
//
//  Created by Serge Golubenko on 15.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import "EnterpriseAccount.h"
#import <Foundation/Foundation.h>

@interface UserProfile : NSObject

@property (nonatomic, strong, readonly) NSString *profileImageURL;

@property (nonatomic, strong, readonly) NSDate *creationDate;
@property (nonatomic, strong, readonly) NSString *salutation;
@property (nonatomic, strong, readonly) NSString *firstName;
@property (nonatomic, strong, readonly) NSString *lastName;
@property (nonatomic, strong, readonly) NSString *culture;

@property (nonatomic, strong, readonly) NSString *eMail;
@property (nonatomic, strong, readonly) NSString *phone;
@property (nonatomic, strong, readonly) NSString *countryCode;
@property (nonatomic, strong, readonly) NSString *city;
@property (nonatomic, strong, readonly) NSString *street;
@property (nonatomic, strong, readonly) NSString *street2;
@property (nonatomic, strong, readonly) NSString *zipCode;

@property (nonatomic, strong, readonly) NSString *companyName;
@property (nonatomic, strong, readonly) EnterpriseAccount *enterpriseAccount;

@property (nonatomic, readonly) BOOL activated;
@property (nonatomic, readonly) BOOL inOrganization;
@property (nonatomic, readonly) BOOL locked;
@property (nonatomic, readonly) BOOL valid;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *language;
@property (nonatomic, readonly, copy) NSString *creationString;

@end
