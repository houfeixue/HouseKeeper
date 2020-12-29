//
//  UIButton+Extension.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/18.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

//文字图片偏移
-(void)setTitleEdgeInsets:(UIEdgeInsets )titleRect withImageEdgeInsets:(UIEdgeInsets )imageRect
{
    [self setTitleEdgeInsets:titleRect];
    
    [self setImageEdgeInsets:imageRect];
}

@end
