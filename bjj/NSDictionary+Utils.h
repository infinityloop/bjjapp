//
//  NSDictionary+Utils.h
//  bjj
//
//  Created by Kelvin Lau on 2015-02-21.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (Utils)

- (id)objectForKeyOrNil:(NSString*)key;
- (NSString *)stringForKey:(NSString *)key;
- (NSNumber *)numberForKey:(NSString *)key;
- (NSDate *)dateForKey:(NSString *)key;
@end
