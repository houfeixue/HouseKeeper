//
//  LKPicHeaderReusableView.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/24.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPicHeaderReusableView.h"

@implementation LKPicHeaderReusableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"LKHomeCollectionReusableView.h");
        [self conFigUI:frame];
    }
    return self;
}
-(void)conFigUI:(CGRect)frame
{
    [self addSubview:self.nameLabel];
    [self addSubview:self.countLabel];
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

//lazy
-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"客服基础服务";
        _nameLabel.font = LK_12font;
        _nameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    }
    return _nameLabel;
}

-(UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.text = @"0张";
        _countLabel.font = LK_12font;
        _countLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
        _countLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countLabel;
}
@end
