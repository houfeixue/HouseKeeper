//
//  LKQualityDetailViewCell.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/18.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKQualityDetailViewCell.h"
#import "LKQualityDetailModel.h"

@implementation LKQualityDetailViewCell

-(void)_setupViews
{
    self.contentView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];;
    
    [self.contentView addSubview:self.whiteView];
    [self.whiteView addSubview:self.nameLabel];
    [self.whiteView addSubview:self.nameDetailLabel];
    [self.whiteView addSubview:self.lineView];
    [self.whiteView addSubview:self.scoreNameLabel];
    [self.whiteView addSubview:self.scoreLabel];
    [self.whiteView addSubview:self.lineView2];
    [self.whiteView addSubview:self.describeTitleLabel];
    [self.whiteView addSubview:self.describeLabel];
    [self.whiteView addSubview:self.imagesView];
    [self.whiteView addSubview:self.lineView3];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(LKLeftMargin);
        make.right.equalTo(self.whiteView).offset(LKRightMargin);
        make.top.equalTo(self.whiteView).offset(15);
        make.height.equalTo(@(20));
    }];
    [self.nameDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(LKLeftMargin);
        make.right.equalTo(self.whiteView).offset(LKRightMargin);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(6);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView);
        make.right.equalTo(self.whiteView);
        make.top.equalTo(self.nameDetailLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(kLineHeight);
    }];
    [self.scoreNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(LKLeftMargin);;
        make.width.equalTo(@(100));
        make.top.equalTo(self.lineView.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(LKRightMargin);;
        make.width.equalTo(@(100));
        make.top.equalTo(self.lineView.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView);
        make.right.equalTo(self.whiteView);
        make.top.equalTo(self.scoreLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(kLineHeight);
    }];
    [self.describeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(LKLeftMargin);
        make.right.equalTo(self.whiteView).offset(LKRightMargin);
        make.top.equalTo(self.lineView2.mas_bottom).offset(10);
    }];
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(LKLeftMargin);
        make.right.equalTo(self.whiteView).offset(LKRightMargin);
        make.top.equalTo(self.describeTitleLabel.mas_bottom).offset(5);
    }];
    
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView);
        make.right.equalTo(self.whiteView);
        make.height.equalTo(@(1));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.top.equalTo(self.lineView3.mas_bottom).offset(7);
    }];
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.describeLabel.mas_bottom);
        make.height.mas_equalTo(kLineHeight);
    }];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(LKLeftMargin);
        make.right.equalTo(self.contentView).offset(LKRightMargin);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    
}
-(void)conFigCellwithData:(id)data atIndex:(NSIndexPath *)indexPath
{
    LKQualityDetailListModel *model = (LKQualityDetailListModel *)data;
    
    self.nameLabel.attributedText = [NSString getAttributeStringWithimage:[UIImage imageNamed:@"line"] imageBounds:CGRectMake(0, 0, 4, 14) withLabelText:[NSString stringWithFormat:@"  %@",model.itemsName] font:LK_16font textColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1/1.0]];
    NSString *scoreString = [NSString stringWithFormat:@"%lf",model.scort];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:scoreString];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@分",[decNumber stringValue]];
    self.describeLabel.text = model.ruleDesc;
    CGFloat isAddDescribeMargin = 0;
    if(self.describeLabel.text.length ==0){
        self.describeTitleLabel.text = @"";
        [self.describeTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteView).offset(LKLeftMargin);
            make.right.equalTo(self.whiteView).offset(LKRightMargin);
            make.top.equalTo(self.lineView2.mas_bottom).offset(0);

        }];
        [self.lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteView);
            make.right.equalTo(self.whiteView);
            make.top.equalTo(self.scoreLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(0);
        }];
    }else{
         self.describeTitleLabel.text =  @"扣分描述";
        [self.describeTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteView).offset(LKLeftMargin);
            make.right.equalTo(self.whiteView).offset(LKRightMargin);
            make.top.equalTo(self.lineView2.mas_bottom).offset(10);
        }];
        [self.lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteView);
            make.right.equalTo(self.whiteView);
            make.top.equalTo(self.scoreLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(kLineHeight);
        }];
        isAddDescribeMargin = 12;

    }
    self.nameDetailLabel.text = model.ruleInfo;
    [LKCustomMethods removeViewFromSuperView:self.imagesView];
    UIImageView * imageView;
    CGFloat imageWidth = (kScreen_Width - 7*LKLeftMargin)/4;
    for (int i = 0; i< model.images.count; i++) {
        LKQualityDetailImageInfoModel *imageModel = [model.images objectAtIndex:i];
        UIImageView * iView =[[UIImageView alloc] init];
        
        [iView yy_setImageWithURL:[[NSString stringWithFormat:@"%@%@%@",LKIconHost,imageModel.url,LKNetShrinkPic_Default] toURL] placeholder:[UIImage imageNamed:LKPicture_Default]];
        [self.imagesView addSubview:iView];
        if (i%4==0) {
            [iView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.imagesView).offset(LKLeftMargin);
                make.width.height.equalTo(@(imageWidth));
                make.top.equalTo(self.imagesView).offset(10 + i/4 * (imageWidth +10));
            }];
        }else{
            [iView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageView.mas_right).offset(LKLeftMargin);
                make.width.height.equalTo(@(imageWidth));
                make.top.equalTo(self.imagesView).offset(10 + i/4 * (imageWidth +10) );
            }];
        }
        iView.tag = i;
        iView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
        [iView addGestureRecognizer:tap];
        imageView = iView;
    }
    if (imageView != nil) {
        [self.imagesView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteView);
            make.right.equalTo(self.whiteView);
            make.top.equalTo(self.lineView3.mas_bottom).offset(7);
            make.bottom.equalTo(imageView.mas_bottom).offset(7);
            make.bottom.equalTo(self.whiteView.mas_bottom).offset(-7);
           
        }];
        if ([LKCustomTool isBlankString:self.describeLabel.text]) {
            [self.lineView3 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.top.equalTo(self.scoreNameLabel.mas_bottom).offset(10);
                make.height.mas_equalTo(kLineHeight);
            }];
        }else {
            [self.lineView3 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.top.equalTo(self.describeLabel.mas_bottom).offset(7);
                make.height.mas_equalTo(kLineHeight);
            }];
        }

    }else {
        [self.imagesView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteView);
            make.right.equalTo(self.whiteView);
            make.top.equalTo(self.lineView3.mas_bottom).offset(isAddDescribeMargin);
            make.bottom.equalTo(self.whiteView.mas_bottom).offset(0);
        }];
        [self.lineView3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(self.describeLabel.mas_bottom);
            make.height.mas_equalTo(0);
        }];
    }
}
- (void)imageViewTap:(UIGestureRecognizer *)gesture {
    NSInteger tag = gesture.view.tag;
    if (self.imageTapBlock != nil) {
        self.imageTapBlock(tag, self.imagesView);
    }    
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
    }
    return _nameLabel;
}

