//
//  LKBaseTableViewCell.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/10.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewCell.h"

@implementation LKBaseTableViewCell

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
        [self _setupViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

//重写view
- (void)_setupViews {
    
    [self.contentView addSubview:self.separatorView];
    [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(LKLeftMargin);
        make.right.equalTo(self.contentView).offset(LKRightMargin);
        make.height.equalTo(@(kLineHeight));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        
    }];
}

//重写
-(void)conFigCellwithData:(id)data atIndex:(NSIndexPath *)indexPath
{
    
}


//lazy
-(UIView *)separatorView
{
    
    if (_separatorView == nil) {
        _separatorView = [[UIView alloc]init];
        _separatorView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1/1.0];;
        _separatorView.hidden = YES;
    }
    return _separatorView;
    
}
@end
