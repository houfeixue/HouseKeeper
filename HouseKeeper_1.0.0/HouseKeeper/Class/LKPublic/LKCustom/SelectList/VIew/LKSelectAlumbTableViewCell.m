//
//  LKSelectListViewCell.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSelectAlumbTableViewCell.h"

@implementation LKSelectAlumbTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier {
    LKSelectAlumbTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LKSelectAlumbTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        make.width.height.equalTo(@(15));
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(LKLeftMargin);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.selectImage.mas_left);
        make.height.equalTo(@(40));
        
        
    }];
    
}

//lazy

-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        
        _nameLabel.numberOfLines = 2;
        
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
