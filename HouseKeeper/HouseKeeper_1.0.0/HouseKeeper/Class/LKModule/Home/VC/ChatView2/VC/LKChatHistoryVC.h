//
//  LKChatHistoryVC.h
//  HouseKeeper
//
//  Created by Lin Hu on 2018/8/9.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseViewController.h"
#import "SDChat.h"
#import "LKMyMessageModel.h"

@interface LKChatHistoryVC : LKBaseViewController
@property (nonatomic,strong)SDChat *chat;
@property (nonatomic, strong) LKMyMessageModel *myModel;
@property (nonatomic,assign)int MinID; /// 最小的消息id
@end
