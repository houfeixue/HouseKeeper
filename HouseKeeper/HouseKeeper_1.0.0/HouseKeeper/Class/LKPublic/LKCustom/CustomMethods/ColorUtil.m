//
//  ColorUtil.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/11.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "ColorUtil.h"

@implementation ColorUtil
+ (UIColor*)colorWithHex:(NSString*)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] < 6) return [UIColor blackColor];
    // Separate into r, g, b substrings
    NSRange range;
    if ([cString length] > 6) {
        range.location = 2;
    }else {
        range.location = 0;
    }
    
    
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location += 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location += 2;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b ;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


+ (UIColor*)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b
{
    return [UIColor colorWithRed: r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}
@end
