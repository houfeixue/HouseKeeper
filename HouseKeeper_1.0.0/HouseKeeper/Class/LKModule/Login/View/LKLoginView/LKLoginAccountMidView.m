//
//  LKLoginAccountMidView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/18.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKLoginAccountMidView.h"

@interface LKLoginAccountMidView()

@end

@implementation LKLoginAccountMidView

- (void)createUI {
    [super createUI];
    
    [self addSubview:self.rememberPasswordBtn];
    [self.rememberPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kAdaptiveValue(24));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(34);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self addSubview:self.forgetPasswordBtn];
    [self.forgetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(kAdaptiveValue(20));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(34);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (UIButton *)rememberPasswordBtn {
    if (_rememberPasswordBtn == nil) {
        _rememberPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rememberPasswordBtn setImage:[UIImage imageNamed:@"app_icon_normal"] forState:UIControlStateNormal];
        [_rememberPasswordBtn setImage:[UIImage imageNamed:@"app_icon_rememberSelected"] forState:UIControlStateSelected];
        [_rememberPasswordBtn setTitle:@"记住密码" forState:UIControlStateNormal];
        [_rememberPasswordBtn setTitleColor:LKLightGrayColor forState:UIControlStateNormal];
        _rememberPasswordBtn.titleLabel.font = LK_12font;
    }
    return _rememberPasswordBtn;
}
- (UIButton *)forgetPasswordBtn {
    if (_forgetPasswordBtn == nil) {
        _forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasswordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetPasswordBtn setTitleColor:LKLightGrayColor forState:UIControlStateNormal];
        _forgetPasswordBtn.titleLabel.font = LK_12font;
    }
    return _forgetPasswordBtn;
}
@end
