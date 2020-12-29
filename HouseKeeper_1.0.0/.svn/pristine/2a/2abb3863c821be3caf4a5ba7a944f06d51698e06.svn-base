//
//  SDChatDetail.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/18.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatDetail.h"
#import "SDChatMessage.h"
@interface SDChatDetail()



/** 文字聊天内容 */
@property (nonatomic, copy) NSString *contentText;
/**
 聊天文字背景图
 */
@property (nonatomic,strong)UIImage *contectTextBackgroundIma;
@property (nonatomic,strong)UIImage *contectTextBackgroundHLIma;


/**
 头像url
 */
@property (nonatomic,copy)NSString *iconHead;


/**
 时间str
 */
@property (nonatomic,copy)NSString *timeStr;


/**
 姓名
 */
@property (nonatomic,copy)NSString *nameStr;


/**
 是否显示时间
 */
@property (nonatomic,assign,getter=isShowTime) BOOL showTime;


/**
 是否显示名字
 */
@property (nonatomic,assign,getter=isMe)BOOL me;


/**
 是否是患者
 */
@property (nonatomic,assign,getter=isPatient)BOOL patient;

/**
 聊天类型
 */
@property (nonatomic,assign)SDChatDetailType chatType;
@end

@implementation SDChatDetail
+ (instancetype)sd_chatWith:(SDChatMessage *)chatMsg {
    SDChatDetail *chat =[[self alloc]init];
    chat.chatMsg=chatMsg;
    return chat;
}

-(void)setChatMsg:(SDChatMessage *)chatMsg{
    _chatMsg =chatMsg;
    self.patient=[chatMsg.sender boolValue];
    if (!self.patient) { //对方信息设置
        self.contectTextBackgroundIma = [UIImage imageNamed: @"Combined Shape Copy 5"];
        self.contectTextBackgroundHLIma = [UIImage imageNamed: @"Combined Shape Copy 5"];
        self.me=NO;
    }else { /// 我的信息设置
        self.contectTextBackgroundIma = [UIImage imageNamed: @"Combined Shape Copy"];
        self.contectTextBackgroundHLIma = [UIImage imageNamed: @"Combined Shape Copy"];
        self.me=YES;
    }
    self.iconHead = chatMsg.personPic;
    self.timeStr=chatMsg.sendTimeStr;
    self.nameStr=chatMsg.personName;
    self.contentText=chatMsg.message;
    self.showTime=YES;
    self.chatType=chatMsg.msgType;

    
}

@end