-(UILabel *)nameDetailLabel
{
    if (_nameDetailLabel == nil) {
        _nameDetailLabel = [[UILabel alloc]init];
        _nameDetailLabel.font = LK_12font;
        _nameDetailLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];

        
    }
    return _nameDetailLabel;
}


-(UIView *)lineView
{
    if (_lineView == nil) {
        _lineView =[[UIView alloc]init];
        _lineView.backgroundColor = LKF7Color;
    }
    return _lineView;
}
-(UIView *)lineView3
{
    if (_lineView3 == nil) {
        _lineView3 =[[UIView alloc]init];
        _lineView3.backgroundColor = LKF7Color;
    }
    return _lineView3;
}
-(UILabel *)scoreNameLabel
{
    if (_scoreNameLabel == nil) {
        _scoreNameLabel = [[UILabel alloc]init];
        _scoreNameLabel.text = @"实际得分";
        _scoreNameLabel.font = LK_13font;
        _scoreNameLabel.textColor =  [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
    }
    return _scoreNameLabel;
}
-(UILabel *)scoreLabel
{
    if (_scoreLabel == nil) {
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.text = @"分";
        _scoreLabel.font = LK_14font;
        _scoreLabel.textColor =  LKLightRedColor;
        _scoreLabel.textAlignment = NSTextAlignmentRight;

    }
    return _scoreLabel;
}

-(UIView *)lineView2
{
    if (_lineView2 == nil) {
        _lineView2 =[[UIView alloc]init];
        _lineView2.backgroundColor = LKF7Color;
    }
    return _lineView2;
}
-(UILabel *)describeLabel
{
    if (_describeLabel == nil) {
        _describeLabel = [[UILabel alloc]init];
        _describeLabel.font = LK_13font;
        _describeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
        _describeLabel.numberOfLines = 0;

    }
    return _describeLabel;
}
- (UILabel *)describeTitleLabel {
    if (_describeTitleLabel == nil) {
        _describeTitleLabel = [[UILabel alloc]init];
        _describeTitleLabel.font = LK_13font;
        _describeTitleLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
        _describeTitleLabel.text = @"扣分描述";
    }
    return _describeTitleLabel;
}
-(UIView *)imagesView
{
    if (_imagesView == nil) {
        _imagesView =[[UIView alloc]init];
        _imagesView.backgroundColor = [UIColor whiteColor];
    }
    return _imagesView;
}
@end
