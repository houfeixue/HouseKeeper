//
//  SDChatMessage.h
//  SDChat
//
//  Created by Megatron Joker on 2017/5/19.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDChatMessage : NSObject

/**
 消息
 */
@property (nonatomic,strong)NSString *message;

/**
 消息id
 */
@property (nonatomic,strong)NSString *msgID;

/**
 发送时间
 */
@property (nonatomic,strong)NSString *sendTimeStr;

/**
 消息类型
 */
@property (nonatomic,assign)NSUInteger msgType;

/**
  0客户/1管家
 */
@property (nonatomic,copy)   NSString *sender;


/**
  名字
 */
@property (nonatomic,strong) NSString *personName;

/**
 客户id
 */
@property (nonatomic,strong) NSString *staffID;

/**
 图像
 */
@property (nonatomic,strong) NSString * personPic;

-(instancetype)initWithChatMessageDic:(NSDictionary *)dic;
+(instancetype)chatMessageWithDic:(NSDictionary *)dic;
@end
