//
//  LKMyViewModel.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/11.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKRequestViewModel.h"
#import "LKMyMessageModel.h"

@interface LKMyViewModel : LKRequestViewModel<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) LKMyMessageModel *myModel;

@property(nonatomic,copy) void(^myCellBlock)(NSIndexPath *index);

@property (nonatomic, strong) RACSubject *successDataSubject;
@property (nonatomic, strong) NSString *requestUrl;//请求接口地址
@property (nonatomic, strong) NSDictionary *requestDict;//请求接口参数

@end
