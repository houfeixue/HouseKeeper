//
//  ViewController.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/13.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "ViewController.h"
#import "LKCalendarVC.h"
#import "LKCalendarView.h"
#import "Dialog.h"
#import "LKWorkRecordVC.h"
#import "LKPictureHandleVC.h"
#import "LKLoginVC.h"
#import "LKAddPictureItemView.h"
#import "LKAddWorkDescriptionItemView.h"
#import "LKMyViewController.h"
#import "LKHomePageVc.h"

@interface ViewController ()<LKAddPictureItemViewDelegate,LKAddWorkDescriptionItemViewDelegate>
@property (nonatomic, strong) LKCalendarView *calendarView;
@property (nonatomic, strong) LKAddPictureItemView *pictureItemView;
@property (nonatomic, strong) UIView *myView;
@property (nonatomic, strong) LKAddWorkDescriptionItemView *workDescriptionItemView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.backgroundColor = [UIColor redColor];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 200, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"日历" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    @weakify(self)
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        LKWorkRecordVC *vc = [[LKWorkRecordVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
//         self.pictureItemView.isAllowLongPressShowDeleteBtn = !self.pictureItemView.isAllowLongPressShowDeleteBtn;

    }];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 200, 200, 50);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"图片合成" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    [[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        LKPictureHandleVC *vc = [[LKPictureHandleVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(100, 300, 200, 50);
    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    [[btn3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        LKLoginVC *vc = [[LKLoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
//        [self.pictureItemView hiddenPictureDeteleBtn];
        
    }];
    
    /// 个人中心
//    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn4.frame = CGRectMake(100, 500, 200, 50);
//    btn4.backgroundColor = [UIColor redColor];
//    [btn4 setTitle:@"个人中心" forState:UIControlStateNormal];
//    [self.view addSubview:btn4];
//    [[btn4 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self)
//        LKMyViewController *vc = [[LKMyViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }];
    

    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(100, 500, 200, 50);
    btn4.backgroundColor = [UIColor redColor];
    [btn4 setTitle:@"首页" forState:UIControlStateNormal];
    [self.view addSubview:btn4];
    [[btn4 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        LKHomePageVc *vc = [[LKHomePageVc alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    
//    self.pictureItemView.frame = CGRectMake(0, 400, kScreen_Width, 150);
//    [self.view addSubview:self.pictureItemView];
//    [self.pictureItemView bindPictureData:[@[[UIImage imageNamed:@"456"],[UIImage imageNamed:@"456"],[UIImage imageNamed:@"456"],[UIImage imageNamed:@"456"],[UIImage imageNamed:@"456"]] mutableCopy] titleName:@"工作照片"];
    
    self.workDescriptionItemView.frame = CGRectMake(0, 400, kScreen_Width, 50);
    [self.view addSubview:self.workDescriptionItemView];

}
#pragma mark - pictViewDelegate
- (void)LKAddPictureItemViewDelegateViewHeight:(CGFloat)pictureViewHeight {
    self.pictureItemView.frame = CGRectMake(0, 400, kScreen_Width, pictureViewHeight);
}

- (void)LKAddWorkDescriptionItemViewDelegateViewHeight:(CGFloat)viewHeight {
    self.workDescriptionItemView.frame = CGRectMake(0, 400, kScreen_Width, viewHeight);
    [self.view layoutIfNeeded];
}
- (void)rightBtnClick {
    [self.calendarView.calendar selectDate:[NSDate getNewDateWithIntervalYear:0 intervalMonth:-9 intervalDay:0 currentDate:[NSDate date]] scrollToDate:YES];
}
- (LKAddPictureItemView *)pictureItemView {
    if (_pictureItemView == nil) {
        _pictureItemView = [[LKAddPictureItemView alloc] init];
        _pictureItemView.delegate = self;
    }
    return _pictureItemView;
}
- (LKAddWorkDescriptionItemView *)workDescriptionItemView {
    if (_workDescriptionItemView == nil) {
        _workDescriptionItemView = [[LKAddWorkDescriptionItemView alloc] init];
        _workDescriptionItemView.delegate = self;
    }
    return _workDescriptionItemView;
}
@end
