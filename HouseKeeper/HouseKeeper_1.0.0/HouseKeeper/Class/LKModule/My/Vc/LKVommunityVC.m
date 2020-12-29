//
//  LKVommunityVC.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/7/31.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKVommunityVC.h"
#import "LKMyCommunityViewModel.h"

@interface LKVommunityVC ()
@property(nonatomic,strong)LKMyCommunityViewModel *viewModel;
@end

@implementation LKVommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarTitle = @"我的小区";
    self.mainTableView.backgroundColor = LKF2Color;
    self.mainTableView.delegate = self.viewModel;
    self.mainTableView.dataSource = self.viewModel;
    
     [self.mainTableView reloadData];
    WS(weakSelf);
    self.viewModel.CommunityCellBlock = ^(NSIndexPath *index){
        [weakSelf showAlertWithCustomView];
    };
}

#pragma mark - 自定义弹框
-(void)showAlertWithCustomView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 382)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 7;
    bgView.clipsToBounds = YES;
    
    UIImageView * pic = [[UIImageView alloc] init];
    pic.image = [UIImage imageNamed:@"submissionfailure"];
    [bgView addSubview:pic];
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.text = @"审核失败";
    titleLable.textColor = LKGrayColor;
    titleLable.font = LK_medium_20font;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLable];
    
    UILabel *tipLable = [[UILabel alloc] init];
    tipLable.text = @"您输入的信息有误，请重新认证";
    tipLable.textColor = LKGrayColor;
    tipLable.font = LK_16font;
    tipLable.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:tipLable];
    
    UIButton *reCommitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reCommitButton.backgroundColor = LKBlackColor;
    reCommitButton.layer.cornerRadius = 8;
    reCommitButton.clipsToBounds = YES;
    [reCommitButton setTitle:@"重新认证" forState:UIControlStateNormal];
    
    
    [[reCommitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        DLog(@"点击了重新认证");
    }];
    
    [pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top).inset(25);
        make.centerY.equalTo(bgView.mas_centerY);
        make.width.height.mas_equalTo(160);
    }];
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left);
        make.right.equalTo(bgView.mas_right);
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(LKMyCommunityViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[LKMyCommunityViewModel alloc] init];
    }
    return _viewModel;
}

@end
