//
//  LKWorkUpLoadViewCell.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/30.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKWorkUpLoadViewCell.h"
#import "LKQualityListModel.h"
@implementation LKWorkUpLoadViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//重写view
- (void)_setupViews
{
    [self.contentView addSubview:self.picImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.scoreLabel];
    [self.contentView addSubview:self.uploadBtn];
    [self.contentView addSubview:self.lineView];
    
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(LKLeftMargin);
        make.width.height.equalTo(@(20));
        make.top.equalTo(self.contentView).offset(18);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(LKRightMargin);
        make.top.equalTo(self.contentView).offset(18);
        make.width.equalTo(@(50));
        make.height.equalTo(@(20));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scoreLabel.mas_left).offset(-5);
        make.top.equalTo(self.contentView).offset(18);
        make.left.equalTo(self.picImageView.mas_right).offset(10);
        make.height.equalTo(@(20));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(20);
        make.left.equalTo(self).offset(LKLeftMargin);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@(30));

    }];
    
    
    [self.uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(14);
        make.height.equalTo(@(50));
        make.width.equalTo(@(kScreen_Width));

    }];
    
    [self.uploadBtn borderForColor:LKF2Color borderWidth:1 borderType:UIBorderSideTypeTop];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(20));
    }];
}

-(void)conFigCellwithData:(id)data atIndex:(NSIndexPath *)indexPath
{
    if ([data isKindOfClass:[LKQualityListModel class]]) {
        LKQualityListModel *model = (LKQualityListModel *)data;
        _nameLabel.text = model.ruleInfo;
        _scoreLabel.text = [NSString stringWithFormat:@"%@分",model.fullMark];
        NSURL * imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LKIconHost,model.iconUrl]];
        [_picImageView yy_setImageWithURL:imageUrl placeholder:[UIImage imageNamed:LKPicture_Default]];
        
        
       NSArray * imageArray = [LKCustomMethods getUpLoadImagesCountFromCategoryId:model.detailId];
        _detailLabel.attributedText = [self getDetailUpCount:[NSString stringWithFormat:@"%@",model.imgNumber] withDelayCount:[NSString stringWithFormat:@"%lu",(unsigned long)imageArray.count]];
//        [NSString stringWithFormat:@"已上传 %@ 张  %lu 张待传",model.imgNumber,(unsigned long)imageArray.count];

    }
}


-(NSMutableAttributedString * )getDetailUpCount:(NSString *)upCount withDelayCount:(NSString *)count
{
    NSMutableAttributedString * firstPart = [[NSMutableAttributedString alloc] initWithString:@"已上传"];
    NSDictionary * firstAttributes = @{ NSFontAttributeName:LK_14font,NSForegroundColorAttributeName:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0],};
    [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
    
    NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@ ",upCount]];
    
    NSDictionary * secondAttributes = @{ NSFontAttributeName:LK_14font,NSForegroundColorAttributeName:LKBlueColor,};
    [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
    
    [firstPart appendAttributedString:secondPart];
    
    NSMutableAttributedString * thirdPart = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"张  "]];
    
    NSDictionary * thirdAttributes = @{ NSFontAttributeName:LK_14font,NSForegroundColorAttributeName:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0],};
    [thirdPart setAttributes:thirdAttributes range:NSMakeRange(0,thirdPart.length)];
    [firstPart appendAttributedString:thirdPart];
    
    
    
    NSMutableAttributedString * fourPart = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@ ",count]];
    
    NSDictionary * fourAttributes = @{ NSFontAttributeName:LK_14font,NSForegroundColorAttributeName:LKBlueColor,};
    [fourPart setAttributes:fourAttributes range:NSMakeRange(0,fourPart.length)];
    [firstPart appendAttributedString:fourPart];
    
    
    NSMutableAttributedString * fivePart = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"张待传"]];
    
    NSDictionary * fiveAttributes = @{ NSFontAttributeName:LK_14font,NSForegroundColorAttributeName:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0],};
    [fivePart setAttributes:fiveAttributes range:NSMakeRange(0,fivePart.length)];
    [firstPart appendAttributedString:fivePart];
    
    

    
    return firstPart;
    
}

//lazy
-(UIImageView *)picImageView
{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc]init];
        //        _picImageView.image = [UIImage imageNamed:@"check_icon_car"];
    }
    return _picImageView;
}
-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"客服基础服务";
        _nameLabel.font = LK_medium_18font;//[UIFont fontWithName:@"PingFangSC-Medium" size:18];
        _nameLabel.textColor = LKBlackColor;
        
        
    }
    return _nameLabel;
}
-(UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = LK_14font;
        _detailLabel.textColor = LK99Color;
        _detailLabel.text = @" 张待传";
        
    }
    return _detailLabel;
}
-(UILabel *)scoreLabel
{
    if (_scoreLabel == nil) {
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.text = @"16分";
        _scoreLabel.font = LK_medium_16font;[UIFont fontWithName:@"PingFangSC-Medium" size:16];
        _scoreLabel.textColor = LKBlackColor;
        _scoreLabel.textAlignment = NSTextAlignmentRight;
    }
    return _scoreLabel;
}
-(UIButton *)uploadBtn
{
    if(_uploadBtn == nil ){
        _uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_uploadBtn setTitle:@"确定上传" forState:UIControlStateNormal];
        [_uploadBtn setTitleColor:LKBlueColor forState:UIControlStateNormal];
        _uploadBtn.titleLabel.font = LK_14font;
        @weakify(self)
        [[_uploadBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            if (self.workUpLoadClick) {
                self.workUpLoadClick(@"");
            }
            
        }];
    }
    return _uploadBtn;
}

-(UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = LKF7Color;
    }
    return _lineView;
}



@end
