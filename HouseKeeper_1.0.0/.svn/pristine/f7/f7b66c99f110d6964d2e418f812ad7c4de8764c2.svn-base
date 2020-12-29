//
//  LKQualityReportViewCell.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKQualityReportViewCell.h"
#import "LKQualityReportModel.h"

@implementation LKQualityReportViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier {
    LKQualityReportViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LKQualityReportViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)_setupViews
{
    self.contentView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1/1.0];
    [self.contentView addSubview:self.whiteView];
    [self.whiteView addSubview:self.scoreLabel];
    [self.whiteView addSubview:self.nameLabel];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.whiteView.mas_centerY);
        make.right.equalTo(self.whiteView.mas_right).offset(LKRightMargin);
        make.width.equalTo(@(55));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LKLeftMargin);
        make.right.equalTo(self.scoreLabel.mas_left);
        make.top.equalTo(self.whiteView).offset(15);
        make.bottom.equalTo(self.whiteView).offset(-15);

    }];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(LKLeftMargin);
        make.right.equalTo(self.contentView).offset(LKRightMargin);
        make.top.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView);
    }];
    self.whiteView.layer.cornerRadius = 5;
}


-(void)conFigCellwithData:(id)data atIndex:(NSIndexPath *)indexPath
{
    LKQualityDetailListModel *model = (LKQualityDetailListModel *)data;
    
    self.nameLabel.attributedText = [NSString getAttributeStringWithimage:[UIImage imageNamed:@"line"] imageBounds:CGRectMake(0, 0, 4, 12) withLabelText:[NSString stringWithFormat:@"  %@",model.itemsName] font:LK_14font textColor:LKGrayColor];
    NSString *scoreString = [NSString stringWithFormat:@"%lf",model.scort];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:scoreString];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@分",[decNumber stringValue]];
    
    
}

//lazy

-(UIView *)whiteView
{
    if (_whiteView == nil) {
        _whiteView = [[UIView alloc]init];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.cornerRadius = 5;
        
    }
    return _whiteView;
}

-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

-(UILabel *)scoreLabel
{
    if (_scoreLabel == nil) {
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.text = @"1分";
        _scoreLabel.font = LK_12font;
        _scoreLabel.textColor = [UIColor colorWithRed:192/255.0 green:97/255.0 blue:99/255.0 alpha:1/1.0];
        _scoreLabel.textAlignment = NSTextAlignmentRight;
    }
    return _scoreLabel;
}


@end
