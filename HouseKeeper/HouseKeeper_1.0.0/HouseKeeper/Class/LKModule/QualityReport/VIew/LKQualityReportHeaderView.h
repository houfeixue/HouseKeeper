//
//  LKQualityReportHeaderView.h
//  HouseKeeper
//
//  Created by sunny on 2018/8/6.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LKQualityReportHeaderViewClick)(NSString * status);

@interface LKQualityReportHeaderView : UIView
@property(nonatomic,strong)UIImageView * picImageView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * scoreLabel;

@property(nonatomic,strong)UIButton * flitBtn;
@property(nonatomic,copy)LKQualityReportHeaderViewClick qualityDetailHeaderClick;
- (void)bindDataIconImage:(NSString *)iconImage titleName:(NSString *)titleName score:(NSString *)score;
@end
