//
//  LKQualityListSectionHeaderView.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/16.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKQualityListModel.h"
typedef void(^QualityBtnClick)(NSString * status);
typedef void(^QualityUpLoadClick)(NSString * status);

@interface LKQualityListSectionHeaderView : UIView

@property(nonatomic,strong)UIImageView * picImageView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * scoreLabel;
@property(nonatomic,strong)UILabel * detailLabel;
@property(nonatomic,strong)UIButton * isFoldBtn;
@property(nonatomic,strong)LDProgressView *  progressView;
@property(nonatomic,strong)UILabel *progressLabel;

@property(nonatomic,strong)UIButton * lookBtn;
@property(nonatomic,strong)UIButton * uploadBtn;

@property(nonatomic,copy)QualityBtnClick qualityBtnClick;
@property(nonatomic,copy)QualityUpLoadClick qualityUpLoadClick;



@property(nonatomic,strong)LKQualityListModel *selectModel;


-(void)setViewUIWithModel:(LKQualityListModel*)model;

@end
