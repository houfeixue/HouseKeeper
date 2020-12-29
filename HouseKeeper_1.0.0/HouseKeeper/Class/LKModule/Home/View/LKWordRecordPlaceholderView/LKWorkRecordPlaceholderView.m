//
//  LKWorkRecordPlaceholderView.m
//  HouseKeeper
//
//  Created by sunny on 2018/8/3.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKWorkRecordPlaceholderView.h"

@interface LKWorkRecordPlaceholderView()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *writeRecordBtn;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *leftTipImageView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation LKWorkRecordPlaceholderView

- (void)createUI {
    [super createUI];
    self.bgView.backgroundColor = [ColorUtil colorWithHex:@"#F5F5F5"];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.iconImageView];
    [self.bgView addSubview:self.tipLabel];
    [self.bgView addSubview:self.writeRecordBtn];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        if (kScreen_Width == 320) {
            make.width.mas_equalTo(260);
        }else {
            make.width.mas_equalTo(280);
        }
        make.top.mas_equalTo(30);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.top.mas_equalTo(60);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(78);
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
        make.left.right.equalTo(self.bgView);
    }];
    [self.writeRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipLabel.mas_bottom).offset(30);
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(200);
        make.bottom.equalTo(self.bgView.mas_bottom).inset(30);
    }];
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (kScreen_Width == 320) {
            make.left.mas_equalTo(15);
        }else {
            make.left.mas_equalTo(22);
        }
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(400);
        make.top.mas_equalTo(0);
    }];
    
    [self addSubview:self.leftTipImageView];
    [self.leftTipImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(18);
        make.top.mas_equalTo(25);
        make.centerX.equalTo(self.lineView.mas_centerX);
    }];

    
    [self layoutIfNeeded];
    [self.writeRecordBtn.layer setCornerRadius:20];
    [self.bgView.layer setCornerRadius:6];
    
}
- (void)addWorkRecordBtnClick {
    if (self.addWorkRecord != nil) {
        self.addWorkRecord();
    }
}
- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"notes_icon_no record"];
    }
    return _iconImageView;
}
- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = LKLightGrayColor;
        _tipLabel.font = LK_12font;
        _tipLabel.text = @"当天没有写工作记录哦";
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}
- (UIButton *)writeRecordBtn {
    if (_writeRecordBtn == nil) {
        _writeRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_writeRecordBtn setTitle:@"立即写记录" forState:UIControlStateNormal];
        [_writeRecordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _writeRecordBtn.backgroundColor = LKLightRedColor;
        _writeRecordBtn.titleLabel.font = LK_14font;
        [_writeRecordBtn addTarget:self action:@selector(addWorkRecordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _writeRecordBtn;
}
- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
    }
    return _bgView;
}
- (UIImageView *)leftTipImageView {
    if (_leftTipImageView == nil) {
        _leftTipImageView = [[UIImageView alloc] init];
        _leftTipImageView.image = [UIImage imageNamed:@"notes_icon_big"];
    }
    return _leftTipImageView;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [ColorUtil colorWithHex:@"#E6E6E6"];
    }
    return _lineView;
}
@end
