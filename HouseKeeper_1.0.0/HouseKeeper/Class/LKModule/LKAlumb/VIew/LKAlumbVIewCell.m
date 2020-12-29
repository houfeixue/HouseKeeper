//
//  LKSelectListViewCell.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKAlumbVIewCell.h"

@implementation LKAlumbVIewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier {
    LKAlumbVIewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LKAlumbVIewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)_setupViews {
    [super _setupViews];
    [self.contentView addSubview:self.picBorderView];
    [self.contentView addSubview:self.picImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.selectImage];
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(LKLeftMargin);
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@(80));
    }];
    
    [self.picBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(80));
        make.left.top.equalTo(self.picImageView).offset(2);
    }];
    
    [self.selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(LKRightMargin);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(6));
        make.height.equalTo(@(10));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picImageView.mas_right).offset(LKLeftMargin);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.selectImage.mas_left);
        make.height.equalTo(@(40));


    }];
    
}

//lazy

-(UIImageView *)picBorderView
{
    if (_picBorderView == nil) {
        _picBorderView = [[UIImageView alloc]init];
        _picBorderView.layer.borderWidth = 0.5;
//        _picBorderView.layer.borderColor =  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0].CGColor;
        _picBorderView.layer.borderColor =  [ColorUtil colorWithHex:@"#CCCCCC "].CGColor;
        
    }
    return _picBorderView;
}
-(UIImageView *)picImageView
{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc]init];
        
    }
    return _picImageView;
}
-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.numberOfLines = 3;

    }
    return _nameLabel;
}

-(UIImageView *)selectImage
{
    if (_selectImage == nil) {
        _selectImage = [[UIImageView alloc]init];
        _selectImage.image = [UIImage  imageNamed:@"app_icon_forward"];
        
    }
    return _selectImage;
}


-(void)conFigCellwithData:(id)data atIndex:(NSIndexPath *)indexPath
{
    if ([data isKindOfClass:[LKAlumbModel class]]) {
        LKAlumbModel *model = (LKAlumbModel *)data;
        _nameLabel.attributedText = [NSString getAttributeStringWithLabelText:model.name font:LK_16font textColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0] changeText:[NSString stringWithFormat:@"\n\n%@张",model.count] changeFont:LK_12font changeColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0]];
        
        if ([model.pic hasSuffix:LKPicture_Default]) {
            _picImageView.image = [UIImage imageNamed:LKPicture_Default];
        }else{
            NSString * imagePath = [NSString stringWithFormat:@"%@/%@",LKShrinkPicturePath,model.pic];
            DLog(@"imagePath :%@",imagePath);
//            _picImageView.image = [UIImage imageWithContentsOfFile:imagePath];
            [_picImageView yy_setImageWithURL:[NSURL fileURLWithPath:imagePath] placeholder:[UIImage imageNamed:LKPicture_Default]];
        }
       
    }
    

}
@end
