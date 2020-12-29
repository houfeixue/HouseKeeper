//
//  LKChatDetailVc.h
//  HouseKeeper
//
//  Created by Lin Hu on 2018/8/3.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseViewController.h"
#import "SDChat.h"
#import "LKMyMessageModel.h"

@interface LKChatDetailVc : LKBaseViewController
@property (nonatomic,strong)SDChat *chat;
@property (nonatomic, strong) LKMyMessageModel *myModel;
@end
