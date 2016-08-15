//
//  NSDictionary+Validate.m
//  authenticator
//
//  Created by Serge Golubenko on 15.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import "NSDictionary+Validate.h"

@implementation NSDictionary (Validate)

- (BOOL)validValueForKey:(NSString *)key {
    return ([self valueForKey:key] && ![[self valueForKey:key] isEqual:[NSNull null]]);
}

@end
