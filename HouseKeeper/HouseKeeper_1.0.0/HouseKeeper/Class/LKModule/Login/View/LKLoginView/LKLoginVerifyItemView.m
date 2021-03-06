//
//  LKLoginVerifyItemView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/18.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKLoginVerifyItemView.h"


@interface LKLoginVerifyItemView()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) NSInteger timeOut;
@property (nonatomic, strong) RACDisposable *timerDisposable;
@end

@implementation LKLoginVerifyItemView

- (void)createUI {
    [super createUI];
    _timeOut = 60;
    [self addSubview:self.iconImageView];
    [self addSubview:self.verifyTextField];
    [self addSubview:self.lineView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(kAdaptiveValue(22));
    }];
    [self addSubview:self.secureBtn];
    [self.secureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(kAdaptiveValue(20));
        make.width.height.equalTo(self.mas_height);
        make.top.mas_equalTo(0);
    }];
    [self addSubview:self.verifyCodeBtn];
    [self.verifyCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(kAdaptiveValue(20));
        make.height.equalTo(self.mas_height);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(0);
    }];
    [self.verifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(LKLeftMargin);
        make.top.mas_equalTo(0);
        make.height.equalTo(self.mas_height);
        make.right.equalTo(self.secureBtn.mas_left);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kAdaptiveValue(20));
        make.right.equalTo(self.mas_right).inset(kAdaptiveValue(20));
        make.height.mas_equalTo(kLineHeight);
        make.bottom.equalTo(self.mas_bottom);
    }];
//    [self verifyBtnSignal];
}
- (void)bindAccountDataWithIconImage:(NSString *)iconImage placeholder:(NSString *)placeholder textFieldText:(NSString *)textFieldText {
    self.verifyCodeBtn.hidden = YES;
    self.secureBtn.hidden = NO;
    self.iconImageView.image = [UIImage imageNamed:iconImage];
    self.verifyTextField.placeholder = placeholder;
    self.verifyTextField.text = textFieldText;
    [self.verifyTextField sendActionsForControlEvents:UIControlEventEditingChanged];
    self.verifyTextField.secureTextEntry = !self.secureBtn.selected;
    [self.verifyTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(LKLeftMargin);
        make.top.mas_equalTo(0);
        make.height.equalTo(self.mas_height);
        make.right.equalTo(self.secureBtn.mas_left);
    }];
}
- (void)bindQuickDataWithIconImage:(NSString *)iconImage placeholder:(NSString *)placeholder textFieldText:(NSString *)textFieldText {
    self.verifyCodeBtn.hidden = NO;
    self.secureBtn.hidden = YES;
    self.verifyTextField.secureTextEntry = NO;
    self.iconImageView.image = [UIImage imageNamed:iconImage];
    self.verifyTextField.placeholder = placeholder;
    self.verifyTextField.text = textFieldText;
    [self.verifyTextField sendActionsForControlEvents:UIControlEventEditingChanged];

    [self.verifyTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(LKLeftMargin);
        make.top.mas_equalTo(0);
        make.height.equalTo(self.mas_height);
        make.right.equalTo(self.verifyCodeBtn.mas_left);
    }];
}
- (void)bindRegisterDataWithIconImage:(NSString *)iconImage placeholder:(NSString *)placeholder textFieldText:(NSString *)textFieldText {
    self.verifyCodeBtn.hidden = YES;
    self.secureBtn.hidden = YES;
    self.verifyTextField.secureTextEntry = YES;
    self.iconImageView.image = [UIImage imageNamed:iconImage];
    self.verifyTextField.placeholder = placeholder;
    self.verifyTextField.text = textFieldText;
    [self.verifyTextField sendActionsForControlEvents:UIControlEventEditingChanged];
    [self.verifyTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(LKLeftMargin);
        make.top.mas_equalTo(0);
        make.height.equalTo(self.mas_height);
        make.right.equalTo(self.mas_right).inset(kAdaptiveValue(20));
    }];
}
#pragma mark - btnClick
- (void)secureBtnClick:(UIButton *)btn {
    self.secureBtn.selected = !self.secureBtn.selected;
    NSString *orignText = self.verifyTextField.text;
    self.verifyTextField.secureTextEntry = !self.secureBtn.selected;
    self.verifyTextField.text = @"";
    self.verifyTextField.text = orignText;
    [self.verifyTextField sendActionsForControlEvents:UIControlEventEditingChanged];
}
- (void)verifyBtnSignal{
    self.verifyCodeBtn.enabled = false;
    self.timeOut = 60;
    [self.verifyCodeBtn setTitle:[NSString stringWithFormat:@"重新发送 (%lds)",(long)self.timeOut] forState:UIControlStateDisabled];
    [self.verifyCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    @weakify(self);
    self.timerDisposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        @strongify(self);
        self.timeOut --;
        NSString * title = self.timeOut > 0 ? [NSString stringWithFormat:@"重新发送 (%lds)",(long)self.timeOut] : @"重新发送";
        self.verifyCodeBtn.enabled = (self.timeOut == 0)? YES : NO;
        [self.verifyCodeBtn setTitle:title forState:UIControlStateNormal | UIControlStateDisabled];
        if (self.timeOut == 0) {
            [self.timerDisposable dispose];
        }
    }];
}
#pragma mark - lazy
- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = LKLineColor;
    }
    return _lineView;
}
- (UITextField *)verifyTextField {
    if (_verifyTextField == nil) {
        _verifyTextField = [[UITextField alloc] init];
        _verifyTextField.borderStyle = UITextBorderStyleNone;
        _verifyTextField.textColor = LKGrayColor;
        [_verifyTextField setValue:LKDisableGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        _verifyTextField.delegate = self;
        _verifyTextField.tintColor = LKGrayColor;
        _verifyTextField.secureTextEntry = YES;
        _verifyTextField.font = LK_15font;
        _verifyTextField.clearsOnBeginEditing = NO;
    }
    return _verifyTextField;
}
- (UIButton *)secureBtn {
    if (_secureBtn == nil) {
        _secureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_secureBtn setImage:[UIImage imageNamed:@"app_icon_see"] forState:UIControlStateNormal];
        [_secureBtn setImage:[UIImage imageNamed:@"app_icon_hide"] forState:UIControlStateSelected];
        [_secureBtn addTarget:self action:@selector(secureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secureBtn;
}
- (UIButton *)verifyCodeBtn {
    if (_verifyCodeBtn == nil) {
        _verifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verifyCodeBtn setTitleColor:LKBlackColor forState:UIControlStateNormal];
        [_verifyCodeBtn setTitleColor:LKDisableGrayColor forState:UIControlStateDisabled];
        _verifyCodeBtn.titleLabel.font = LK_14font;
    }
    return _verifyCodeBtn;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.verifyTextField && textField.isSecureTextEntry ) {
        textField.text = toBeString;
        [textField sendActionsForControlEvents:UIControlEventEditingChanged];
        return NO;
    }
    return YES;
}
@end
