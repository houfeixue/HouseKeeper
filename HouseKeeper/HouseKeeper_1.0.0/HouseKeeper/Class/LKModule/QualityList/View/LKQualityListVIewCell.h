//
//  LKQualityListVIewCell.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/16.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewCell.h"

typedef void(^QualityListCellClick)(NSString * status);


@interface LKQualityListVIewCell : LKBaseTableViewCell
@property(nonatomic,strong)UIView * whiteView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UIView * lineView;

@property(nonatomic,strong)UIButton * scoreStatusBtn;
@property(nonatomic,strong)UILabel * referenceLabel;

@property(nonatomic,strong)UILabel * scoreLabel;

@property(nonatomic,strong)UIButton * scoreBtn;
@property(nonatomic,copy)QualityListCellClick qualityListCellClick;



@end
