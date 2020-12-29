//
//  UILabel+Extension.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

//头部 尾部缩进
-(UILabel *)setHeadIndent:(CGFloat)headindent withEndIndent:(CGFloat)endindent withText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle   = [[NSMutableParagraphStyle alloc] init];
    // 首行缩进
    paragraphStyle.firstLineHeadIndent = headindent;
    //头部缩进
    [paragraphStyle setHeadIndent:headindent];
    //尾部缩进
    [paragraphStyle setTailIndent:endindent];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    [self setAttributedText:attributedString];

    return self;
}

@end
