//
//  LKQualityHistoryHeaderView.m
//  HouseKeeper
//
//  Created by sunny on 2018/8/3.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKQualityHistoryHeaderView.h"

@interface LKQualityHistoryHeaderView ()
@property (nonatomic, strong) UILabel *currentTimeLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation LKQualityHistoryHeaderView

- (void)createUI {
    [super createUI];
    self.backgroundColor = LKF7Color;
    [self addSubview:self.currentTimeLabel];
    [self addSubview:self.rightImageView];
    [self addGestureRecognizer:self.tapGesture];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(10);
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).inset(LKLeftMargin);
    }];
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LKLeftMargin);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.rightImageView.mas_left);
    }];
}
- (void)tapGestureClick {
    if (self.selectTime != nil) {
        self.selectTime(self.currentTimeLabel.text);
    }
}
- (void)setCurrentSelectTime:(NSString *)currentSelectTime {
    _currentSelectTime = currentSelectTime;
    self.currentTimeLabel.text = currentSelectTime;
}
- (UILabel *)currentTimeLabel {
    if (_currentTimeLabel == nil) {
        _currentTimeLabel = [[UILabel alloc] init];
        _currentTimeLabel.textColor = LKLightGrayColor;
        _currentTimeLabel.font = LK_13font;
    }
    return _currentTimeLabel;
}
- (UIImageView *)rightImageView {
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"app_icon_forward"];
    }
    return _rightImageView;
}
- (UITapGestureRecognizer *)tapGesture {
    if (_tapGesture == nil) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClick)];
    }
    return _tapGesture;
}
@end
