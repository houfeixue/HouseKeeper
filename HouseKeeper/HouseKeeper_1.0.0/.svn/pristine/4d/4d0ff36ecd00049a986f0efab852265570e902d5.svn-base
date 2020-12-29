//
//  LKMyHeadserCell.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/7/31.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKMyHeadserCell.h"

@implementation LKMyHeadserCell

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
     [self.contentView addSubview:self.picImageView];
     [self.contentView addSubview:self.titleLable];
     [self.contentView addSubview:self.versionImageView];
     [self.contentView addSubview:self.rightLable];
     [self.contentView addSubview:self.rightImageView];
     [self.contentView addSubview:self.lineView];
    
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).inset(LKLeftMargin);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picImageView.mas_right).inset(18);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(100);
    }];
    
    [self.versionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLable.mas_right).inset(-38);
        make.top.equalTo(self.mas_top).inset(17);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(10);
    }];
    
    [self.rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(LKLeftMargin);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(LKLeftMargin);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(10);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(kLineHeight);
    }];

}

-(void)fillCellWithDictionary:(NSDictionary *)dic
{
    self.picImageView.image = [UIImage imageNamed:[dic objectForKey:@"pic"]] ;
    self.titleLable.text = [dic objectForKey:@"title"];
}


///lazy
-(UIImageView *)picImageView
{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc] init];
    }
    return _picImageView;
}

-(UILabel *)titleLable
{
    if(_titleLable == nil)
    {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.font = LK_15font;
        _titleLable.textColor =  LKGrayColor;
    }
    return _titleLable;
}
-(UIImageView *)versionImageView
{
    if (_versionImageView == nil) {
        _versionImageView = [[UIImageView alloc] init];
        _versionImageView.image = [UIImage imageNamed:@"new"];
    }
    return _versionImageView;
}

-(UILabel *)rightLable
{
    if(_rightLable == nil)
    {
        _rightLable = [[UILabel alloc] init];
        _rightLable.textAlignment = NSTextAlignmentRight;
        _rightLable.font = LK_15font;
        _rightLable.textColor =  LKGrayColor;
    }
    return _rightLable;
}

-(UIImageView *)rightImageView
{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"app_icon_forward"];
    }
    return _rightImageView;
}

-(UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1/1.0];
    }
    return _lineView;
}

@end
