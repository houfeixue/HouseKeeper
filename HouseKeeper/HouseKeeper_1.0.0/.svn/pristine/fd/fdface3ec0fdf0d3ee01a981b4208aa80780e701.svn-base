//
//  LKCommunityCell.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/7/31.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKCommunityCell.h"
#import "JCAlertView.h"

@implementation LKCommunityCell
{
    JCAlertView *_alert;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)_setupViews
{
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.rightLable];
    [self.contentView addSubview:self.tipImage];
    [self.contentView addSubview:self.line];
    
    [self.rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(LKLeftMargin);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(50);
        
    }];
    
    [self.tipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightLable.mas_left).inset(2);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(12);
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tipImage.mas_left).inset(2);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).inset(LKLeftMargin);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(kLineHeight);
    }];
}

////
-(UILabel *)titleLable
{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.font = LK_15font;
        _titleLable.textColor = LKLightGrayColor;
        _titleLable.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _titleLable.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLable;
}

-(UILabel *)rightLable
{
    if (_rightLable == nil) {
        _rightLable = [[UILabel alloc] init];
        _rightLable.font = LK_15font;
        _rightLable.textAlignment = NSTextAlignmentRight;
    }
    return _rightLable;
}

-(UIImageView *)tipImage
{
    if (_tipImage == nil) {
        _tipImage = [[UIImageView alloc] init];
    }
    return _tipImage;
}

-(UIView *)line
{
    if (_line == nil) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHue:242/255.0 saturation:242/255.0 brightness:242/255.0 alpha:1/1.0];
    }
    return _line;
}
@end
