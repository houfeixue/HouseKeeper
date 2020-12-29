//
//  LKSetPasswordVC.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSetPasswordVC.h"

#import "LKRegisterHeaderView.h"
#import "LKLoginVerifyItemView.h"
#import "LKSetPasswordViewModel.h"
#import "LKMyViewController.h"

@interface LKSetPasswordVC ()
@property (nonatomic, strong) LKRegisterHeaderView *headerView;
@property (nonatomic, strong) LKLoginVerifyItemView *passwordItemView;
@property (nonatomic, strong) LKLoginVerifyItemView *confirmPasswordItemView;
@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, strong) LKSetPasswordViewModel *setPasswordViewModel;
@property (nonatomic, strong) UIScrollView *bgScrollView;
@end

@implementation LKSetPasswordVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarWhiteBackground];
    [self addBlackBackButton];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarWhiteBackground];
    self.navBarTitle = @"设置密码";
    [self createUI];
    [self bindActionHandle];
}
#pragma mark - Action
- (void)bindActionHandle {
    @weakify(self);
    [[self.passwordItemView.verifyTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.length >= 16) {
            x = [x substringToIndex:16];
            self.passwordItemView.verifyTextField.text = x;
        }
    }];
    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.view endEditing:YES];
        if ([self.passwordItemView.verifyTextField.text judgePasswordLegal] == NO) {
            [LKCustomMethods showWindowMessage:@"密码必须是6~16位字母和数字的组合"];
            return ;
        }
        if (![self.passwordItemView.verifyTextField.text isEqualToString:self.confirmPasswordItemView.verifyTextField.text]) {
            [LKCustomMethods showWindowMessage:@"两次密码不一致，请核对之后再次输入"];
            return ;
        }
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:self.mobile forKey:@"mobile"];
        [param setObject:self.authCode forKey:@"authCode"];
        [param setObject:@"3" forKey:@"type"];
        [param setObject:self.passwordItemView.verifyTextField.text forKey:@"newpassword"];
        self.setPasswordViewModel.requestTag = 1;
        self.setPasswordViewModel.requestUrl = LKChangePassword;
        self.setPasswordViewModel.requestDict = param;
    }];
    
    /** 绑定按钮能否点击信号 */
    RAC(self.submitBtn, enabled) = self.setPasswordViewModel.enableSubmitSignal;
    RAC(self.submitBtn, backgroundColor) = self.setPasswordViewModel.submitBtnColorSignal;
    RAC(self.setPasswordViewModel.setPasswordModel, password) = self.passwordItemView.verifyTextField.rac_textSignal;
    RAC(self.setPasswordViewModel.setPasswordModel, confirmPassword) = self.confirmPasswordItemView.verifyTextField.rac_textSignal;
    [self.setPasswordViewModel.passwordSetSuccessSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        LKUserInfoModel *userInfoModel = [LKCustomMethods readUserInfo];
        userInfoModel.localPassword = self.passwordItemView.verifyTextField.text;
        [LKCustomMethods saveUserInfo:userInfoModel];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changePasswordSuccess" object:nil];
        [LKCustomMethods showWindowMessage:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.isModify) {
                UINavigationController *navVC = self.navigationController;
                NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
                for (UIViewController *vc in [navVC viewControllers]) {
                    [viewControllers addObject:vc];
                    if ([vc isKindOfClass:[LKMyViewController class]]) {
                        break;
                    }
                }
                [navVC setViewControllers:viewControllers animated:YES];
            }else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        });
    }];
}
#pragma mark - UI
- (void)createUI {
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self createHeaderView];
    [self createItemView];
    [self.bgScrollView addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.confirmPasswordItemView.mas_bottom).offset(kAdaptiveValue(40));
        make.left.mas_equalTo(kAdaptiveValue(15));
        make.right.equalTo(self.bgScrollView.mas_right).inset(15);
        make.height.mas_equalTo(kAdaptiveValue(49));
        make.bottom.greaterThanOrEqualTo(self.bgScrollView.mas_bottom).inset(kAdaptiveValue(245));
        
    }];
    self.submitBtn.layer.cornerRadius = 5.0f;
    [self.view layoutIfNeeded];
    CGFloat maxHeight = CGRectGetMaxY(self.submitBtn.frame);
    if (maxHeight > kScreen_Height - kStatusBarHeight - kNavBarHeight ) {
        self.bgScrollView.contentSize = CGSizeMake(kScreen_Width, maxHeight);
    }else {
        self.bgScrollView.contentSize = CGSizeMake(kScreen_Width, kScreen_Height - kStatusBarHeight - kNavBarHeight + 1);
    }
}
- (void)createHeaderView {
    [self.bgScrollView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.right.equalTo(self.bgScrollView.mas_right);
        make.width.mas_equalTo(kScreen_Width);
    }];
    self.headerView.titleNameLabel.text = @"重新设置您的密码";
    self.headerView.titleNameDescLabel.text = @"建议：怎么好记怎么来哦";
}
- (void)createItemView {
    [self.bgScrollView addSubview:self.passwordItemView];
    [self.passwordItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.headerView.mas_bottom).offset(kAdaptiveValue(100));
        make.right.equalTo(self.bgScrollView.mas_right);
        make.height.mas_equalTo(kAdaptiveValue(43));
        make.width.mas_equalTo(kScreen_Width);
    }];
    [self.passwordItemView bindRegisterDataWithIconImage:@"app_icon_password" placeholder:@"请输入新密码" textFieldText:@""];
    [self.bgScrollView addSubview:self.confirmPasswordItemView];
    [self.confirmPasswordItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.passwordItemView.mas_bottom);
        make.right.equalTo(self.bgScrollView.mas_right);
        make.height.mas_equalTo(kAdaptiveValue(43));
        make.width.mas_equalTo(kScreen_Width);
    }];
    [self.confirmPasswordItemView bindRegisterDataWithIconImage:@"app_icon_password" placeholder:@"请再次输入新密码" textFieldText:@""];
}

#pragma mark - lazy
- (UIScrollView *)bgScrollView {
    if (_bgScrollView == nil) {
        _bgScrollView = [[UIScrollView alloc] init];
    }
    return _bgScrollView;
}
- (LKRegisterHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[LKRegisterHeaderView alloc] init];
    }
    return _headerView;
}
- (LKLoginVerifyItemView *)passwordItemView {
    if (_passwordItemView == nil) {
        _passwordItemView = [[LKLoginVerifyItemView alloc] init];
        _passwordItemView.verifyTextField.clearsOnBeginEditing = NO;
    }
    return _passwordItemView;
}
- (LKLoginVerifyItemView *)confirmPasswordItemView {
    if (_confirmPasswordItemView == nil) {
        _confirmPasswordItemView = [[LKLoginVerifyItemView alloc] init];
        _confirmPasswordItemView.verifyTextField.clearsOnBeginEditing = NO;
    }
    return _confirmPasswordItemView;
}

- (UIButton *)submitBtn {
    if (_submitBtn == nil) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:@"确认" forState:UIControlStateNormal];
        _submitBtn.backgroundColor = LKBlackColor;
        _submitBtn.titleLabel.font = LK_18font;
    }
    return _submitBtn;
}
- (LKSetPasswordViewModel *)setPasswordViewModel {
    if (_setPasswordViewModel == nil) {
        _setPasswordViewModel = [[LKSetPasswordViewModel alloc] init];
    }
    return _setPasswordViewModel;
}
- (LKRequestViewModel *)createDataSource {
    return self.setPasswordViewModel;
}
@end

