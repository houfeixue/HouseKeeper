//
//  LKBaseCollectionViewModel.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKRequestViewModel.h"

@interface LKBaseCollectionViewModel : LKRequestViewModel<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray* dataArray;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) RACCommand* refreshDataCommand;//刷新请求
@property (nonatomic, strong) RACSubject *refreshLoadData;//刷新加载数据
@property (nonatomic, strong) RACCommand* nextPageCommand;//上拉加载


@property (nonatomic, strong) RACSubject *refreshUI;//结束上拉加载
@property (nonatomic, strong) RACSubject *refreshEndSubject;//结束下拉加载
@property (nonatomic, strong) RACSubject *cellClickSubject;//cell点击

- (Class)CollectCellClass:(NSIndexPath *)indexPath;


@end
