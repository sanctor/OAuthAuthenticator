//
//  Utils.m
//  authenticator
//
//  Created by Serge Golubenko on 15.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSDictionary *)parametersFromQueryString:(NSString *)queryString {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if (queryString.length) {
        NSScanner *paramScanner = [NSScanner scannerWithString:queryString];
        NSString *name = nil;
        NSString *value = nil;

        while (!paramScanner.atEnd) {
            name = nil;
            [paramScanner scanUpToString:@"=" intoString:&name];
            [paramScanner scanString:@"=" intoString:nil];

            value = nil;
            [paramScanner scanUpToString:@"&" intoString:&value];
            [paramScanner scanString:@"&" intoString:nil];

            if (name.length && value.length) {
                result[name.stringByRemovingPercentEncoding] = value.stringByRemovingPercentEncoding;
            }
        }
    }

    return result.allKeys.count ? [NSDictionary dictionaryWithDictionary:result] : nil;
}

@end
