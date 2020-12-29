//
//  LKLookPicViewCell.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/23.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKLookPicViewCell.h"
#import "LKQualityReportModel.h"
#import "LKLookPicCategoryModel.h"

@implementation LKLookPicViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _setUpView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)_setUpView
{
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.picImageView];
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(4));
        make.height.equalTo(@(12));
        make.left.equalTo(self.contentView);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView);
        make.left.equalTo(self.picImageView.mas_right).offset(5);;
        make.bottom.equalTo(self.contentView).offset(-10);

    }];
}

//lazy
-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = LK_14font;
        _nameLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

-(UIImageView *)picImageView
{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc]init];
        _picImageView.backgroundColor = [UIColor blackColor];
    }
    return _picImageView;
}
-(void)setViewWithModel:(id)model withSelect:(BOOL)select
{
    if ([model isKindOfClass:[LKQualityReportModel class]]) {
        LKQualityReportModel * m = ( LKQualityReportModel * )model;
        if (select) {
            _picImageView.hidden = NO;
            self.contentView.backgroundColor = [UIColor whiteColor];
        }else{
            _picImageView.hidden = YES;
            self.contentView.backgroundColor = LKF7Color;
            
        }
        _nameLabel.text = m.categoryName;
    }else if ([model isKindOfClass:[LKQualityDetailModel class]]){
        
        LKQualityDetailModel * m = ( LKQualityDetailModel * )model;
        if (select) {
            _picImageView.hidden = NO;
            self.contentView.backgroundColor = [UIColor whiteColor];
        }else{
            _picImageView.hidden = YES;
            self.contentView.backgroundColor = LKF7Color;
            
        }
        _nameLabel.text = m.categoryName;
    }else if ([model isKindOfClass:[LKLookPicCategoryModel class]]){
        
        LKLookPicCategoryModel * m = ( LKLookPicCategoryModel * )model;
        if (select) {
            _picImageView.hidden = NO;
            self.contentView.backgroundColor = [UIColor whiteColor];
            
            _nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
            _nameLabel.textColor = [UIColor colorWithRed:66/255.0 green:65/255.0 blue:82/255.0 alpha:1/1.0];
        }else{
            _picImageView.hidden = YES;
            self.contentView.backgroundColor = LKF7Color;
            _nameLabel.font = LK_14font;
            _nameLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
            
        }
        _nameLabel.text = m.categoryName;
    }
    
}
@end
