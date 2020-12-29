//
//  LKWorkPicUpLoadViewController.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/30.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKWorkPicUpLoadViewController.h"
#import "LKWorkUpLoadViewCell.h"
#import "LKWorkUpLoadViewModel.h"
#import "LKQualityListModel.h"
#import "LKQualityListNavTitleView.h"
#import "LKSelectListView.h"
#import "LKPIctureUploadManager.h"

@interface LKWorkPicUpLoadViewController ()

@property(nonatomic,strong)LKWorkUpLoadViewModel * workUpLoadViewModel;

@property (nonatomic, strong) LKQualityListNavTitleView *qulaityListHeaderView;
@property (nonatomic, strong) LKSelectListView *selectListView;

@property (nonatomic, copy) NSNumber * commity;//获取小区ID
@property (nonatomic, strong) NSNumber * userType;//用户类型


@end

@implementation LKWorkPicUpLoadViewController
/**  */
-(Class)tableCellClass
{
    return [LKWorkUpLoadViewCell class];
}

- (LKBaseTableViewModel*)createDataSource
{
    return self.workUpLoadViewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航栏
    [self addTitleViewWithTitle:self.qulaityListHeaderView];
    [self.qulaityListHeaderView setTitleViewText:@"小区名称" withClick:NO];
    self.selectListView ;

    @weakify(self);
    
    
    [self.workUpLoadViewModel.cellClickSubject subscribeNext:^(id x) {
        @strongify(self)
        
        
        if ([x isKindOfClass:[NSString class]]) {
            NSString * str = x;
            if ([str isEqualToString:@"mainViewRolad"]) {
                [self.mainTableView reloadData];
            }
        }else if ([x isKindOfClass:[NSDictionary class]]){
            NSDictionary * dict = (NSDictionary *)x;
            NSString *type = [dict stringForKey:@"type"];
            
            if ([type isEqualToString:@"upload"]) {
                LKQualityListModel *model = [dict objectForKey:@"data"];
                DLog(@"model.ruleId : %@",model.ruleId);
                
                [LKCustomMethods saveUpLoadImages:self.imageArray withCategoryId:model.detailId withCommityId:self.commity];
                [[LKPIctureUploadManager shareInstance] startUpLoadimage];
                
                if (self.pictureUploadClick) {
                    self.pictureUploadClick(0);
                }

                [LKCustomMethods showWindowMessage:@"图片正在上传"];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
    }];
}
//load
-(void)requestData
{
    
    LKUserInfoModel *model = [LKCustomMethods readUserInfo];
    
    self.workUpLoadViewModel.requestUrl = LKGetCheckByBrunchId;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@(model.userId) forKey:@"managerId"];
    [dict setObject:self.commity forKey:@"applyRresidenceiIds"];
    [dict setObject:self.userType forKey:@"applyrRoleIds"];
    self.workUpLoadViewModel.requestTag = 1;
    self.workUpLoadViewModel.requestDict = dict;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//lazy
-(LKWorkUpLoadViewModel *)workUpLoadViewModel
{
    if (_workUpLoadViewModel == nil) {
        _workUpLoadViewModel = [[LKWorkUpLoadViewModel alloc]init];
    }
    return _workUpLoadViewModel;
}
-(LKQualityListNavTitleView *)qulaityListHeaderView
{
    if (_qulaityListHeaderView == nil) {
        _qulaityListHeaderView = [[LKQualityListNavTitleView alloc]init];
        WS(weakSelf)
        _qulaityListHeaderView.qualityNavTitleClick = ^(NSString *status) {
            weakSelf.selectListView.selectCommityId = weakSelf.commity;

            [weakSelf.view addSubview:weakSelf.selectListView];
            [weakSelf.selectListView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(weakSelf.view);
            }];
            
        };
    }
    return _qulaityListHeaderView;
}

-(LKSelectListView *)selectListView
{
    if (_selectListView == nil) {
        
        LKUserInfoModel *model = [LKCustomMethods readUserInfo];
        
        _selectListView = [[LKSelectListView alloc]init];
        
        
        _selectListView.selectViewModel.requestUrl = LKGetCommunity;
        _selectListView.selectViewModel.requestDict = @{@"customerId":@(model.userId)};
        WS(weakSelf)
        _selectListView.selectListClick = ^(LKCommityModel *model,NSInteger count) {
            [weakSelf.qulaityListHeaderView setTitleViewText:model.name withClick:count>1 ? YES: NO];
            weakSelf.commity = model.Id;
            weakSelf.userType = model.type;

            [weakSelf requestData];
            
            [weakSelf.selectListView removeFromSuperview];
        };
        
        
    }
    return _selectListView;
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
