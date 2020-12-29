//
//  LKBaseTableViewController.m
//  Project
//
//  Created by heshenghui on 2018/7/6.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewController.h"

@interface LKBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation LKBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainTableView];
    
    LKBaseTableViewModel * dataSource = [self createDataSource];
    dataSource.vcView = self.view;
    self.mainTableView.delegate = dataSource ;
    self.mainTableView.dataSource = dataSource;
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    self.dataSource = [self createDataSource];
    //初始化加载数据
    [self.dataSource.refreshDataCommand execute:nil];
    
    
    //上拉加载是否存在
     @weakify(self);
    [self.dataSource.refreshEndSubject subscribeNext:^(id x) {
        NSLog(@"x =%@",x);
        
        @strongify(self);
        
        [self.mainTableView reloadData];
        if (self.mainTableView.mj_header) {
            [self.mainTableView.mj_header endRefreshing];
        }
        
        if ([x integerValue] == FooterRefresh_HasMoreData) {
            

            [self.mainTableView.mj_footer endRefreshing];
            
            if(self.mainTableView.mj_footer == nil){
                [self conFigTableLoadMoreData];
            }
            
            
        }else if ([x integerValue] == FooterRefresh_HasNoMoreData){
            [self.mainTableView.mj_footer endRefreshingWithNoMoreData];

//            [self.mainTableView.mj_header endRefreshing];
//            self.mainTableView.mj_footer = nil;
            
        }else{
            [self.mainTableView.mj_header endRefreshing];
        }
        
    }];
    
}

//初始化上拉刷新
-(void)conFigTableRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.mainTableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshUI)];
    
//    // 马上进入刷新状态
//    [self.mainTableView.mj_header beginRefreshing];
    
}
//初始化下拉加载
-(void)conFigTableLoadMoreData
{
     self.mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUI)];
    self.mainTableView.mj_footer.ignoredScrollViewContentInsetBottom = kSafeAreaBottomHeight;
}
//下拉刷新
-(void)refreshUI
{
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    return cell;
}

//lazy
-(UITableView *)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]init];
        [_mainTableView registerClass:[self tableCellClass] forCellReuseIdentifier:NSStringFromClass([self tableCellClass])];
        [_mainTableView registerClass:[LKBaseTableViewCell class] forCellReuseIdentifier:@"LKBaseTableViewCell"];
        _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.backgroundColor =  [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1/1.0];
                
    }
    return _mainTableView;
}
-(RACSubject *)refreshSubject
{
    if (_refreshSubject == nil) {
        _refreshSubject = [[RACSubject alloc]init];
    }
    return _refreshSubject;
}

-(LKBaseTableViewModel *)dataSourceModel//ViewModel- delegate
{
    return nil;

}
- (Class)dataSourceClass
{
    return [LKBaseTableViewModel class];
}
- (Class)tableCellClass//cell
{
    return [LKBaseTableViewCell class];

}
- (LKBaseTableViewModel*)createDataSource {
    return [[LKBaseTableViewModel alloc] init];

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
