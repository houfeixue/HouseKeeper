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
//#import "PersonEditVc.h"
#import "Dialog.h"
#import "LKForgetPasswordVC.h"
#import "LKLoginVC.h"
#import "LKQualityHistoryVC.h"

@interface LKMyViewController ()

@property(nonatomic,strong)LKMyViewModel * myViewModel;
@property(nonatomic,strong) LKMyHeadView *headView;

@end

@implementation LKMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.mainTableView.backgroundColor = LKBlackColor;
    self.mainTableView.delegate = self.myViewModel;
    self.mainTableView.dataSource = self.myViewModel;
    self.navBarTitle = @"我的";/// 设置标题
    [self createUI];
    
     [self bindActionHandle];
    
    WS(weakSelf);
    self.myViewModel.myCellBlock = ^(NSIndexPath *index){
        if (index.row == 0) {///跳转抽查记录
            DLog(@"抽查");
            LKQualityHistoryVC * vc= [[LKQualityHistoryVC alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }else if (index.row == 1){
           DLog(@"修改登录");
            LKForgetPasswordVC * vc= [[LKForgetPasswordVC alloc] init];
            vc.isModify = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            DLog(@"退出登录");
            [weakSelf loginOutAction];
        }
    };
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setNavigationTop];
}

-(void)createUI{
    self.mainTableView.backgroundColor = [UIColor lightGrayColor];
    
    self.headView.bgView.backgroundColor = [UIColor whiteColor];
    [self.headView.personImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"photo_default"]];
    self.headView.personImageView.layer.cornerRadius = 52.5;
    self.headView.personImageView.clipsToBounds = YES;
    [self.headView.idetButton setImage:[UIImage imageNamed:@"notes_icon_edit"] forState:UIControlStateNormal];
    
     @weakify(self);
    [[self.headView.idetButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
//        LKRegisterVC *vc = [[LKRegisterVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    /// 取出数据
    NSMutableAttributedString *nameString = [NSString changeFontAndColor:LK_13font Color:LKLightGrayColor TotalString:@"姓名：胡林" SubStringArray:@[@"姓名："]];
    self.headView.nameLable.attributedText = nameString;

    NSMutableAttributedString *identityString = [NSString changeFontAndColor:LK_13font Color:LKLightGrayColor TotalString:@"身份：搬砖工" SubStringArray:@[@"身份："]];
    self.headView.identityLable.attributedText = identityString;
    NSMutableAttributedString *workNumberString = [NSString changeFontAndColor:LK_13font Color:LKLightGrayColor TotalString:@"工号：1136" SubStringArray:@[@"工号："]];
    self.headView.numberLable.attributedText = workNumberString;
    self.mainTableView.tableHeaderView = self.headView;
    [self.mainTableView reloadData];
    
}

#pragma mark - 编辑事件点击
-(void)bindActionHandle{
    /*
    @weakify(self);
    [[self.headView.aditButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        PersonEditVc * editPersonMessage = [[PersonEditVc alloc] init];
        [self.navigationController pushViewController:editPersonMessage animated:YES];        
    }];
     */
}

#pragma mark - 退出登录
-(void)loginOutAction{
    WS(weakSelf);
  [Dialog showCustomAlertViewWithTitle:@"退出登录" message:@"确定要退出本次登录" firstButtonName:@"确定" firstButtonColor:LKLightGrayColor secondButtonName:@"取消" secondButtonColor:LKLightGrayColor  dismissHandler:^(NSInteger index) {
      if (index ==  0) {
         DLog(@"确定");
          [LKCustomMethods removeUserInfo];
          
          LKLoginVC *vc = [[LKLoginVC alloc] init];
          [weakSelf presentViewController:vc animated:YES completion:nil];
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
        _headView.backgroundColor = [UIColor greenColor];
    }
    return _headView;
}

@end
