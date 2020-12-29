//
//  LKAddWorkDescriptionItemView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKAddWorkDescriptionItemView.h"

@interface LKAddWorkDescriptionItemView ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation LKAddWorkDescriptionItemView

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
    self.textView.frame = CGRectMake(88, 7.5, kScreen_Width - 105, self.textView.wzb_minHeight);
    self.viewHeight = 50;
    self.y = self.viewHeight;
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(kLineHeight);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).inset(13);
        make.right.equalTo(self.mas_right).inset(12);
        make.left.mas_equalTo(12);
        make.height.mas_equalTo(11);
    }];
    
    @weakify(self);
    [self.textView wzb_autoHeightWithMaxHeight:CGFLOAT_MAX textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        @strongify(self);
        self.textView.frame = CGRectMake(88, 7.5, kScreen_Width - 105, currentTextViewHeight);
        if (currentTextViewHeight > self.textView.wzb_minHeight) {
            self.viewHeight = 7.5 + currentTextViewHeight + 23;
            self.tipLabel.hidden = NO;
        }else {
            self.viewHeight = 50;
            self.tipLabel.hidden = YES;
        }
        [self textViewChangeHeight];
    }];
    [[[self.textView rac_textSignal] skip:1] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        NSString *lang = self.textView.textInputMode.primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) {
            UITextRange *selectedRange = [self.textView markedTextRange];
            UITextPosition *position = [self.textView positionFromPosition:selectedRange.start offset:0];
            if (!position) {
                if (x.length >= 200) {
                    x = [x substringToIndex:200];
                    self.textView.text = x;
                }
            }
        }else {
            if (x.length >= 200) {
                x = [x substringToIndex:200];
                self.textView.text = x;
            }
        }
        self.tipLabel.text = [NSString stringWithFormat:@"%ld/200",x.length];

    }];
}
/** textView高度改变 */
- (void)textViewChangeHeight {
    if ([self.delegate respondsToSelector:@selector(LKAddWorkDescriptionItemViewDelegateViewHeight:)]) {
        [self.delegate LKAddWorkDescriptionItemViewDelegateViewHeight:self.viewHeight];
    }
}
- (void)bindWorkDescriptionData:(NSString *)workDesc {
    self.textView.text = workDesc;
}
#pragma mark - 懒加载控件
- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(88, 0, kScreen_Width - 105, 50)];
        _textView.wzb_placeholder = @"请输入检查点具体问题及评价";
        _textView.wzb_placeholderColor = LKDisableGrayColor;
        _textView.font = LK_15font;
        _textView.textColor = LKGrayColor;
        _textView.wzb_minHeight = 37;
        _textView.tintColor = LKGrayColor;
        _textView.scrollEnabled = NO;
    }
    return _textView;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = LK_14font;
        _titleLabel.textColor = LKGrayColor;
        _titleLabel.text = @"工作描述";
    }
    return _titleLabel;
}
- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = LK_11font;
        _tipLabel.textColor = LKRedColor;
        _tipLabel.textAlignment = NSTextAlignmentRight;
    }
    return _tipLabel;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = LKLineColor;
    }
    return _lineView;
}
@end
