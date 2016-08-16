//
//  NSDate+ISO8601.h
//  authenticator
//
//  Created by Serge Golubenko on 16.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ISO8601)

+ (NSDate *)dateWithISO8601String:(NSString *)dateString;

@end
