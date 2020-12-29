//
//  LKMessage.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/8/2.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKMessage.h"

@implementation LKMessage
- (instancetype) initWithDictionary:(NSDictionary *) dictionary {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    
    return self;
}

+ (instancetype) messageWithDictionary:(NSDictionary *) dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

+ (instancetype) message {
    return [self messageWithDictionary:nil];
}

@end
