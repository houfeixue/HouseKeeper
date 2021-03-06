//
//  LKSearchCommunityCityHeaderView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/24.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSearchCommunityCityHeaderView.h"
#import "LKCitysModel.h"

@interface LKSearchCommunityCityHeaderView ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UILabel *selectCityLabel;
@property (nonatomic, strong) UIImageView *tipImageView;



@end

@implementation LKSearchCommunityCityHeaderView

- (void)createUI {
    [super createUI];
    self.frame = CGRectMake(0, 0, kScreen_Width, 80);
    [self addSubview:self.topView];
    [self.topView addSubview:self.tipLabel];

    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.tipImageView];
    [self.bottomView addSubview:self.selectCityLabel];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(30);
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(12);
        make.right.equalTo(self.topView.mas_right).inset(12);
        make.height.mas_equalTo(30);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.right.equalTo(self.bottomView.mas_right).inset(12);
        make.height.mas_equalTo(6);
        make.width.mas_equalTo(11);
    }];
    [self.selectCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23);
        make.right.equalTo(self.tipImageView.mas_left);
        make.top.mas_equalTo(0);
        make.bottom.equalTo(self.bottomView.mas_bottom);
    }];
    [self.bottomView addGestureRecognizer:self.tapGesture];
}
- (void)bindDataSelectCityModel:(LKCityModel *)selectedCityModel {
    self.selectCityModel = selectedCityModel;
    self.selectCityLabel.text = selectedCityModel.name;
    
}

- (void)tapClick {
    if (self.selectCity != nil) {
        self.selectCity(self.selectCityModel);
    }
}
- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = LKF2Color;
    }
    return _topView;
}
- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = LK_13font;
        _tipLabel.textColor = LKGrayColor;
        _tipLabel.text = @"选择城市";
    }
    return _tipLabel;
}
- (UILabel *)selectCityLabel {
    if (_selectCityLabel == nil) {
        _selectCityLabel = [[UILabel alloc] init];
        _selectCityLabel.font = LK_15font;
        _selectCityLabel.textColor = LKLightGrayColor;
        _selectCityLabel.textAlignment = NSTextAlignmentCenter;
        _selectCityLabel.text = @"不限";
    }
    return _selectCityLabel;
}
- (UIImageView *)tipImageView {
    if (_tipImageView == nil) {
        _tipImageView = [[UIImageView alloc] init];
        _tipImageView.image = [UIImage imageNamed:@"app_icon_drop-down"];
    }
    return _tipImageView;
}
- (UITapGestureRecognizer *)tapGesture {
    if (_tapGesture == nil) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    }
    return _tapGesture;
}
@end
