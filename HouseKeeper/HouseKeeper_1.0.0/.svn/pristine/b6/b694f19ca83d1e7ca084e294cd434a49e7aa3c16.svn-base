//
//  EaseBlankPageView.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/8/2.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "EaseBlankPageView.h"

@implementation EaseBlankPageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    self.alpha = 1.0;
    //    图片
    if (!_monkeyView) {
        _monkeyView = [[UIImageView alloc] init];
        [self addSubview:_monkeyView];
        
    }
    //    文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = LK_medium_20font;
        _tipLabel.textColor = LKGrayColor;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    
    //    布局
    [_monkeyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).inset(50);
        make.width.height.mas_equalTo(160);
    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).inset(LKLeftMargin);
        make.top.equalTo(self.monkeyView.mas_bottom).inset(35);
        make.right.equalTo(self.mas_right).inset(LKLeftMargin);
    }];
    
    _reloadButtonBlock = nil;
    
    if (!_reloadButton) {
        _reloadButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
        _reloadButton.layer.cornerRadius = 4;
        _reloadButton.clipsToBounds = YES;
        _reloadButton.backgroundColor = LKBlackColor;
        [_reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_reloadButton];
        [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.tipLabel.mas_bottom).inset(117);
            make.size.mas_equalTo(CGSizeMake(170, 49));
        }];
    }
    _reloadButton.hidden = NO;
    _reloadButtonBlock = block;
    
    if (hasError) {
        //        加载失败
        [_monkeyView setImage:[UIImage imageNamed:@"Reload_icon"]];
        _tipLabel.text = @"抱歉，数据加载失败，请重试";
        
    }else{
        //        空白数据
        if (_reloadButton) {
            _reloadButton.hidden = NO;
        }
        NSString *imageName, *tipStr;
        switch (blankPageType) {
                
            case EaseBlankPageTypeNoNetWork:
            {
                imageName = @"Network_failure";
                tipStr = @"网络不太给力喔，再试一下吧";
            }
                break;
                
            case EaseBlankPageTypeNoButton_albem:
            {
                imageName = @"noPhoto_icon";
                tipStr = @"暂时没有图片喔";
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            }
                break;
            
            case EaseBlankPageTypeNoButton_messageCenter:
            {
                imageName = @"NO_people_help";
                tipStr = @"还没有人找你帮忙喔";
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            }
                break;
                
            case EaseBlankPageTypeNoButton_community:
            {
                imageName = @"no_search_result";
                tipStr = @"找不到小区";
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            }
                break;
                
            case EaseBlankPageTypeNoButton_checkRecode:
            {
                imageName = @"NO_check_record";
                tipStr = @"暂无抽查记录";
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            }
                break;
            case EaseBlankPageTypeNoButton_noData:
            {
                imageName = @"NO_check_record";
                tipStr = @"暂无数据";
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            }
                
                break;
            case EaseBlankPageTypeNoButton_noImageData:
            {
                imageName = @"noPhoto_icon";
                tipStr = @"暂时没有图片哦";
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            }
                
                break;
            default://其它页面（这里没有提到的页面，都属于其它）
            {
                imageName = @"NO_check_record";
                tipStr = @"暂无数据";
            }
                break;
        }
        [_monkeyView setImage:[UIImage imageNamed:imageName]];
        _tipLabel.text = tipStr;
    }
}

- (void)reloadButtonClicked:(id)sender{
    self.hidden = YES;
    [self removeFromSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.reloadButtonBlock) {
            self.reloadButtonBlock(sender);
        }
    });
}

@end
