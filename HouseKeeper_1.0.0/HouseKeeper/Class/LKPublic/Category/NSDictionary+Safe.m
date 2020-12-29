//
//  NSDictionary+Safe.m
//  MQ
//
//  Created by tianlibin on 3/22/14.
//  Copyright (c) 2014 mq.com. All rights reserved.
//

#import "NSDictionary+Safe.h"

@implementation NSDictionary (Safe)

- (NSNumber*)numberForKey:(NSString*)key
{
    if (key.length > 0) {
        NSNumber* obj = [self objectForKey:key];
        if ([obj isKindOfClass:[NSNumber class]]) {
            return obj;
        }
    }
    return nil;
}


- (NSString*)stringForKey:(NSString*)key
{
    if (key.length > 0) {
        NSString* obj = [self objectForKey:key];
        if ([obj isKindOfClass:[NSString class]]) {
            return obj;
        }
    }
    return nil;
}

- (NSInteger)integerForKey:(NSString*)key
{
    NSNumber* val = [self numberForKey:key];
    if (val == nil) {
        NSString* str = [self stringForKey:key];
        return str.integerValue;
    }
    
    return val.integerValue;
}

- (long long)longForKey:(NSString*)key
{
    NSNumber* val = [self numberForKey:key];
    if (val == nil) {
        NSString* str = [self stringForKey:key];
        return str.longLongValue;
    }
    
    return val.longLongValue;
}

- (CGFloat)floatForKey:(NSString *)key
{
    NSNumber* val = [self numberForKey:key];
    if (val == nil) {
        NSString* str = [self stringForKey:key];
        return str.floatValue;
    }
    
    return val.floatValue;
}

- (NSDictionary*)dicForKey:(NSString*)key
{
    if (key.length > 0) {
        NSDictionary* obj = [self objectForKey:key];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            return obj;
        }
    }
    return nil;
}

- (NSArray*)arrayForKey:(NSString*)key
{
    if (key.length > 0) {
        NSArray* obj = [self objectForKey:key];
        if ([obj isKindOfClass:[NSArray class]]) {
            return obj;
        }
    }
    return nil;
}


- (NSNumber*)numberForKey:(NSString*)key defaultValue:(NSNumber*)value
{
    NSNumber* obj = [self numberForKey:key];
    if (obj != nil) {
        return obj;
    }
    else {
        return value;
    }
}

- (NSString*)stringForKey:(NSString*)key defaultValue:(NSString*)value
{
    NSString* obj = [self stringForKey:key];
    if (obj != nil) {
        return obj;
    }
    else {
        return value;
    }
}

- (NSDictionary*)dicForKey:(NSString*)key defaultValue:(NSDictionary*)value
{
    NSDictionary* obj = [self dicForKey:key];
    if (obj != nil) {
        return obj;
    }
    else {
        return value;
    }
}

- (NSArray*)arrayForKey:(NSString*)key defaultValue:(NSArray*)value
{
    NSArray* obj = [self arrayForKey:key];
    if (obj != nil) {
        return obj;
    }
    else {
        return value;
    }
}




+ (NSDictionary*)dicFromURL:(NSURL*)url
{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithCapacity:8];
    if (url != nil) {
        if (url.query.length > 0) {
            NSArray* array = [url.query componentsSeparatedByString:@"&"];
            if ([array count] > 0) {
                for (NSString* qq in array) {
                    NSArray* a = [qq componentsSeparatedByString:@"="];
                    if ([a count] == 2) {
                        NSString* key = [a objectAtIndex:0];
                        NSString* val = [a objectAtIndex:1];
                        if (key.length > 0 && val.length > 0) {
                            [param setObject:val forKey:key];
                        }
                    }
                }
            }
        }
    }

    return param;
}
-(void)saveKey:(NSString *)key withValue:(NSString *)value
{
    if (value==nil||[value isEqualToString:@""]) {
        NSLog(@"保存%@失败",key);
        return;
    }
    [self setValue:value forKey:key];
    
}
@end
