//
//  LKQualityListNavTitleView.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKQualityListNavTitleView.h"

@implementation LKQualityListNavTitleView

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
        [self _setUpView];
    }
    return self;
}
-(void)_setUpView
{
    [self addSubview:self.nameBtn];
    [self.nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

//lazy
-(UILabel *)nameBtn
{
    if (_nameBtn == nil) {
        _nameBtn = [[UILabel alloc]init];;
        _nameBtn.font = LK_17font;
        _nameBtn.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
        _nameBtn.userInteractionEnabled = YES;
        [_nameBtn addGestureRecognizer:tap];
        
        @weakify(self)
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self);
            if (self.qualityNavTitleClick) {
                self.qualityNavTitleClick(@"");
            }
        }];
//        [[_nameBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//            @strongify(self);
//            if (self.qualityNavTitleClick) {
//                self.qualityNavTitleClick(@"");
//            }
//        }];

    }
    return _nameBtn;
}

-(void)setTitleViewText:(NSString *)text withClick:(BOOL)click
{
    
    text = [NSString stringWithFormat:@"%@  ",text];
    
    if (click) {
         _nameBtn.attributedText = [NSString getAttributeStringWithimage:[UIImage imageNamed:@"check_icon_down"] imageBounds:CGRectMake(0, 0, 0, 0 ) withLabelText:text font:LK_17font textColor:[UIColor whiteColor] withHeader:NO];
        _nameBtn.userInteractionEnabled = YES;

    }else{
        _nameBtn.attributedText = [NSString getAttributeStringWithimage:[UIImage imageNamed:@""] imageBounds:CGRectMake(0, 0, 0, 0 ) withLabelText:text font:LK_17font textColor:[UIColor whiteColor] withHeader:NO];
        _nameBtn.userInteractionEnabled = NO;
    }
   
    
//    [_nameBtn setTitle:text forState:UIControlStateNormal];
    
    
}


@end
