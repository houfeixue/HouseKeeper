//
//  LKAddWorkAddressItemView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/30.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKAddWorkAddressItemView.h"
#import "UITextView+WZB.h"

@interface LKAddWorkAddressItemView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation LKAddWorkAddressItemView

- (void)createUI {
    [super createUI];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.left.mas_equalTo(LKLeftMargin);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    [self addSubview:self.textView];
    self.textView.frame = CGRectMake(92, 7.5, kScreen_Width - 100, self.textView.wzb_minHeight);
    self.viewHeight = 50;
    self.y = self.viewHeight;
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(kLineHeight);
        make.bottom.equalTo(self.mas_bottom);
    }];
    @weakify(self);
    [self.textView wzb_autoHeightWithMaxHeight:self.textView.wzb_maxHeight textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        @strongify(self);
        self.textView.frame = CGRectMake(92, 7.5, kScreen_Width - 100, currentTextViewHeight);
        DLog(@"%f --- %f ----- %f",currentTextViewHeight,self.textView.wzb_maxHeight,self.textView.wzb_minHeight);
        if (currentTextViewHeight > self.textView.wzb_minHeight) {
            self.viewHeight = 7.5 + currentTextViewHeight + 7.5;
        }else {
            self.viewHeight = 50;
        }
        [self textViewChangeHeight];
    }];
}
/** textView高度改变 */
- (void)textViewChangeHeight {
    if ([self.delegate respondsToSelector:@selector(LKAddWorkAddressItemViewDelegateViewHeight:)]) {
        [self.delegate LKAddWorkAddressItemViewDelegateViewHeight:self.viewHeight];
    }
}
#pragma mark - 懒加载控件
- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(92, 0, kScreen_Width - 100, 50)];
        _textView.wzb_placeholder = @"请输入您的工作地点";
        _textView.wzb_placeholderColor = LKDisableGrayColor;
        _textView.font = LK_15font;
        _textView.textColor = LKLightGrayColor;
        _textView.wzb_minHeight = 37.0f;
        _textView.wzb_maxHeight = 58.0f;
        _textView.tintColor = LKLightGrayColor;
        _textView.scrollEnabled = NO;
    }
    return _textView;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = LK_14font;
        _titleLabel.textColor = LKLightGrayColor;
        _titleLabel.text = @"工作地点";
    }
    return _titleLabel;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = LKLineColor;
    }
    return _lineView;
}

@end
