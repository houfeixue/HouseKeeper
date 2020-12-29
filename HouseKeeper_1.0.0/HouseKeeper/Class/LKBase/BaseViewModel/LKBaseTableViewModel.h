//
//  LKBaseTableViewModel.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/10.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseViewModel.h"
#import "LKRequestViewModel.h"

typedef enum : NSUInteger {
    HeaderRefresh_HasMoreData = 1,
    HeaderRefresh_HasNoMoreData,
    FooterRefresh_HasMoreData,
    FooterRefresh_HasNoMoreData,
    RefreshError,
    RefreshUI,
} RefreshDataStatus;

@interface LKBaseTableViewModel : LKRequestViewModel<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray* dataArray;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;



@property (nonatomic, strong) RACCommand* refreshDataCommand;//下拉刷新
@property (nonatomic, strong) RACCommand* nextPageCommand;//上拉加载

@property (nonatomic, strong) RACSubject *refreshLoadData;//刷新加载数据

@property (nonatomic, strong) RACSubject *refreshUI;//结束上拉加载
@property (nonatomic, strong) RACSubject *refreshEndSubject;//结束下拉加载

@property (nonatomic, strong) RACSubject *cellClickSubject;//cell点击


@end
