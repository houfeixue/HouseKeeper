//
//  LKHomeTableViewCell.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/10.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKHomeTableViewCell.h"

@implementation LKHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)_setupViews
{
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.btn];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.contentView);
        make.width.equalTo(@(50));
    }];
}

-(void)conFigCellwithData:(id)data atIndex:(NSIndexPath *)indexPath
{
    if ([data isKindOfClass:[NSString class]]) {
        
        _nameLabel.text = [NSString stringWithFormat:@"%@",data];
    }
}

//lazy
-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor redColor];
    }
    return _nameLabel;
}

-(UIButton *)btn{
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor redColor];
         @weakify(self)
        [[[_btn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:self.rac_prepareForReuseSignal]subscribeNext:^(id x) {
             @strongify(self);
            if (self.btnClick) {
                self.btnClick(@"");
            }
            
        }];
        
    }
    return _btn;
}
@end
