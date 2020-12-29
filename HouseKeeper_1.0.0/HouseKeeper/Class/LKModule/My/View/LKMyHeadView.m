//
//  LKMyHeadView.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/7/31.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKMyHeadView.h"

@implementation LKMyHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}


-(void)createUI
{
    [self addSubview:self.bgView];
    [self addSubview:self.personImageView];
    [self addSubview:self.nameLable];
    [self addSubview:self.identityLable];
    [self addSubview:self.numberLable];
    [self addSubview:self.idetButton];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).inset(LKLeftMargin);
        make.top.equalTo(self.mas_top).inset(LKLeftMargin);
        make.right.equalTo(self.mas_right).inset(LKLeftMargin);
        make.bottom.equalTo(self.mas_bottom).inset(LKLeftMargin);
    }];
    
    [self.personImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).inset(LKLeftMargin);
        make.centerY.equalTo(self.bgView.mas_centerY);
        make.width.height.mas_equalTo(105);
    }];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.personImageView.mas_right).inset(50);
        make.top.equalTo(self.personImageView.mas_top).inset(10);
        make.right.equalTo(self.bgView.mas_right);
    }];
    [self.identityLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.personImageView.mas_right).inset(50);
        make.top.equalTo(self.nameLable.mas_bottom).inset(10);
        make.right.equalTo(self.bgView.mas_right);
    }];
    [self.numberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.personImageView.mas_right).inset(50);
        make.top.equalTo(self.identityLable.mas_bottom).inset(10);
        make.right.equalTo(self.bgView.mas_right);
    }];
    
    [self.idetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).inset(10);
        make.top.equalTo(self.bgView.mas_top).inset(10);
        make.width.height.mas_equalTo(30);
    }];
    
}
-(UIView *)bgView
{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.layer.cornerRadius = 10;
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}

-(UIImageView *)personImageView
{
    if (_personImageView == nil) {
        _personImageView = [[UIImageView alloc] init];
        _personImageView.contentMode = UIViewContentModeScaleAspectFill;
        _personImageView.layer.borderWidth = 0.1;
        _personImageView.layer.borderColor =LKLightGrayColor.CGColor;
//        _personImageView.layer.shadowOffset =  CGSizeMake(0, 0);
//        _personImageView.layer.shadowOpacity = 0.8;
//        _personImageView.layer.shadowColor =  [UIColor blackColor].CGColor;
    }
    return _personImageView;
}

-(UILabel *)nameLable
{
    if(_nameLable == nil)
    {
        _nameLable = [[UILabel alloc] init];
        _nameLable.textAlignment = NSTextAlignmentLeft;
        _nameLable.font = LK_15font;
        _nameLable.textColor =  LKGrayColor;
    }
    return _nameLable;
}

-(UILabel *)identityLable
{
    if(_identityLable == nil)
    {
        _identityLable = [[UILabel alloc] init];
        _identityLable.textAlignment = NSTextAlignmentLeft;
        _identityLable.font = LK_15font;
        _identityLable.textColor =  LKGrayColor;
    }
    return _identityLable;
}

-(UILabel *)numberLable
{
    if(_numberLable == nil)
    {
        _numberLable = [[UILabel alloc] init];
        _numberLable.textAlignment = NSTextAlignmentLeft;
        _numberLable.font = LK_15font;
        _numberLable.textColor =  LKGrayColor;
    }
    return _numberLable;
}

-(UIButton *)idetButton{
    if (_idetButton == nil) {
        _idetButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _idetButton;
}

@end
