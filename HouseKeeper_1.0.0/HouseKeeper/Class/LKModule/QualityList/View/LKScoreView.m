//
//  LKScoreView.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKScoreView.h"

@implementation LKScoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setUpViews];
    }
    return self;
}


-(void)_setUpViews
{
    
    [self addSubview:self.scoreLabel];
    [self addSubview:self.submitBtn];
    [self addSubview:self.lineView];
    self.backgroundColor = [UIColor whiteColor];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(LKRightMargin);
        make.width.equalTo(@(65));
        make.height.equalTo(@(30));
        
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(LKLeftMargin);
        make.centerY.equalTo(self);
        make.height.equalTo(@(20));
        make.right.equalTo(self.submitBtn.mas_left);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
}
//lazy
-(UILabel *)scoreLabel{
    if (_scoreLabel == nil) {
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.text = @"得分：";
        _scoreLabel.font = LK_13font;
        _scoreLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];

    }
    return _scoreLabel;
}

-(UIButton *)submitBtn
{
    if (_submitBtn == nil) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:  [UIColor colorWithRed:66/255.0 green:65/255.0 blue:82/255.0 alpha:1/1.0]];
        _submitBtn.titleLabel.font = LK_13font;
        [_submitBtn hyb_addCornerRadius:5];
        _submitBtn.layer.masksToBounds = YES;
        
        @weakify(self);
        [[_submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.scoreViewClick) {
                self.scoreViewClick(@"");
            }
        }];
    }
    return _submitBtn;
}


-(void)conFigScoreCount:(NSString *)score
{
    NSString *scoreStr = [NSString stringWithFormat:@"%@分",score];
    _scoreLabel.attributedText = [NSString getAttributeStringWithLabelText:@"得分：" font:LK_13font textColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0] changeText:scoreStr changeFont:LK_16font changeColor:[ColorUtil colorWithHex:@"C06163"]];
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = LKLineColor;
    }
    return _lineView;
}
@end
