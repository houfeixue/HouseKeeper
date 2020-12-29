//
//  LKPersonMessageFirstCell.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/7/31.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPersonMessageFirstCell.h"

@implementation LKPersonMessageFirstCell

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
    [self.contentView addSubview:self.personImageView];
    [self.contentView addSubview:self.valueTextFiled];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).inset(LKLeftMargin);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(60);
    }];
    
    [self.personImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(LKLeftMargin);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(50);
    }];
    
    [self.valueTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(LKLeftMargin);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.titleLable.mas_right).inset(5);
    }];
}

/////
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

-(UIImageView *)personImageView
{
    if (_personImageView == nil) {
        _personImageView = [[UIImageView alloc] init];
        _personImageView.layer.cornerRadius = 25;
        _personImageView.clipsToBounds = YES;
        _personImageView.layer.borderWidth = 0.1;
        _personImageView.layer.borderColor =LKLightGrayColor.CGColor;
        _personImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _personImageView;
}

-(UITextField *)valueTextFiled
{
    if (_valueTextFiled == nil) {
        _valueTextFiled = [[UITextField alloc] init];
        _valueTextFiled.borderStyle = UITextBorderStyleNone;
        _valueTextFiled.font = LK_15font;
        _valueTextFiled.textColor = LKGrayColor;
        _valueTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _valueTextFiled.textAlignment = NSTextAlignmentRight;
    }
    return _valueTextFiled;
}

@end
