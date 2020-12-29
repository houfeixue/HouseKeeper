//
//  LKQualityListViewModel.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/16.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewModel.h"

@interface LKQualityListViewModel : LKBaseTableViewModel
@property (nonatomic, strong) NSString *requestUrl;//请求接口地址
@property (nonatomic, strong) NSDictionary *requestDict;//请求接口参数


@property (nonatomic, copy) NSString *sumbit;//提交按钮


@end
