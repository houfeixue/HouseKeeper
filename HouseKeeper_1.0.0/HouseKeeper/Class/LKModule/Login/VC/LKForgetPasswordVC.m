//
//  LKForgetPasswordVC.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKForgetPasswordVC.h"
#import "LKRegisterHeaderView.h"
#import "LKLoginAccountItemView.h"
#import "LKLoginVerifyItemView.h"
#import "LKForgetPasswordViewModel.h"
#import "LKSetPasswordVC.h"

@interface LKForgetPasswordVC ()
@property (nonatomic, strong) LKRegisterHeaderView *headerView;
@property (nonatomic, strong) LKLoginAccountItemView *accountItemView;
@property (nonatomic, strong) LKLoginVerifyItemView *verifyItemView;
@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, strong) LKForgetPasswordViewModel *forgetPasswordViewModel;
@property (nonatomic, strong) UIScrollView *bgScrollView;
@end

@implementation LKForgetPasswordVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarWhiteBackground];
    [self addBlackBackButton];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarWhiteBackground];
    [self createUI];
    if (self.isModify == YES) {
        self.navBarTitle = @"修改密码";
        LKUserInfoModel *userInfo = [LKCustomMethods readUserInfo];
        if (userInfo != nil && [LKCustomTool isBlankString:userInfo.mobile] == NO) {
            self.accountItemView.accountTextField.text = userInfo.mobile;
            [self.accountItemView.accountTextField sendActionsForControlEvents:UIControlEventEditingChanged];
            self.accountItemView.accountTextField.userInteractionEnabled = NO;
        }
    }else{
        self.navBarTitle = @"找回密码";
        self.accountItemView.accountTextField.userInteractionEnabled = YES;
    }
    [self bindActionHandle];
}
#pragma mark - Action
- (void)bindActionHandle {
    @weakify(self);
    [[self.accountItemView.accountTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.length >= 11) {
            x = [x substringToIndex:11];
            self.accountItemView.accountTextField.text = x;
        }
    }];
    [[self.verifyItemView.verifyTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.length >= 4) {
            x = [x substringToIndex:4];
            self.verifyItemView.verifyTextField.text = x;
        }
    }];
    [[self.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.view endEditing:YES];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"3" forKey:@"type"];
        [params setObject:self.accountItemView.accountTextField.text forKey:@"mobile"];
        [params setObject:self.verifyItemView.verifyTextField.text forKey:@"authCode"];
        self.forgetPasswordViewModel.requestUrl = LKVerifyAuthCode;
        self.forgetPasswordViewModel.requestTag = 2;
        self.forgetPasswordViewModel.requestDict = params;
 
    }];
    [[self.verifyItemView.verifyCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.view endEditing:YES];
        if ([LKCustomTool isBlankString:self.accountItemView.accountTextField.text] == NO) {
            NSString *firstWord = [self.accountItemView.accountTextField.text substringToIndex:1];
            if (![firstWord isEqualToString:@"1"]) {
                [LKCustomMethods showWindowMessage:@"请输入正确的手机号"];
                return ;
            }
        }
        if (self.accountItemView.accountTextField.text.length != 11 ) {
            [LKCustomMethods showWindowMessage:@"请输入正确的手机号"];
            return ;
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"3" forKey:@"type"];
        [params setObject:self.accountItemView.accountTextField.text forKey:@"mobile"];
        self.forgetPasswordViewModel.requestUrl = LKSendAuthCode;
        self.forgetPasswordViewModel.requestTag = 1;
        self.forgetPasswordViewModel.requestDict = params;
        
    }];
    /** 绑定按钮能否点击信号 */
    RAC(self.nextBtn, enabled) = self.forgetPasswordViewModel.enableNextSignal;
    RAC(self.nextBtn, backgroundColor) = self.forgetPasswordViewModel.nextBtnColorSignal;
    RAC(self.forgetPasswordViewModel.forgetPasswordModel, userName) = self.accountItemView.accountTextField.rac_textSignal;
    RAC(self.forgetPasswordViewModel.forgetPasswordModel, verifyCode) = self.verifyItemView.verifyTextField.rac_textSignal;
    [self netSingalHandle];
}
- (void)netSingalHandle {
    @weakify(self);
    [self.forgetPasswordViewModel.verifySuccessSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        LKSetPasswordVC *vc = [[LKSetPasswordVC alloc] init];
        vc.authCode = self.verifyItemView.verifyTextField.text;
        vc.mobile = self.accountItemView.accountTextField.text;
        vc.isModify = self.isModify;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    [self.forgetPasswordViewModel.verifyCodeSendSuccessSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        /// 倒计时
        [self.verifyItemView verifyBtnSignal];
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
    [self.bgScrollView addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyItemView.mas_bottom).offset(kAdaptiveValue(40));
        make.left.mas_equalTo(kAdaptiveValue(15));
        make.right.equalTo(self.bgScrollView.mas_right).inset(15);
        make.height.mas_equalTo(kAdaptiveValue(49));
        make.bottom.greaterThanOrEqualTo(self.bgScrollView.mas_bottom).inset(kAdaptiveValue(245));
        
    }];
    self.nextBtn.layer.cornerRadius = 5.0f;
    [self.view layoutIfNeeded];
    CGFloat maxHeight = CGRectGetMaxY(self.nextBtn.frame);
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
    self.headerView.titleNameLabel.text = @"请输入以下信息";
    self.headerView.titleNameDescLabel.text = @"2步即可完成操作哦";
}
- (void)createItemView {
    [self.bgScrollView addSubview:self.accountItemView];
    [self.accountItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.headerView.mas_bottom).offset(kAdaptiveValue(100));
        make.right.equalTo(self.bgScrollView.mas_right);
        make.height.mas_equalTo(kAdaptiveValue(43));
        make.width.mas_equalTo(kScreen_Width);
    }];
    [self.accountItemView bindDataWithIconImage:@"app_icon_name" placeholder:@"请输入手机号" textFieldText:@""];
    [self.bgScrollView addSubview:self.verifyItemView];
    [self.verifyItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.accountItemView.mas_bottom);
        make.right.equalTo(self.bgScrollView.mas_right);
        make.height.mas_equalTo(kAdaptiveValue(43));
        make.width.mas_equalTo(kScreen_Width);
    }];
    [self.verifyItemView bindQuickDataWithIconImage:@"app_icon_messages" placeholder:@"请输入验证码" textFieldText:@""];
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
- (LKLoginAccountItemView *)accountItemView {
    if (_accountItemView == nil) {
        _accountItemView = [[LKLoginAccountItemView alloc] init];
        _accountItemView.accountTextField.keyboardType = UIKeyboardTypeNumberPad;
        _accountItemView.accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _accountItemView;
}
- (LKLoginVerifyItemView *)verifyItemView {
    if (_verifyItemView == nil) {
        _verifyItemView = [[LKLoginVerifyItemView alloc] init];
        _verifyItemView.verifyTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _verifyItemView;
}

- (UIButton *)nextBtn {
    if (_nextBtn == nil) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.backgroundColor = LKBlackColor;
        _nextBtn.titleLabel.font = LK_18font;
    }
    return _nextBtn;
}
- (LKForgetPasswordViewModel *)forgetPasswordViewModel {
    if (_forgetPasswordViewModel == nil) {
        _forgetPasswordViewModel = [[LKForgetPasswordViewModel alloc] init];
    }
    return _forgetPasswordViewModel;
}
- (LKRequestViewModel *)createDataSource {
    return self.forgetPasswordViewModel;
}
@end
