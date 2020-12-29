//
//  LKLoginAccountItemView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/18.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKLoginAccountItemView.h"

@interface LKLoginAccountItemView()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation LKLoginAccountItemView

- (void)createUI {
    [super createUI];
    [self addSubview:self.iconImageView];
    [self addSubview:self.accountTextField];
    [self addSubview:self.lineView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(22);
    }];
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(LKLeftMargin);
        make.top.mas_equalTo(0);
        make.height.equalTo(self.mas_height);
        make.right.equalTo(self.mas_right).inset(20);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.equalTo(self.mas_right).inset(20);
        make.height.mas_equalTo(kLineHeight);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
- (void)bindDataWithIconImage:(NSString *)iconImage placeholder:(NSString *)placeholder textFieldText:(NSString *)textFieldText {
    self.iconImageView.image = [UIImage imageNamed:iconImage];
    self.accountTextField.placeholder = placeholder;
    self.accountTextField.text = textFieldText;
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
- (UITextField *)accountTextField {
    if (_accountTextField == nil) {
        _accountTextField = [[UITextField alloc] init];
        _accountTextField.borderStyle = UITextBorderStyleNone;
        _accountTextField.textColor = LKGrayColor;
        [_accountTextField setValue:LKDisableGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        _accountTextField.delegate = self;
        _accountTextField.tintColor = LKGrayColor;
        _accountTextField.font = LK_15font;
    }
    return _accountTextField;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
