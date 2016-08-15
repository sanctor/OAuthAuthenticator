//
//  Utils.h
//  authenticator
//
//  Created by Serge Golubenko on 15.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
    static dispatch_once_t pred = 0;              \
    __strong static id _sharedObject = nil;       \
    dispatch_once(&pred, ^{                       \
      _sharedObject = block();                    \
    });                                           \
    return _sharedObject;

@interface Utils : NSObject

+ (NSDictionary *)parametersFromQueryString:(NSString *)queryString;

@end
