//
//  LKAlumbsViewController.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewController.h"

@interface LKAlumbsViewController : LKBaseTableViewController

@property(nonatomic,copy)NSString * type;//select 选取图片。default 图片库
@property(nonatomic,assign)NSInteger  selectCount;//select 最大数


@property(nonatomic,strong)UIViewController * formVC;//


@end
