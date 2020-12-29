//
//  LKPictureHandleBottomView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPictureHandleBottomView.h"

@interface LKPictureHandleBottomView()<UITextViewDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *typeTitleLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *bottomView;


@end

@implementation LKPictureHandleBottomView

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
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(10);
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
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.bottomView addSubview:self.textView];
}

- (void)selectTypeTap {
    if (self.selectPictureType != nil) {
        self.selectPictureType();
    }
}
- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTypeTap)];
        [_topView addGestureRecognizer:tap];
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
        _selectTypeLabel.textAlignment = NSTextAlignmentRight;
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
        _lineView.backgroundColor = LKLineColor;
    }
    return _lineView;
}
- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}
- (LKPictureHandleTextView *)textView {
    if (_textView == nil) {
        _textView = [[LKPictureHandleTextView alloc] initWithFrame:CGRectMake(10, 10, kScreen_Width - 20, 70)];
        _textView.font = LK_14font;
        _textView.placeholder = @"添加描述...";
        _textView.placeholderDesc = @"限20个字";
        _textView.placeholderColor = LKGrayColor;
        _textView.placeholderDescColor = LKDisableGrayColor;
        _textView.tintColor = LKGrayColor;
        _textView.delegate = self;
        _textView.maxLength = 20;
    }
    return _textView;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
