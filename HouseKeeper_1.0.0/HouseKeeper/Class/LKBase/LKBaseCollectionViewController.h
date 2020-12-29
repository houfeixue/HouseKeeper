//
//  LKBaseCollectionViewController.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseViewController.h"

@interface LKBaseCollectionViewController : LKBaseViewController

@property(nonatomic,strong)UICollectionView *mainCollectionView;
@property (nonatomic, strong) LKBaseCollectionViewModel* dataSource;

- (Class)collectionHeaderReusableViewClass;//section  header
- (Class)collectionFooterReusableViewClass;//section  footer

- (LKBaseTableViewModel*)createDataSource;//delegate



//初始化上拉刷新
-(void)conFigTableRefresh;
//初始化下拉加载
-(void)conFigTableLoadMoreData;



//上拉刷新
-(void)refreshUI;
//下拉加载
-(void)loadMoreUI;
@end
