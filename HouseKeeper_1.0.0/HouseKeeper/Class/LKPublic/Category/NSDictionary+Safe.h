//
//  NSDictionary+Safe.h
//  MQ
//
//  Created by tianlibin on 3/22/14.
//  Copyright (c) 2014 mq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (Safe)

- (NSNumber*)numberForKey:(NSString*)key;
- (NSString*)stringForKey:(NSString*)key;
- (NSDictionary*)dicForKey:(NSString*)key;
- (NSArray*)arrayForKey:(NSString*)key;
- (CGFloat)floatForKey:(NSString *)key;

- (NSNumber*)numberForKey:(NSString*)key defaultValue:(NSNumber*)value;
- (NSString*)stringForKey:(NSString*)key defaultValue:(NSString*)value;
- (NSDictionary*)dicForKey:(NSString*)key defaultValue:(NSDictionary*)value;
- (NSArray*)arrayForKey:(NSString*)key defaultValue:(NSArray*)value;

- (NSInteger)integerForKey:(NSString*)key;
- (long long)longForKey:(NSString*)key;


+ (NSDictionary*)dicFromURL:(NSURL*)url;
-(void)saveKey:(NSString *)key withValue:(NSString *)value;
@end
