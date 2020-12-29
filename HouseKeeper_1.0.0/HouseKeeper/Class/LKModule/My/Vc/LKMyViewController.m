//
//  LKMyViewController.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/10.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKMyViewController.h"
#import "LKMyViewModel.h"
#import "LKMyHeadView.h"
#import "LKPersonEditVc.h"
#import "Dialog.h"
#import "LKForgetPasswordVC.h"
#import "LKLoginVC.h"
#import "LKQualityHistoryVC.h"
#import "LKVommunityVC.h"

@interface LKMyViewController ()

@property(nonatomic,strong)LKMyViewModel * myViewModel;
@property(nonatomic,strong) LKMyHeadView *headView;

@end

@implementation LKMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTableView.backgroundColor = LKF2Color;
    self.mainTableView.delegate = self.myViewModel;
    self.mainTableView.dataSource = self.myViewModel;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navBarTitle = @"我的";/// 设置标题
    
     [self updataMessage];
     [self createUI];
   
   
    
    WS(weakSelf);
    self.myViewModel.myCellBlock = ^(NSIndexPath *index){
        if (index.row == 0) {///跳转抽查记录
            DLog(@"抽查");
            LKQualityHistoryVC * vc= [[LKQualityHistoryVC alloc] init];
            vc.regionId = @0;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }
//        else if (index.row == 1){
//           DLog(@"我的小区");
//            LKVommunityVC * vc= [[LKVommunityVC alloc] init];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//
//        }
        else if (index.row == 1){
            DLog(@"修改登录");
            LKForgetPasswordVC * vc= [[LKForgetPasswordVC alloc] init];
            vc.isModify = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
        else if (index.row == 2){
            DLog(@"版本更新");
        }
        else{
            DLog(@"退出登录");
            [weakSelf loginOutAction];
        }
    };
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self getMessageHandle];
     [self setNavigationTop];
    
}

- (void)getMessageHandle {
    
       LKUserInfoModel *model = [LKCustomMethods readUserInfo];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@(model.userId) forKey:@"customerId"];
        self.myViewModel.requestUrl = LKReadPersonInfo;
        self.myViewModel.requestTag = 1;
        self.myViewModel.requestDict = params;
}





-(void)updataMessage
{
    [self.myViewModel.successDataSubject subscribeNext:^(LKMyMessageModel * _Nullable model) {
       
        if ([self.myViewModel.myModel.portrait containsString:@"group"]) {
            NSString *urltring = [NSString stringWithFormat:@"%@%@",LKIconHost,self.myViewModel.myModel.portrait];
            [self.headView.personImageView yy_setImageWithURL:[NSURL URLWithString:urltring] placeholder:[UIImage imageNamed:@"homePicDefault"]];
        }else{
            NSString *urltring = [NSString stringWithFormat:@"%@%@",LKPHPIconHost,self.myViewModel.myModel.portrait];
            [self.headView.personImageView yy_setImageWithURL:[NSURL URLWithString:urltring] placeholder:[UIImage imageNamed:@"homePicDefault"]];
        }
        
        /// 取出数据
        NSMutableAttributedString *nameString = [NSString changeFontAndColor:LK_13font Color:LKLightGrayColor TotalString:[NSString stringWithFormat:@"姓名：%@",self.myViewModel.myModel.NAME] SubStringArray:@[@"姓名："]];
        self.headView.nameLable.attributedText = nameString;
        
        if ([LKCustomTool isBlankString:self.myViewModel.myModel.roleName]) {
            NSMutableAttributedString *identityString = [NSString changeFontAndColor:LK_13font Color:LKLightGrayColor TotalString:[NSString stringWithFormat:@"身份：%@",@"暂无"] SubStringArray:@[@"身份："]];
            self.headView.identityLable.attributedText = identityString;
        }else{
            NSMutableAttributedString *identityString = [NSString changeFontAndColor:LK_13font Color:LKLightGrayColor TotalString:[NSString stringWithFormat:@"身份：%@",self.myViewModel.myModel.roleName] SubStringArray:@[@"身份："]];
            self.headView.identityLable.attributedText = identityString;
        }
        
        
        
        if ([LKCustomTool isBlankString:self.myViewModel.myModel.customerCode]) {
            NSMutableAttributedString *workNumberString = [NSString changeFontAndColor:LK_13font Color:LKLightGrayColor TotalString:[NSString stringWithFormat:@"工号：%@",@"暂无"] SubStringArray:@[@"工号："]];
            self.headView.numberLable.attributedText = workNumberString;
        }else{
            NSMutableAttributedString *workNumberString = [NSString changeFontAndColor:LK_13font Color:LKLightGrayColor TotalString:[NSString stringWithFormat:@"工号：%@",self.myViewModel.myModel.customerCode] SubStringArray:@[@"工号："]];
            self.headView.numberLable.attributedText = workNumberString;
        }
       
    }];
    
     [self.mainTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setNavigationTop];
}

-(void)createUI{
    
    self.headView.bgView.backgroundColor = [UIColor whiteColor];
    NSString *urltring = [NSString stringWithFormat:@"%@%@",LKIconHost,self.myViewModel.myModel.portrait];
    [self.headView.personImageView yy_setImageWithURL:[NSURL URLWithString:urltring] placeholder:[UIImage imageNamed:@"photo_default"]];
    self.headView.personImageView.layer.cornerRadius = 52.5;
    self.headView.personImageView.clipsToBounds = YES;
    [self.headView.idetButton setImage:[UIImage imageNamed:@"notes_icon_edit"] forState:UIControlStateNormal];
    
     @weakify(self);
    [[self.headView.idetButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        LKPersonEditVc *vc = [[LKPersonEditVc alloc] init];
        vc.messageModel = self.myViewModel.myModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    self.mainTableView.tableHeaderView = self.headView;
   
    
}


#pragma mark - 退出登录
-(void)loginOutAction{
    WS(weakSelf);
  [Dialog showCustomAlertViewWithTitle:@"退出登录" message:@"确定要退出本次登录" firstButtonName:@"确定" firstButtonColor:LKLightGrayColor secondButtonName:@"取消" secondButtonColor:LKLightGrayColor  dismissHandler:^(NSInteger index) {
      if (index ==  0) {
         DLog(@"确定");
          LKUserInfoModel *userInfoModel = [LKCustomMethods readUserInfo];
          NSString *mobile = userInfoModel.mobile;
          if (userInfoModel.isRememberPassword == NO) {
              [LKCustomMethods removeUserInfo];
              LKUserInfoModel *userInfo= [[LKUserInfoModel alloc] init];;
              userInfo.mobile = mobile;
              userInfo.isLoginSuccess = NO;
              [LKCustomMethods saveUserInfo:userInfo];
          }else {
              userInfoModel.isLoginSuccess = NO;
              [LKCustomMethods saveUserInfo:userInfoModel];
          }
          LKLoginVC *vc = [[LKLoginVC alloc] init];
          UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
          [weakSelf presentViewController:nav animated:YES completion:nil];
      }
    }];
    
}


//lazy
-(LKMyViewModel *)myViewModel
{
    if (_myViewModel == nil) {
        _myViewModel = [[LKMyViewModel alloc]init];
    }
    return _myViewModel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(LKMyHeadView *)headView{
    if (_headView == nil) {
        _headView = [[LKMyHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 190)];
        _headView.backgroundColor = LKF2Color;
    }
    return _headView;
}

@end
