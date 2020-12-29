//
//  LKSelectCityListView.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/24.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseView.h"

@class LKCityModel;

typedef void(^LKSelectCityListViewSelectCity)(LKCityModel *);

@interface LKSelectCityListView : LKBaseView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cityDataArray;
@property (nonatomic, strong) LKCityModel *selectCity;
@property (nonatomic, copy) LKSelectCityListViewSelectCity selectCityClick;
- (void)bindData:(NSMutableArray *)array;
@property (nonatomic, assign) BOOL isShow;
@end
