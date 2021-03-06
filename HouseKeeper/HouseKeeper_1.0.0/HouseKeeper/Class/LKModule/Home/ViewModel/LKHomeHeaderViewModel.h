//
//  LKHomeHeaderViewModel.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/10.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKRequestViewModel.h"

@interface LKHomeHeaderViewModel : LKRequestViewModel
@property (nonatomic, strong) NSString *requestUrl;//请求接口地址
@property (nonatomic, strong) NSDictionary *requestDict;//请求接口参数
@property (nonatomic, strong) NSMutableArray *dataArray;//接口返回数据
@property (nonatomic, strong) RACSubject *pushDataSubject;//页面传值信号
@property (nonatomic, strong) RACSubject *tableDidSelectSubject;//页面点击
@end
