//
//  LKScoreView.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ScoreViewClick)(NSString * status);


@interface LKScoreView : UIView

@property(nonatomic,strong)UILabel * scoreLabel;
@property(nonatomic,strong)UIButton * submitBtn;
@property (nonatomic, strong) UIView *lineView;

@property(nonatomic,copy)ScoreViewClick scoreViewClick;

-(void)conFigScoreCount:(NSString *)score;

@end
