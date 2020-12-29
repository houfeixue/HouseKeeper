//
//  LKSelectListViewCell.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSelectListViewCell.h"

@implementation LKSelectListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier {
    LKSelectListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LKSelectListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)_setupViews {
    [super _setupViews];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.selectImage];
    [self.selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(LKRightMargin);
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@(12));

    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(LKLeftMargin);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.selectImage.mas_left);
        make.height.equalTo(@(25));


    }];
    
}

//lazy
-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"小区名称小区名称";
        _nameLabel.font = LK_15font;
        _nameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];

    }
    return _nameLabel;
}

-(UIImageView *)selectImage
{
    if (_selectImage == nil) {
        _selectImage = [[UIImageView alloc]init];
        _selectImage.image = [UIImage  imageNamed:@"check_icon_selected"];
        
    }
    return _selectImage;
}

@end
