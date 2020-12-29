//
//  LKQualityBottomView.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/23.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKScoreBottomView.h"

@implementation LKScoreBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _setUpView];
    }
    return self;
}


-(void)_setUpView{
    [self addSubview:self.lineView];
    [self addSubview:self.leftView];
    [self.leftView addSubview:self.identifyLabel];
    [self.leftView addSubview:self.nameLabel];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.lookBtn];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(kLineHeight);
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.top.equalTo(self.lineView.mas_bottom);
    }];
    [self.identifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftView).offset(LKLeftMargin);
        make.top.mas_equalTo(8);
        make.height.equalTo(@(15));
        make.right.lessThanOrEqualTo(self.leftView.mas_right);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftView).offset(LKLeftMargin);
        make.top.equalTo(self.identifyLabel.mas_bottom);
        make.right.lessThanOrEqualTo(self.leftView.mas_right);
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftView.mas_right).offset(20);
        make.centerY.equalTo(self);
    }];
    [self.lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(LKLeftMargin);
        make.height.equalTo(@(30));
        make.width.equalTo(@(115));
        make.left.equalTo(self.scoreLabel.mas_right);
        make.centerY.equalTo(self);
    }];
    [self.lookBtn hyb_addCornerRadius:5];
}
- (void)bindDataWithScore:(NSString *)score identify:(NSString *)identify name:(NSString *)name {
    self.identifyLabel.text = identify;
    self.nameLabel.text = name;
    CGFloat nameLabelWidth = [name sizeWithFont:self.nameLabel.font maxSize:CGSizeMake(200, 100)].width;
    CGFloat identifyLabelWidth = [identify sizeWithFont:self.identifyLabel.font maxSize:CGSizeMake(200, 100)].width;
    CGFloat maxWidth = MIN(MAX(nameLabelWidth, identifyLabelWidth) + 15, 140);
    [self.leftView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.top.equalTo(self.lineView.mas_bottom);
        make.width.mas_equalTo(maxWidth);
    }];
    NSString *scoreString = [NSString stringWithFormat:@"得分：%@分",score];
    NSMutableAttributedString *attributr = [[NSMutableAttributedString alloc] initWithString:scoreString];
    attributr.yy_font = LK_13font;
    attributr.yy_color = LKLightGrayColor;
    NSRange range = NSMakeRange(3, attributr.length - 3);
    [attributr yy_setFont:LK_16font range:range];
    [attributr yy_setColor:LKRedColor range:range];
    self.scoreLabel.attributedText = attributr;
}
//lazy
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = LKLineColor;
    }
    return _lineView;
}
- (YYLabel *)scoreLabel
{
    if (_scoreLabel == nil) {
        _scoreLabel = [[YYLabel alloc] init];
    }
    return _scoreLabel;
}
- (UIView *)leftView {
    if (_leftView == nil) {
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = self.backgroundColor;
    }
    return _leftView;
}
- (UILabel *)identifyLabel {
    if (_identifyLabel == nil) {
        _identifyLabel = [[UILabel alloc] init];
        _identifyLabel.font = LK_12font;
        _identifyLabel.textColor = LKLightGrayColor;
    }
    return _identifyLabel;
}
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = LK_16font;
        _nameLabel.textColor = [ColorUtil colorWithHex:@"#151515"];
    }
    return _nameLabel;
}

-(UIButton *)lookBtn
{
    if (_lookBtn == nil) {
        _lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lookBtn setTitle:@"查看抽查照片" forState:UIControlStateNormal];
        _lookBtn.backgroundColor = LKBlackColor;
        _lookBtn.titleLabel.font = LK_13font;
         @weakify(self)
        [[_lookBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.pictureLookClick) {
                self.pictureLookClick(@"");
            }
        }];
    }
    return _lookBtn;
}

@end
