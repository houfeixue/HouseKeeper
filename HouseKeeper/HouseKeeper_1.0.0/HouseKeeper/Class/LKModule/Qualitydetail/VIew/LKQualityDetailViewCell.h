//
//  LKQualityDetailViewCell.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/18.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewCell.h"

typedef void(^LKQualityDetailViewCellImageTap)(NSInteger index, UIView *imageBgView);

@interface LKQualityDetailViewCell : LKBaseTableViewCell

@property(nonatomic,strong)UIView * whiteView;

@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * nameDetailLabel;
@property(nonatomic,strong)UIView * lineView;

@property(nonatomic,strong)UILabel * scoreNameLabel;
@property(nonatomic,strong)UILabel * scoreLabel;
@property(nonatomic,strong)UIView * lineView2;

@property(nonatomic,strong)UILabel * describeLabel;
@property(nonatomic,strong)UILabel * describeTitleLabel;
@property(nonatomic,strong)UIView * lineView3;

@property(nonatomic,strong)UIView * imagesView;


@property (nonatomic, copy) LKQualityDetailViewCellImageTap imageTapBlock;



@end
