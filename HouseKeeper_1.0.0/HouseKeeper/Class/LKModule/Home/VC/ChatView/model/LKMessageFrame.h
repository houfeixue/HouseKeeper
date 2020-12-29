//
//  LKMessageFrame.h
//  HouseKeeper
//
//  Created by Lin Hu on 2018/8/2.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "LKMessage.h"

#define MESSAGE_TIME_FONT [UIFont systemFontOfSize:13]
#define MESSAGE_TEXT_FONT [UIFont systemFontOfSize:15]
#define TEXT_INSET 20

@interface LKMessageFrame : NSObject
/** 发送时间  */
@property(nonatomic, assign, readonly) CGRect timeFrame;

/** 头像 */
@property(nonatomic, assign, readonly) CGRect iconFrame;

/** 信息 */
@property(nonatomic, assign, readonly) CGRect textFrame;

/** 信息model */
@property(nonatomic, strong) LKMessage *message;

/** cell的高度 */
@property(nonatomic, assign) CGFloat cellHeight;
@end
