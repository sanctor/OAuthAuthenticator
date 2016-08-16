//
//  NSDate+ISO8601.m
//  authenticator
//
//  Created by Serge Golubenko on 16.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import "NSDate+ISO8601.h"

@implementation NSDate (ISO8601)

+ (NSDate *)dateWithISO8601String:(NSString *)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ";
    formatter.timeZone = [NSTimeZone systemTimeZone];

    NSDate *result = [formatter dateFromString:dateString];

    if (!result) {
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
        result = [formatter dateFromString:dateString];

        if (!result) {
            formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZ";
            result = [formatter dateFromString:dateString];
        }
    }

    return result;
}

@end
