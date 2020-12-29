//
//  SDChat.m
//  SDChat
//
//  Created by slowdony on 2017/6/20.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChat.h"

@implementation SDChat

-(instancetype)initChatWithDic:(NSDictionary *)dic{
    self =[super init];
    if(self){
        
        self.fromUserName =dic[@"fromUserName"]; //昵称
        self.lastMessage=dic[@"lastMessage"]; //最后一句聊天
        self.portrait =dic[@"portrait"]; //头像
        self.lastTime=dic[@"lastTime"] ; //最后时间
        self.unReadNumber =[dic[@"unReadNumber"] intValue]; //未读消息
        self.fromUserId=dic[@"fromUserId"]; //VisterID访客ID
        
    }
    return self;
}

+(instancetype)chatWithDic:(NSDictionary *)dic{
    return [[self alloc]initChatWithDic:dic];
}

-(void)setIsONLine:(BOOL )isONLine{
    _isONLine=isONLine;
}

//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    
//    [aCoder encodeObject:self.fromUserName forKey:@"fromUserName"];
//    [aCoder encodeObject:self.lastMessage forKey:@"lastMessage"];
//    [aCoder encodeObject:self.portrait forKey:@"portrait"];
//    [aCoder encodeObject:self.lastTime forKey:@"lastTime"];
//    [aCoder encodeInteger:self.unReadNumber forKey:@"unReadNumber"];
//    [aCoder encodeObject:self.fromUserId forKey:@"fromUserId"];
//}
//- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        self.fromUserName = [aDecoder decodeObjectForKey:@"fromUserName"];
//        self.lastMessage = [aDecoder decodeObjectForKey:@"lastMessage"];
//        self.portrait = [aDecoder decodeObjectForKey:@"portrait"];
//        self.lastTime = [aDecoder decodeObjectForKey:@"lastTime"];
//        self.unReadNumber = [aDecoder decodeIntegerForKey:@"unReadNumber"];
//        self.fromUserId = [aDecoder decodeObjectForKey:@"fromUserId"];
//        
//    }
//    
//    return self;
//}




@end
