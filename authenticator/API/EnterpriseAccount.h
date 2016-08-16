//
//  EnterpriseAccount.h
//  authenticator
//
//  Created by Serge Golubenko on 16.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnterpriseAccount : NSObject

@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSString *accountName;
@property (nonatomic, strong, readonly) NSDate *creationDate;
@property (nonatomic, strong, readonly) NSString *customerNumber;
@property (nonatomic, strong, readonly) NSString *logoURL;

@property (nonatomic, readonly) BOOL enabled;
@property (nonatomic, readonly) BOOL valid;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly, copy) NSString *creationString;

@end
