//
//  LKSelectListView.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LKSelectViewModel.h"

typedef void(^SelectListClick)(LKCommityModel * model , NSInteger count);

@interface LKSelectListView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)LKSelectViewModel * selectViewModel;

@property(nonatomic,strong)NSMutableArray  * dataArray;

@property(nonatomic,copy)SelectListClick selectListClick;


@property (nonatomic, strong) NSNumber *selectCommityId;//选择小区ID


@end
