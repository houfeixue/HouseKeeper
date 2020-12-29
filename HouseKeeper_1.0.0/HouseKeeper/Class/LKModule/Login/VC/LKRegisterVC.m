//
//  LKRegisterVC.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKRegisterVC.h"
#import "LKRegisterHeaderView.h"
#import "LKLoginAccountItemView.h"
#import "LKLoginVerifyItemView.h"
#import "LKRegisterViewModel.h"
#import "LKRegisterPerfectInformationVC.h"

@interface LKRegisterVC ()
@property (nonatomic, strong) LKRegisterHeaderView *headerView;
@property (nonatomic, strong) LKLoginAccountItemView *accountItemView;
@property (nonatomic, strong) LKLoginVerifyItemView *verifyItemView;
@property (nonatomic, strong) LKLoginVerifyItemView *passwordItemView;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) LKRegisterViewModel *registerViewModel;
@property (nonatomic, strong) UIScrollView *bgScrollView;
@end

@implementation LKRegisterVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarWhiteBackground];
    [self addBlackBackButton];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarWhiteBackground];
    [self addNavBarTitleView];
    [self createUI];
    [self bindActionHandle];
}
#pragma mark - Action
- (void)bindActionHandle {
    
    @weakify(self);
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    /** 绑定按钮能否点击信号 */
    RAC(self.nextBtn, enabled) = self.registerViewModel.enableNextSignal;
    RAC(self.nextBtn, backgroundColor) = self.registerViewModel.nextBtnColorSignal;
    RAC(self.registerViewModel.registerModel, userName) = self.accountItemView.accountTextField.rac_textSignal;
    RAC(self.registerViewModel.registerModel, password) = self.passwordItemView.verifyTextField.rac_textSignal;
    RAC(self.registerViewModel.registerModel, verifyCode) = self.verifyItemView.verifyTextField.rac_textSignal;
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
    [[self.passwordItemView.verifyTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.length >= 16) {
            x = [x substringToIndex:16];
            self.passwordItemView.verifyTextField.text = x;
        }
    }];
    [self registerHandle];
}
- (void)registerHandle {
    @weakify(self);
    [[self.verifyItemView.verifyCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.view endEditing:YES];
        if ([LKCustomTool isBlankString:self.accountItemView.accountTextField.text] == NO) {
            NSString *firstWord = [self.accountItemView.accountTextField.text substringToIndex:1];
            if (![firstWord isEqualToString:@"1"] || [self.accountItemView.accountTextField.text length] != 11) {
                [LKCustomMethods showWindowMessage:@"请输入有效的手机号码"];
                return ;
            }
        }
        if (self.accountItemView.accountTextField.text.length != 11 ) {
            [LKCustomMethods showWindowMessage:@"请输入正确的手机号"];
            return ;
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"2" forKey:@"type"];
        [params setObject:self.accountItemView.accountTextField.text forKey:@"mobile"];
        self.registerViewModel.requestUrl = LKSendAuthCode;
        self.registerViewModel.requestTag = 1;
        self.registerViewModel.requestDict = params;

    }];
    [[self.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.view endEditing:YES];
        if ([self.verifyItemView.verifyTextField.text length] != 4) {
            [LKCustomMethods showWindowMessage:@"验证码必须是4位"];
            return ;
        }
        if ([self.passwordItemView.verifyTextField.text judgePasswordLegal] == NO) {
            [LKCustomMethods showWindowMessage:@"密码必须是6~16位字母和数字的组合"];
            return ;
        }
        self.registerViewModel.requestUrl = LKRegister;
        self.registerViewModel.requestTag = 2;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.accountItemView.accountTextField.text forKey:@"mobile"];
        [params setObject:@"2" forKey:@"type"];
        /** 管家端 */
        [params setObject:@"4" forKey:@"regType"];
        [params setObject:self.verifyItemView.verifyTextField.text forKey:@"authCode"];
        [params setObject:self.passwordItemView.verifyTextField.text forKey:@"password"];
        self.registerViewModel.requestDict = params;
    }];
    [self netSingalHandle];
}
- (void)netSingalHandle {
    @weakify(self);
    [self.registerViewModel.nextSuccessSubject subscribeNext:^(LKUserInfoModel * _Nullable model) {
        @strongify(self);
        [LKCustomMethods showWindowMessage:@"注册成功"];
        model.password = self.passwordItemView.verifyTextField.text;
        [LKCustomMethods saveUserInfo:model];
        LKRegisterPerfectInformationVC *vc = [[LKRegisterPerfectInformationVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.registerViewModel.verifyCodeSuccessSubject subscribeNext:^(id  _Nullable x) {
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
        make.top.equalTo(self.passwordItemView.mas_bottom).offset(kAdaptiveValue(40));
        make.left.mas_equalTo(kAdaptiveValue(15));
        make.right.equalTo(self.bgScrollView.mas_right).inset(15);
        make.height.mas_equalTo(kAdaptiveValue(49));
        make.bottom.greaterThanOrEqualTo(self.bgScrollView.mas_bottom).inset(kAdaptiveValue(200));

    }];
    self.nextBtn.layer.cornerRadius = 5.0f;
    [self.bgScrollView addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nextBtn.mas_bottom).offset(kAdaptiveValue(21));
        make.left.mas_equalTo(kAdaptiveValue(15));
        make.right.equalTo(self.bgScrollView.mas_right).inset(15);
        make.height.mas_equalTo(kAdaptiveValue(49));
    }];
    [self.view layoutIfNeeded];
    CGFloat maxHeight = CGRectGetMaxY(self.loginBtn.frame);
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
    self.headerView.titleNameDescLabel.text = @"3步即可完成操作哦";
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
    
    [self.bgScrollView addSubview:self.passwordItemView];
    [self.passwordItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.verifyItemView.mas_bottom);
        make.right.equalTo(self.bgScrollView.mas_right);
        make.height.mas_equalTo(kAdaptiveValue(43));
        make.width.mas_equalTo(kScreen_Width);
    }];
    [self.passwordItemView bindRegisterDataWithIconImage:@"app_icon_password" placeholder:@"请输入登录密码" textFieldText:@""];
}

- (void)addNavBarTitleView {
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register_1"]];
    self.navigationItem.titleView = titleView;
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
- (LKLoginVerifyItemView *)passwordItemView {
    if (_passwordItemView == nil) {
        _passwordItemView = [[LKLoginVerifyItemView alloc] init];
        _passwordItemView.verifyTextField.clearsOnBeginEditing = NO;
    }
    return _passwordItemView;
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
- (UIButton *)loginBtn {
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitleColor:LKGrayColor forState:UIControlStateNormal];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = LK_18font;
    }
    return _loginBtn;
}
- (LKRegisterViewModel *)registerViewModel {
    if (_registerViewModel == nil) {
        _registerViewModel = [[LKRegisterViewModel alloc] init];
    }
    return _registerViewModel;
}
- (LKRequestViewModel *)createDataSource {
    return self.registerViewModel;
}
@end
