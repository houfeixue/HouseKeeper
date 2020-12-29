//
//  LKPicturesHeadView.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPicturesHeadView.h"

@implementation LKPicturesHeadView

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
    [self addSubview:self.nameLabel];
    [self addSubview:self.countLabel];
    self.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(LKRightMargin);
        make.centerY.equalTo(self);
        make.width.equalTo(@(50));
        make.height.equalTo(@(30));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(LKLeftMargin);
        make.centerY.equalTo(self);
        make.right.equalTo(self.countLabel.mas_left);
        make.height.equalTo(@(30));
    }];
}

-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"客服基础服务";
        _nameLabel.font = LK_medium_18font;
        _nameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];

    }
    return _nameLabel;
}

-(UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.text = @"88";
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.font = LK_medium_16font;
        _countLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
        
    }
    return _countLabel;
}
-(void)conDataName:(NSString *)Name withCount:(NSString * )count
{
    _nameLabel.text = Name;
    _countLabel.text = [NSString stringWithFormat:@"%@张",count];
}

@end
