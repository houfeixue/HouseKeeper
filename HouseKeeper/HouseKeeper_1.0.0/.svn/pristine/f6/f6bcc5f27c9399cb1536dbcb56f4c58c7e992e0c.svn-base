//
//  LKBottomButton.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/30.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBottomButton.h"

@interface LKBottomButton()

@property (nonatomic, strong) UIButton *addBtn;

@end
@implementation LKBottomButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI {
    self.backgroundColor = RGBA(245, 166, 35, 1);
    [self addSubview:self.bottomBtn];
    [self addSubview:self.addBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50 + kSafeAreaBottomHeight/2.0f);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.bottomBtn.mas_bottom);
        make.height.mas_equalTo(kSafeAreaBottomHeight/2.0f);
    }];
}
- (void)setButtonBackgroundColor:(UIColor *)buttonBackgroundColor {
    _buttonBackgroundColor = buttonBackgroundColor;
    self.backgroundColor = buttonBackgroundColor;
    self.addBtn.backgroundColor = buttonBackgroundColor;
    self.bottomBtn.backgroundColor = buttonBackgroundColor;
}
- (void)setButtonEnable:(BOOL)buttonEnable {
    _buttonEnable = buttonEnable;
    _addBtn.enabled = buttonEnable;
    _bottomBtn.enabled = buttonEnable;
}
- (void)bottomBtnClick {
    if (self.bottomButtonClick != nil) {
        self.bottomButtonClick();
    }
}
- (UIButton *)bottomBtn {
    if (_bottomBtn == nil) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.backgroundColor = LKBlackColor;
        [_bottomBtn setTitle:@"添加" forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}
- (UIButton *)addBtn {
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.backgroundColor = LKBlackColor;
        [_addBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

@end
