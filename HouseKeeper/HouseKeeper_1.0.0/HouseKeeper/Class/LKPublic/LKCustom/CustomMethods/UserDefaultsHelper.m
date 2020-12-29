//
//  UserDefaultsHelper.m
//  CBD
//
//  Created by screate on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserDefaultsHelper.h"

@implementation UserDefaultsHelper

    +(NSString*)getStringForKey:(NSString*)key
    {
        NSString* val = @"";
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults) val = [standardUserDefaults stringForKey:key];
        if (val == NULL) val = @"";
        return val;
    }
    
    +(NSInteger)getIntForkey:(NSString *)key
    {
        NSInteger val = 0;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults) val = [standardUserDefaults integerForKey:key];
        return val;
    }
    
    +(NSDictionary*)getDictForKey:(NSString*)key
    {
        NSDictionary* val = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults) val = [standardUserDefaults dictionaryForKey:key];
        return val;
    }
    
    +(NSArray*)getArrayForKey:(NSString*)key
    {
        NSArray* val = nil;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults) val = [standardUserDefaults arrayForKey:key];
        return val;
    }
    
    +(BOOL)getBoolForKey:(NSString*)key
    {
        BOOL val = FALSE;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults) val = [standardUserDefaults boolForKey:key];
        return val;
    }
    
    +(void)setStringForKey:(NSString*)value:(NSString*)key
    {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults) 
        {
            [standardUserDefaults setObject:value forKey:key];
            [standardUserDefaults synchronize];
        }
    }
    
    +(void)setIntForKey:(NSInteger)value:(NSString*)key
    {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults) 
        {
            [standardUserDefaults setInteger:value forKey:key];
            [standardUserDefaults synchronize];
        }
    }
    
    +(void)setDictForKey:(NSDictionary*)value:(NSString*)key
    {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults) 
        {
            [standardUserDefaults setObject:value forKey:key];
            [standardUserDefaults synchronize];
        }
    }
    
    +(void)setArrayForKey:(NSArray*)value:(NSString*)key
    {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults) 
        {
            [standardUserDefaults setObject:value forKey:key];
            [standardUserDefaults synchronize];
        }
    }
    
    +(void)setBoolForKey:(BOOL)value:(NSString*)key
    {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults) 
        {
            [standardUserDefaults setBool:value forKey:key];
            [standardUserDefaults synchronize];
        }
    }
    

+(void)clearObjectForKeys:(NSArray *)keys
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        for (NSString *key in keys)
        {
            [standardUserDefaults removeObjectForKey:key];
        }
        [standardUserDefaults synchronize];
    }
}

@end
