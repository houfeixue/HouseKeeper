//
//  LKHomeTableViewCell.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/10.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewCell.h"
typedef void(^BtnClick)(NSString * status);

@interface LKHomeTableViewCell : LKBaseTableViewCell
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UIButton * btn;
@property(nonatomic,copy)BtnClick btnClick;

@end
