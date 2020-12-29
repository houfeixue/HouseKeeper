//
//  LKRegisterHeaderView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKRegisterHeaderView.h"

@interface LKRegisterHeaderView()

@end

@implementation LKRegisterHeaderView

- (void)createUI {
    [super createUI];
    [self addSubview:self.titleNameLabel];
    [self.titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kAdaptiveValue(20));
        make.right.equalTo(self.mas_right).inset(kAdaptiveValue(20));
        make.top.mas_equalTo(kAdaptiveValue(29));
        make.height.mas_equalTo(24);
    }];
    [self addSubview:self.titleNameDescLabel];
    [self.titleNameDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kAdaptiveValue(20));
        make.right.equalTo(self.mas_right).inset(kAdaptiveValue(20));
        make.top.equalTo(self.titleNameLabel.mas_bottom).offset(kAdaptiveValue(18));
        make.height.mas_equalTo(12);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
- (UILabel *)titleNameLabel {
    if (_titleNameLabel == nil) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.font = LK_24font;
        _titleNameLabel.textColor = LKGrayColor;
        _titleNameLabel.text = @"Hi，请输入以下信息";
    }
    return _titleNameLabel;
}
- (UILabel *)titleNameDescLabel {
    if (_titleNameDescLabel == nil) {
        _titleNameDescLabel = [[UILabel alloc] init];
        _titleNameDescLabel.font = LK_12font;
        _titleNameDescLabel.textColor = LKLightGrayColor;
    }
    return _titleNameDescLabel;
}
@end
