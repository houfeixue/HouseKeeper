//
//  LKQualityDetailHeaderView.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/18.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKQualityDetailHeaderView.h"

@implementation LKQualityDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setUpView];
    }
    
    return self;
}

-(void)_setUpView
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.picImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.flitBtn];
    
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(LKLeftMargin);
        make.width.height.equalTo(@(20));
        make.centerY.equalTo(self);
    }];
    
    [self.flitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(LKRightMargin);
        make.centerY.equalTo(self);
        make.width.equalTo(@(60));
        make.height.equalTo(@(30));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.picImageView.mas_right).offset(12);
        make.height.equalTo(@(20));
    }];
    [self.scoreLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.lessThanOrEqualTo(self.flitBtn.mas_left).offset(-5);
        make.centerY.equalTo(self);
        make.left.equalTo(self.nameLabel.mas_right).offset(10);
        make.height.equalTo(@(20));
    }];
}
- (void)bindDataIconImage:(NSString *)iconImage titleName:(NSString *)titleName score:(NSString *)score {
    [self.picImageView yy_setImageWithURL:[[NSString stringWithFormat:@"%@%@",LKIconHost,iconImage] toURL] placeholder:[UIImage imageNamed:LKPicture_Default]];
    self.nameLabel.text = titleName;
    self.scoreLabel.text = [NSString stringWithFormat:@"%@分",score];
}
//lazy
-(UIImageView *)picImageView
{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc]init];
    }
    return _picImageView;
}
-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = LK_medium_18font;//[UIFont fontWithName:@"PingFangSC-Medium" size:18];
        _nameLabel.textColor = LKBlackColor;
    }
    return _nameLabel;
}
-(UILabel *)scoreLabel{
    if (_scoreLabel == nil) {
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.font = LK_medium_16font;
        _scoreLabel.textColor = LKRedColor;
    }
    return _scoreLabel;
}

-(UIButton *)flitBtn{
    if (_flitBtn == nil) {
        _flitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flitBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_flitBtn setTitleColor:LKBlueColor forState:UIControlStateNormal];
        [_flitBtn setImage:[UIImage imageNamed:@"check_icon_down_blue"] forState:UIControlStateNormal];
        _flitBtn.titleLabel.font = LK_14font;
        [_flitBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20) withImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
        @weakify(self)
        [[_flitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            if (self.qualityDetailHeaderClick) {
                self.qualityDetailHeaderClick(@"isflit");
            }
        }];
    }
    return _flitBtn;
}

@end
