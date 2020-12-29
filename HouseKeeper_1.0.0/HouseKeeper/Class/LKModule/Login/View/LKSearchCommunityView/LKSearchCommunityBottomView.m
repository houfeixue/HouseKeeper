//
//  LKSearchCommunityBottomView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSearchCommunityBottomView.h"

@interface LKSearchCommunityBottomView ()
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UILabel *leftTipLabel;
@property (nonatomic, strong) UILabel *selectCommunityLabel;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIImageView *lineImageView;

@end

@implementation LKSearchCommunityBottomView

- (void)createUI {
    [super createUI];
    [self addSubview:self.lineImageView];
    [self addSubview:self.leftTipLabel];
    [self addSubview:self.selectCommunityLabel];
    [self addSubview:self.sureBtn];
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(kLineHeight);
    }];
    [self.leftTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LKLeftMargin);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.equalTo(self.mas_height);
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(12);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(62);
    }];
    [self.selectCommunityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTipLabel.mas_right);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.mas_height);
        make.right.equalTo(self.sureBtn.mas_left);
    }];
    self.selectCommunityLabel.userInteractionEnabled = YES;
    [self.selectCommunityLabel addGestureRecognizer:self.tapGesture];
}
- (void)bindDataSelectCountCommunity:(NSInteger)selectCountCommunity {
    self.selectCommunityLabel.text = [NSString stringWithFormat:@"%ld个小区",(long)selectCountCommunity];

}
- (void)sureButtonClick {
    if (self.sureBtnClick != nil) {
        self.sureBtnClick();
    }
}
- (void)tapClick {
    if (self.checkSelectCommunity != nil) {
        self.checkSelectCommunity();
    }
}
- (UIButton *)sureBtn {
    if (_sureBtn == nil) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.backgroundColor = LKBlackColor;
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = LK_13font;
        [_sureBtn addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.layer.cornerRadius = 5;
    }
    return _sureBtn;
}
- (UILabel *)leftTipLabel {
    if (_leftTipLabel == nil) {
        _leftTipLabel = [[UILabel alloc] init];
        _leftTipLabel.font = LK_13font;
        _leftTipLabel.textColor = LKLightGrayColor;
        _leftTipLabel.text = @"已选择：";
    }
    return _leftTipLabel;
}
- (UILabel *)selectCommunityLabel {
    if (_selectCommunityLabel == nil) {
        _selectCommunityLabel = [[UILabel alloc] init];
        _selectCommunityLabel.font = LK_16font;
        _selectCommunityLabel.textColor = LKLightRedColor;
    }
    return _selectCommunityLabel;
}
- (UIImageView *)lineImageView {
    if (_lineImageView == nil) {
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.backgroundColor = LKLineColor;
    }
    return _lineImageView;
}
- (UITapGestureRecognizer *)tapGesture {
    if (_tapGesture == nil) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    }
    return _tapGesture;
}
@end
