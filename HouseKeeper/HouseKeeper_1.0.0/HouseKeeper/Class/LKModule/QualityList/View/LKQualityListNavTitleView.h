//
//  LKQualityListNavTitleView.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^QualityNavTitleClick)(NSString * status);

@interface LKQualityListNavTitleView : UIView

@property(nonatomic,strong)UILabel * nameBtn;
@property(nonatomic,copy)QualityNavTitleClick qualityNavTitleClick;

-(void)setTitleViewText:(NSString *)text withClick:(BOOL)click;


@end
