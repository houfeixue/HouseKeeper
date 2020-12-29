//
//  LKQualityDetailHeaderView.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/18.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QualityDetailHeaderClick)(NSString * status);


@interface LKQualityDetailHeaderView : UIView

@property(nonatomic,strong)UIImageView * picImageView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * scoreLabel;

@property(nonatomic,strong)UIButton * flitBtn;
@property(nonatomic,copy)QualityDetailHeaderClick qualityDetailHeaderClick;
- (void)bindDataIconImage:(NSString *)iconImage titleName:(NSString *)titleName score:(NSString *)score;
@end
