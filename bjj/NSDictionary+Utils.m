//
//  NSDictionary+Utils.m
//  bjj
//
//  Created by Kelvin Lau on 2015-02-21.
//  Copyright (c) 2015 Kelvin Lau. All rights reserved.
//

#import "NSDictionary+Utils.h"

@implementation NSDictionary (Utils)

- (id)objectForKeyOrNil:(NSString *)key {
    if([self objectForKey:key] != nil) {
        return [self objectForKey:key];
    } else {
        return nil;
    }
}

- (NSString *)stringForKey:(NSString *)key {
    if ([[self objectForKeyOrNil:key] isKindOfClass:[NSString class]]) {
        return (NSString *)[self objectForKeyOrNil:key];
    } else {
        return nil;
    }
}

- (NSNumber *)numberForKey:(NSString *)key {
    if ([[self objectForKeyOrNil:key] isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)[self objectForKeyOrNil:key];
    } else {
        return nil;
    }
}

- (NSDate *)dateForKey:(NSString *)key {
    if ([[self objectForKeyOrNil:key] isKindOfClass:[NSNumber class]]) {
        return (NSDate *)[self objectForKeyOrNil:key];
    } else {
        return nil;
    }
}

@end
