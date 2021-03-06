//
//  LKQualityScoreDetailViewController.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseViewController.h"
#import "LKQualityListModel.h"

typedef void(^QualityScorerClick)(NSString * status);


@interface LKQualityScoreDetailViewController : LKBaseViewController

@property(nonatomic,strong)LKQualityListModel * listModel ;
@property(nonatomic,assign)NSInteger  index;
@property(nonatomic,assign)NSNumber *  commityId;

@property(nonatomic,copy)QualityScorerClick qualityScorerClick;


@end
