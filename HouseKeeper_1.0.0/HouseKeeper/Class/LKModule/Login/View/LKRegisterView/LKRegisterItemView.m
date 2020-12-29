//
//  LKRegisterItemView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKRegisterItemView.h"


@interface LKRegisterItemView()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *nextImageView;
@end

@implementation LKRegisterItemView

- (void)createUI {
    [super createUI];
    [self addSubview:self.iconImageView];
    [self addSubview:self.textField];
    [self addSubview:self.lineView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(kAdaptiveValue(22));
    }];
    [self addSubview:self.nextImageView];
    [self.nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(kAdaptiveValue(20));
        make.width.mas_equalTo(kAdaptiveValue(6));
        make.height.mas_equalTo(kAdaptiveValue(10));
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(LKLeftMargin);
        make.top.mas_equalTo(0);
        make.height.equalTo(self.mas_height);
        make.right.equalTo(self.nextImageView.mas_left);
    }];
    [self addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(LKLeftMargin);
        make.right.equalTo(self.mas_right).inset(kAdaptiveValue(20));
        make.height.equalTo(self.mas_height);
        make.top.mas_equalTo(0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kAdaptiveValue(20));
        make.right.equalTo(self.mas_right).inset(kAdaptiveValue(20));
        make.height.mas_equalTo(kLineHeight);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
- (void)bindDataWithIconImage:(NSString *)iconImage placeholder:(NSString *)placeholder textFieldText:(NSString *)textFieldText textFieldCanEdit:(BOOL)textFieldCanEdit isShowNextBtn:(BOOL)isShowNextBtn {
    self.nextBtn.hidden = !isShowNextBtn;
    self.nextImageView.hidden = !isShowNextBtn;
    self.textField.enabled = textFieldCanEdit;
    self.iconImageView.image = [UIImage imageNamed:iconImage];
    self.textField.placeholder = placeholder;
    self.textField.text = textFieldText;
    [self.textField sendActionsForControlEvents:UIControlEventEditingChanged];
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(LKLeftMargin);
        make.top.mas_equalTo(0);
        make.height.equalTo(self.mas_height);
        if (isShowNextBtn) {
            make.right.equalTo(self.nextImageView.mas_left);
        }else {
            make.right.equalTo(self.mas_right).inset(kAdaptiveValue(20));
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
- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.textColor = LKGrayColor;
        [_textField setValue:LKDisableGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        _textField.delegate = self;
        _textField.tintColor = LKGrayColor;
        _textField.font = LK_15font;
    }
    return _textField;
}
- (UIButton *)nextBtn {
    if (_nextBtn == nil) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.backgroundColor = [UIColor clearColor];
    }
    return _nextBtn;
}
- (UIImageView *)nextImageView {
    if (_nextImageView == nil) {
        _nextImageView = [[UIImageView alloc] init];
        _nextImageView.image = [UIImage imageNamed:@"app_icon_forward"];
    }
    return _nextImageView;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
