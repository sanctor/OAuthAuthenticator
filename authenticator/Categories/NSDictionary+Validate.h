//
//  NSDictionary+Validate.h
//  authenticator
//
//  Created by Serge Golubenko on 15.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Validate)

- (BOOL)validValueForKey:(NSString *)key;

@end
