//
//  LKScoreDetailView.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/31.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScoreDetailClick)(NSString * status);

@interface LKScoreDetailView : UIView

@property(nonatomic,strong)UIButton * saveBtn;
@property(nonatomic,strong)UIButton * nextBtn;
@property(nonatomic,copy)ScoreDetailClick scoreDetailClick;

-(void)refreshBottomUI;

@end
