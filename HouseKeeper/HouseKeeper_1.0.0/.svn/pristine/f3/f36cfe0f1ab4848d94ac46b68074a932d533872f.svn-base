//
//  LKBaseTableViewController.h
//  Project
//
//  Created by heshenghui on 2018/7/6.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseViewController.h"

@interface LKBaseTableViewController : LKBaseViewController
@property(nonatomic,strong)UITableView * mainTableView;
@property (nonatomic, strong) RACSubject *refreshSubject;//上拉刷新
@property (nonatomic, strong) RACSubject *loadMoreSubject;//下拉加载

@property (nonatomic, strong) LKBaseTableViewModel* dataSource;

//初始化上拉刷新
-(void)conFigTableRefresh;
//初始化下拉加载
-(void)conFigTableLoadMoreData;

//上拉刷新
-(void)refreshUI;
//下拉加载
-(void)loadMoreUI;



- (Class)dataSourceClass;//delegate

- (Class)tableCellClass;//cell

- (LKBaseTableViewModel*)createDataSource;//delegate
-(LKBaseTableViewModel *)dataSourceModel;//ViewModel- delegate

@end
