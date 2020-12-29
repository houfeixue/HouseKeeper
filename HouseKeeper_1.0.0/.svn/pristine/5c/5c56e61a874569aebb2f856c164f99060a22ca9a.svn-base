//
//  LKPictureHandleView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPictureHandleView.h"

@interface LKPictureHandleView()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *typeTitleLabel;
@property (nonatomic, strong) UILabel *selectTypeLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *bottomView;


@end

@implementation LKPictureHandleView

- (void)createUI {
    [super createUI];
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(50);
    }];
    [self.topView addSubview:self.typeTitleLabel];
    [self.typeTitleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.typeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LKLeftMargin);
        make.top.mas_equalTo(0);
        make.bottom.equalTo(self.topView.mas_bottom);
    }];
    [self.topView addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView.mas_right).inset(LKLeftMargin);
        make.centerY.equalTo(self.topView.mas_centerY);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(6);
    }];
    
    [self.topView addSubview:self.selectTypeLabel];
    [self.selectTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImageView.mas_left).offset(-7);
        make.top.mas_equalTo(0);
        make.bottom.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.typeTitleLabel.mas_right);
    }];
    [self.topView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LKLeftMargin);
        make.right.equalTo(self.topView.mas_right).inset(LKLeftMargin);
        make.bottom.equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(kLineHeight);
    }];
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(80);
    }];
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
    }
    return _topView;
}
- (UILabel *)typeTitleLabel {
    if (_typeTitleLabel == nil) {
        _typeTitleLabel = [[UILabel alloc] init];
        _typeTitleLabel.font = LK_14font;
        _typeTitleLabel.textColor = LKGrayColor;
        _typeTitleLabel.text = @"选择类型";
    }
    return _typeTitleLabel;
}
- (UILabel *)selectTypeLabel {
    if (_selectTypeLabel == nil) {
        _selectTypeLabel = [[UILabel alloc] init];
        _selectTypeLabel.font = LK_14font;
        _selectTypeLabel.textColor = LKGrayColor;
        _selectTypeLabel.text = @"默认";
    }
    return _selectTypeLabel;
}
- (UIImageView *)rightImageView {
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"app_icon_forward"];
    }
    return _rightImageView;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
    }
    return _lineView;
}
- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}

@end
