//
//  LKBaseCollectionViewController.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseCollectionViewController.h"

@interface LKBaseCollectionViewController ()

@end

@implementation LKBaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.mainCollectionView];
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    self.dataSource = [self createDataSource];
    //初始化加载数据
    [self.dataSource.refreshDataCommand execute:nil];
    
    
    @weakify(self);
    
    [self.dataSource.refreshEndSubject subscribeNext:^(id x) {
        NSLog(@"x =%@",x);
        
        @strongify(self);
        
        [self.mainCollectionView reloadData];
        
        if ([x integerValue] == FooterRefresh_HasMoreData) {
            [self.mainCollectionView.mj_footer resetNoMoreData];
            [self.mainCollectionView.mj_footer endRefreshing];
            
            if(self.mainCollectionView.mj_footer == nil){
                self.mainCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    [self.dataSource.nextPageCommand execute:nil];
                }];
            }
            
            
        }else if ([x integerValue] == FooterRefresh_HasNoMoreData){
            [self.mainCollectionView.mj_footer endRefreshingWithNoMoreData];
//            self.mainCollectionView.mj_footer = nil;
            
        }else{
            [self.mainCollectionView.mj_header endRefreshing];
        }
        
    }];
    
    
}

//初始化上拉刷新
-(void)conFigTableRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.mainCollectionView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshUI)];
    
    //    // 马上进入刷新状态
    //    [self.mainTableView.mj_header beginRefreshing];
    
}
//初始化下拉加载
-(void)conFigTableLoadMoreData
{
    self.mainCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUI)];
}


//上拉刷新
-(void)refreshUI{
    NSLog(@"下拉刷新 refreshUI");
    [self.dataSource.refreshDataCommand execute:nil];
}
//下拉加载
-(void)loadMoreUI
{
    NSLog(@"loadMoreUI");
    [self.dataSource.nextPageCommand execute:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - create base views=---重写
//设置代理
- (LKBaseCollectionViewModel*)createDataSource
{
    return nil;
    
}
- (UICollectionViewFlowLayout*)createLayOut
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    return layout;
}
- (Class)collectionCellClass
{
    return nil;
}

- (Class)collectionHeaderReusableViewClass//section  header
{
    return nil;

}
- (Class)collectionFooterReusableViewClass//section  footer
{
    return nil;
}

//lazy
-(UICollectionView *)mainCollectionView
{
    if (_mainCollectionView == nil) {
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[self createLayOut]];
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        _mainCollectionView.dataSource = [self createDataSource];
        _mainCollectionView.delegate = [self createDataSource];
        _mainCollectionView.showsVerticalScrollIndicator = NO;
        _mainCollectionView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1/1.0];
        
        [_mainCollectionView registerClass:[LKBaseCollectionViewCell class] forCellWithReuseIdentifier:@"LKBaseCollectionViewCell"];

        [_mainCollectionView registerClass:[self collectionCellClass] forCellWithReuseIdentifier:NSStringFromClass([self collectionCellClass])];
        
        if ([self collectionHeaderReusableViewClass]!=nil) {
            [_mainCollectionView registerClass:[self collectionHeaderReusableViewClass]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([self collectionHeaderReusableViewClass])];
        }
        if ([self collectionFooterReusableViewClass]!=nil) {
            [_mainCollectionView registerClass:[self collectionFooterReusableViewClass]forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([self collectionFooterReusableViewClass])];
        }

    }
    return _mainCollectionView;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
