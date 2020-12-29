//
//  LKWorkRecordViewModel.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewModel.h"
#import "LKWorkRecordCell.h"

@interface LKWorkRecordViewModel : LKBaseTableViewModel
@property (nonatomic, strong) NSString *requestUrl;//请求接口地址
@property (nonatomic, strong) NSDictionary *requestDict;//请求接口参数

@property (nonatomic, strong) RACSubject *loadDataSubject;
@end
