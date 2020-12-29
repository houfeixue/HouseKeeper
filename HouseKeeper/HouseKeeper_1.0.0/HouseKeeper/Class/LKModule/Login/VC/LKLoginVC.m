//
//  LKLoginVC.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKLoginVC.h"
#import "LKLoginHeaderView.h"
#import "LKLoginAccountItemView.h"
#import "LKLoginVerifyItemView.h"
#import "LKLoginAccountMidView.h"
#import "LKLoginViewModel.h"
#import "LKRegisterVC.h"
#import "LKForgetPasswordVC.h"
#import "LKRegisterPerfectInformationVC.h"
#import "LKAuthorViewController.h"


@interface LKLoginVC ()<UINavigationControllerDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) LKLoginHeaderView *headerView;
@property (nonatomic, strong) LKLoginAccountItemView *accountItemView;
@property (nonatomic, strong) LKLoginVerifyItemView *verifyItemView;
@property (nonatomic, strong) LKLoginAccountMidView *midView;


@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, strong) LKLoginViewModel *loginViewModel;
@property (nonatomic, assign) __block BOOL isQuickLogin;
@property (nonatomic, assign) __block BOOL isRememberPassword;
@property (nonatomic, strong) UIView *bgView;
@end

@implementation LKLoginVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    if (self.isQuickLogin) {
        [self.headerView.accountLoginBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }else {
        [self changeSecureBtnStatus];
    }
    self.verifyItemView.verifyTextField.keyboardType = UIKeyboardTypeDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.delegate = self;
    self.isQuickLogin = NO;
    [self createUI];
    [self bindActionHandle];
    /** 修改密码成功 */
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"changePasswordSuccess" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        self.verifyItemView.verifyTextField.text = @"";
        [self.verifyItemView.verifyTextField sendActionsForControlEvents:UIControlEventEditingChanged];
    }];
}
#pragma mark - action
- (void)bindActionHandle {
    @weakify(self);
    [self.headerView.btnClickSubject subscribeNext:^(NSNumber *btnTag) {
        @strongify(self);
        [self.verifyItemView.verifyTextField resignFirstResponder];
        if ([btnTag isEqualToNumber:@(0)]) {
            self.verifyItemView.verifyTextField.keyboardType = UIKeyboardTypeDefault;
            self.isQuickLogin = NO;
            self.loginViewModel.loginModel.isQuickLogin = self.isQuickLogin;
            [self.verifyItemView bindAccountDataWithIconImage:@"app_icon_password" placeholder:@"请输入密码" textFieldText:@""];
        }else {
            self.verifyItemView.verifyTextField.keyboardType = UIKeyboardTypeNumberPad;
            self.isQuickLogin = YES;
            self.loginViewModel.loginModel.isQuickLogin = self.isQuickLogin;
            [self.verifyItemView bindQuickDataWithIconImage:@"app_icon_messages" placeholder:@"请输入验证码" textFieldText:@""];
            self.isRememberPassword = NO;
        }
        [self changeSecureBtnStatus];
        self.midView.hidden = self.isQuickLogin;
    }];
    [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.view endEditing:YES];
        LKRegisterVC *vc = [[LKRegisterVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [[self.midView.rememberPasswordBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable btn) {
        @strongify(self);
        btn.selected = !btn.selected;
        self.isRememberPassword = btn.selected;
        DLog(@"记住密码");
    }];
    [[self.midView.forgetPasswordBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable btn) {
        @strongify(self);
        [self.view endEditing:YES];
        DLog(@"忘记密码");
        LKForgetPasswordVC *vc = [[LKForgetPasswordVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    /** 绑定登录按钮能否点击信号 */
    RAC(self.loginBtn, enabled) = self.loginViewModel.enableLoginSignal;
    RAC(self.loginBtn, backgroundColor) = self.loginViewModel.loginBtnColorSignal;
    RAC(self.loginViewModel.loginModel, userName) = self.accountItemView.accountTextField.rac_textSignal;
    RAC(self.loginViewModel.loginModel, password) = self.verifyItemView.verifyTextField.rac_textSignal;
    [[self.accountItemView.accountTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.length >= 11) {
            x = [x substringToIndex:11];
            self.accountItemView.accountTextField.text = x;
        }
    }];
    [[self.verifyItemView.verifyTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (self.isQuickLogin) {
            if (x.length >= 4) {
                x = [x substringToIndex:4];
                self.verifyItemView.verifyTextField.text = x;
            }
        }
    }];
    [self loginHandle];
}
- (void)loginHandle {
    @weakify(self);
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
        [params setObject:@"4" forKey:@"type"];
        [params setObject:self.accountItemView.accountTextField.text forKey:@"mobile"];
        self.loginViewModel.requestUrl = LKSendAuthCode;
        self.loginViewModel.requestTag = 3;
        self.loginViewModel.requestDict = params;
        
    }];
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.view endEditing:YES];
        if ([LKCustomTool isBlankString:self.accountItemView.accountTextField.text] == NO) {
            NSString *firstWord = [self.accountItemView.accountTextField.text substringToIndex:1];
            if (![firstWord isEqualToString:@"1"]) {
                [LKCustomMethods showWindowMessage:@"请输入正确的手机号"];
                return ;
            }
        }
        if ([LKCustomTool isBlankString:self.accountItemView.accountTextField.text] ||[self.accountItemView.accountTextField.text length] != 11) {
            [LKCustomMethods showWindowMessage:@"请输入正确的手机号"];
            return ;
        }
//        if (self.isQuickLogin == YES) { /// 快速登录
//
//        }else {
//            if ([self.verifyItemView.verifyTextField.text judgePasswordLegal] == NO) {
//                [LKCustomMethods showWindowMessage:@"密码必须是6~18位字母和数字的组合"];
//                return ;
//            }
//        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.accountItemView.accountTextField.text forKey:@"mobile"];
        if (self.isQuickLogin == YES) {
            self.loginViewModel.requestTag = 2;
            [params setObject:self.verifyItemView.verifyTextField.text forKey:@"authCode"];
            [params setObject:@"1" forKey:@"loginType"];
        }else {
            [params setObject:@"0" forKey:@"loginType"];
            self.loginViewModel.requestTag = 1;
            [params setObject:self.verifyItemView.verifyTextField.text forKey:@"password"];
        }
        self.loginViewModel.requestUrl = LKLogin;
        self.loginViewModel.requestDict = params;
    }];
    [self netSingalHandle];
}
- (void)netSingalHandle {
    @weakify(self);
    [self.loginViewModel.loginSuccessSubject subscribeNext:^(LKUserInfoModel *  _Nullable userInfoModel) {
        @strongify(self);
        userInfoModel.isLoginSuccess = NO;
        userInfoModel.localPassword = self.verifyItemView.verifyTextField.text;
        if (self.isQuickLogin == NO) {
            userInfoModel.isRememberPassword = self.midView.rememberPasswordBtn.isSelected;
        }
        [LKCustomMethods saveUserInfo:userInfoModel];
        if (userInfoModel.isComplete == 0) { /** 0 未提交审核 1提交审核 */
            LKRegisterPerfectInformationVC *vc = [[LKRegisterPerfectInformationVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            NSMutableArray *auditArray0 = [NSMutableArray array];
            NSMutableArray *auditArray1 = [NSMutableArray array];
            NSMutableArray *auditArray2 = [NSMutableArray array];
            for (NSInteger i = 0; i < userInfoModel.communities.count; i ++ ) {
                LKUserInfoCommunityModel *communityModel = [userInfoModel.communities objectAtIndex:i];
                if (communityModel.audit == 0) {
                    [auditArray0 addObject:communityModel];
                }else if (communityModel.audit == 1) {
                    [auditArray1 addObject:communityModel];
                }else if (communityModel.audit == 2) {
                    [auditArray2 addObject:communityModel];
                }
            }
            if (auditArray1.count > 0) { /// 审核通过
                [LKCustomMethods showWindowMessage:@"登录成功"];
                userInfoModel.isLoginSuccess = YES;
                [LKCustomMethods saveUserInfo:userInfoModel];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
            }else {
                if (auditArray0.count == userInfoModel.communities.count) { /// 未提交审核
                    LKAuthorViewController *vc = [[LKAuthorViewController alloc] initAuthorType:@"1"];
                    [self.navigationController pushViewController:vc animated:YES];
                }else { /// 审核失败的
                    NSString *auditFailDescription = @"";
//                    for (NSInteger i = 0; i < auditArray2.count; i ++ ) {
//                        LKUserInfoCommunityModel *communityModel = [auditArray2 objectAtIndex:i];
//                        [auditFailDescription stringByAppendingString:[NSString stringWithFormat:@"%@---%@\n",communityModel.communityName,communityModel.auditDesc]];
//                    }
                    if (auditArray2.count > 0) {
                        LKUserInfoCommunityModel *model = [auditArray2 objectAtIndex:0];
                        if (model != nil && [LKCustomTool isBlankString:model.auditDesc] == NO) {
                            auditFailDescription = [NSString stringWithFormat:@"失败原因：%@",model.auditDesc];
                        }
                    }
                    LKAuthorViewController *vc = [[LKAuthorViewController alloc] initAuthorType:@"2"];
                    vc.auditFailDescription = auditFailDescription;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }
    }];
    [self.loginViewModel.verifyCodeSuccessSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        /// 倒计时
        [self.verifyItemView verifyBtnSignal];
    }];
}
/** 设置密码密文 */
- (void)changeSecureBtnStatus {
    if (self.verifyItemView.secureBtn.isSelected == YES) {
        [self.verifyItemView.secureBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}
#pragma mark - UI
- (void)createUI {
    [self.view addSubview:self.bgScrollView];
    self.bgScrollView.backgroundColor = [UIColor whiteColor];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
#ifdef __IPHONE_11_0
    if (@available(iOS 11, *)) {
        self.bgScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    [self createHeaderView];
    [self createItemView];

    [self.bgScrollView addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyItemView.mas_bottom).offset(kAdaptiveValue(63));
        make.left.mas_equalTo(kAdaptiveValue(15));
        make.right.equalTo(self.bgScrollView.mas_right).inset(15);
        make.height.mas_equalTo(kAdaptiveValue(49));
    make.bottom.greaterThanOrEqualTo(self.bgScrollView.mas_bottom).inset(kAdaptiveValue(221));

    }];
    self.loginBtn.layer.cornerRadius = 5.0f;
    [self.bgScrollView addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(kAdaptiveValue(21));
        make.left.mas_equalTo(kAdaptiveValue(15));
        make.right.equalTo(self.bgScrollView.mas_right).inset(15);
        make.height.mas_equalTo(kAdaptiveValue(49));
    }];
    [self.view layoutIfNeeded];
    CGFloat maxHeight = CGRectGetMaxY(self.registerBtn.frame);
    if (maxHeight > kScreen_Height ) {
        self.bgScrollView.contentSize = CGSizeMake(kScreen_Width, maxHeight);
    }else {
        self.bgScrollView.contentSize = CGSizeMake(kScreen_Width, kScreen_Height + 1);
    }
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bgScrollView.contentSize.width, self.bgScrollView.contentSize.height)];
    [self.bgScrollView addSubview:self.bgView];
    [self.bgScrollView sendSubviewToBack:self.bgView];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self bindData];
}
- (void)bindData {
    if (self.isQuickLogin == NO) {
        LKUserInfoModel *userInfoModel = [LKCustomMethods readUserInfo];
        if (userInfoModel != nil) {
            if (userInfoModel.isRememberPassword) {
                self.midView.rememberPasswordBtn.selected = YES;
                self.accountItemView.accountTextField.text = userInfoModel.mobile;
                self.verifyItemView.verifyTextField.text = userInfoModel.localPassword;
                [self.verifyItemView.verifyTextField sendActionsForControlEvents:UIControlEventEditingChanged];
                [self.accountItemView.accountTextField sendActionsForControlEvents:UIControlEventEditingChanged];
            }else {
                self.accountItemView.accountTextField.text = userInfoModel.mobile;
                [self.accountItemView.accountTextField sendActionsForControlEvents:UIControlEventEditingChanged];
                self.midView.rememberPasswordBtn.selected = NO;
            }
        }
    }
}
- (void)createHeaderView {
    [self.bgScrollView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.right.equalTo(self.bgScrollView.mas_right);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(kAdaptiveValue(225));
    }];
}
- (void)createItemView {
    [self.bgScrollView addSubview:self.accountItemView];
    [self.accountItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.headerView.mas_bottom).offset(kAdaptiveValue(22));
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
    [self.verifyItemView bindAccountDataWithIconImage:@"app_icon_password" placeholder:@"请输入密码" textFieldText:@""];
    
    [self.bgScrollView addSubview:self.midView];
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.verifyItemView.mas_bottom);
        make.right.equalTo(self.bgScrollView.mas_right);
        make.width.mas_equalTo(kScreen_Width);
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        self.bgScrollView.backgroundColor = LKBlackColor;
    }else {
        self.bgScrollView.backgroundColor = [UIColor whiteColor];
    }
}
#pragma mark - lazy
- (UIScrollView *)bgScrollView {
    if (_bgScrollView == nil) {
        _bgScrollView = [[UIScrollView alloc] init];
        _bgScrollView.delegate = self;
    }
    return _bgScrollView;
}
- (UIButton *)registerBtn {
    if (_registerBtn == nil) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitleColor:LKLightGrayColor forState:UIControlStateNormal];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    }
    return _registerBtn;
}
- (UIButton *)loginBtn {
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = LKBlackColor;
        _loginBtn.titleLabel.font = LK_18font;
    }
    return _loginBtn;
}
- (LKLoginHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[LKLoginHeaderView alloc] init];
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
        _verifyItemView.verifyTextField.clearsOnBeginEditing = NO;
    }
    return _verifyItemView;
}
- (LKLoginViewModel *)loginViewModel {
    if (_loginViewModel == nil) {
        _loginViewModel = [[LKLoginViewModel alloc] init];
    }
    return _loginViewModel;
}
- (LKLoginAccountMidView *)midView {
    if (_midView == nil) {
        _midView = [[LKLoginAccountMidView alloc] init];
    }
    return _midView;
}
#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];

    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
- (void)dealloc {
    self.navigationController.delegate = nil;
}
- (LKRequestViewModel *)createDataSource {
    return self.loginViewModel;
}
@end
