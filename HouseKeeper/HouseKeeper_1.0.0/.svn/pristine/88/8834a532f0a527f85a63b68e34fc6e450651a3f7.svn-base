//
//  LKMessage.h
//  HouseKeeper
//
//  Created by Lin Hu on 2018/8/2.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKMessage : NSObject
typedef enum {
    MessageTypeMe = 0, // 我发出的信息
    MessageTypeOhter = 1 // 对方发出的信息
} MessageType;


/** 信息 */
@property(nonatomic, copy) NSString *text;

/** 发送时间 */
@property(nonatomic, copy) NSString *time;

/** 发送方 */
@property(nonatomic, assign) MessageType type;

/** 是否隐藏发送时间 */
@property(nonatomic, assign) BOOL hideTime;

- (instancetype) initWithDictionary:(NSDictionary *) dictionary;
+ (instancetype) messageWithDictionary:(NSDictionary *) dictionary;
+ (instancetype) message;
@end
