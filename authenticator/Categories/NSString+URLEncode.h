//
//  NSString+URLEncode.h
//  authenticator
//
//  Created by Serge Golubenko on 15.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncode)

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *URLEncode;

@end
