//
//  NSString+Extension.m
//  rqbao
//
//  Created by sunny on 2018/1/17.
//  Copyright © 2018年 sunny. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (NSURL *)toURL {
    return [NSURL URLWithString:[self addPercentUTF8]];
}
- (NSString *)addPercentUTF8 {
    NSString *percent = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *replacePercent = [percent stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return replacePercent;
}
- (NSString *)removeAllSapce {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
+ (NSMutableAttributedString *)getAttributeStringWithLabelText:(NSString *)labelText font:(UIFont *)font textColor:(UIColor *)textColor changeText:(NSString *)changeText changeFont:(UIFont *)changeFont changeColor:(UIColor *)changeColor {
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",labelText,changeText]];
    attribute.yy_font = font;
    attribute.yy_color = textColor;
    [attribute yy_setFont:changeFont range:NSMakeRange(labelText.length, changeText.length)];
    [attribute yy_setColor:changeColor range:NSMakeRange(labelText.length, changeText.length)];
    return attribute;
}

/** image + labelText == 返回的字符串  */


+ (NSMutableAttributedString *)getAttributeStringWithimage:(UIImage *)image imageBounds:(CGRect)frame withLabelText:(NSString *)labelText font:(UIFont *)font textColor:(UIColor *)textColor withHeader:(BOOL)header{
    
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:labelText];
    [string addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, labelText.length)];
    [string addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, string.length)];
    
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = image;
    attach.bounds = frame;
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    
    
    //将图片插入到合适的位置
    if (header) {
        [string insertAttributedString:attachString atIndex:0];

    }else{
        [string insertAttributedString:attachString atIndex: string.length];

    }
    
    return string;
}

+ (NSMutableAttributedString *)getAttributeStringWithimage:(UIImage *)image imageBounds:(CGRect)frame withLabelText:(NSString *)labelText font:(UIFont *)font textColor:(UIColor *)textColor
{
   return  [NSString getAttributeStringWithimage:image imageBounds:frame withLabelText:labelText font:font textColor:textColor withHeader:YES];
}

- (BOOL)judgePasswordLegal{
    BOOL result = false;
    if (self.length >= 6  && self.length <= 16){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:self];
    }
    return result;
}

/////////////////////
+(NSMutableAttributedString *)changeTextColorWithColor:(UIColor *)color string:(NSString *)str andSubString:(NSArray *)subStringArr{
    
    //把字符串  转位 富文本
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    
    for (NSString *string in subStringArr) {
        //获取某个子字符串在某个总字符串中位置数组
        NSMutableArray *array = [self getRangeWithTotalString:str SubString:string];
        
        //
        for (NSNumber *rangeNum in array) {
            NSRange range = [rangeNum rangeValue];
            [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
    }
    return attributedString;
    
}


#pragma mark - 获取某个子字符串在某个总字符串中位置数组
/**
 *  获取某个字符串中子字符串的位置数组
 *
 *  @param totalString 总的字符串
 *  @param subString   子字符串
 *
 *  @return 位置数组
 */
+ (NSMutableArray *)getRangeWithTotalString:(NSString *)totalString SubString:(NSString *)subString {
    
    NSMutableArray *arrayRanges = [NSMutableArray array];
    
    if (subString == nil && [subString isEqualToString:@""]) {
        return nil;
    }
    
    NSRange rang = [totalString rangeOfString:subString];
    
    if (rang.location != NSNotFound && rang.length != 0) {
        
        [arrayRanges addObject:[NSNumber valueWithRange:rang]];
        
        NSRange      rang1 = {0,0};
        NSInteger location = 0;
        NSInteger   length = 0;
        
        for (int i = 0;; i++) {
            
            if (0 == i) {
                
                location = rang.location + rang.length;
                length = totalString.length - rang.location - rang.length;
                rang1 = NSMakeRange(location, length);
            } else {
                
                location = rang1.location + rang1.length;
                length = totalString.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }
            
            rang1 = [totalString rangeOfString:subString options:NSCaseInsensitiveSearch range:rang1];
            
            if (rang1.location == NSNotFound && rang1.length == 0) {
                
                break;
            } else {
                
                [arrayRanges addObject:[NSNumber valueWithRange:rang1]];
            }
        }
        
        return arrayRanges;
    }
    
    return nil;
}


/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)changeFontAndColor:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray {
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    
    
    for (NSString *string in subArray) {
        //获取某个子字符串在某个总字符串中位置数组
        NSMutableArray *array = [self getRangeWithTotalString:totalString SubString:string];
        
        //
        for (NSNumber *rangeNum in array) {
            NSRange range = [rangeNum rangeValue];
            //改变颜色
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
            //改变字体
            [attributedStr addAttribute:NSFontAttributeName value:font range:range];
        }
    }
    return attributedStr;
}

#pragma mark-----为某些文字下面画线  (中画线 / 下画线)
/**
 *  为某些文字下面画线
 *
 *  @param totalString 总的字符串
 *  @param subArray    需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)addLinkWithTotalString:(NSString *)totalString andLineColor:(UIColor *)lineColor SubStringArray:(NSArray *)subArray {
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    
    for (NSString *string in subArray) {
        //获取某个子字符串在某个总字符串中位置数组
        NSMutableArray *array = [self getRangeWithTotalString:totalString SubString:string];
        
        //
        for (NSNumber *rangeNum in array) {
            NSRange range = [rangeNum rangeValue];
            //文字下面画线
            //画线的样式
            //线条颜色
            //被画线的字体颜色
            // NSStrikethroughStyleAttributeName  中画线
            // NSUnderlineStyleAttributeName   下划线
            [attributedStr addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSUnderlineColorAttributeName:lineColor,NSForegroundColorAttributeName:lineColor}  range:range];
        }
    }
    
    return attributedStr;
}

/** 测量文本的尺寸 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName: font};
    CGSize size =  [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    return size;
}

- (BOOL)isCorrectIDNumber{
    if (self.length != 18) {
        return NO;
    }else {
        NSString *firstPartString = [self substringToIndex:17];
        if (![firstPartString judgeIsNumber]) { /// 不全是数字
            return NO;
        }
        NSString *lastString = [self substringFromIndex:17];
        if (![lastString judgeIsNumber] && ![lastString isEqualToString:@"X"]) {
            return NO;
        }
        return YES;
    }
}
- (BOOL)judgeIsNumber {
    if ([LKCustomTool isBlankString:self]) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}
- (LKScoreInputJudge )judgeInputLegal {
    if ([self floatValue] < 0) {
        return LKScoreInputJudgeNegativeumber;
    }
    /** 过滤0.0 0000 之类的 */
    if ([self floatValue] == 0 && self.length > 1) {
        return LKScoreInputJudgeWrongFormat;
    }
    NSArray *array = [self componentsSeparatedByString:@"."];
    if (array.count >= 3) {
        return LKScoreInputJudgeWrongFormat;
    }
    if (array.count == 2) {
        NSString *floatString = [array objectAtIndex:1];
        if (floatString.length > 1) {
            return LKScoreInputJudgeWrongFormat;
        }
        if ([floatString integerValue] == 0) {
            return LKScoreInputJudgeWrongFormat;
        }
        if (![floatString isPure_Int]) {
            return LKScoreInputJudgeWrongFormat;
        }
    }
    return LKScoreInputJudgeNone;
}
//判断是否为整形：
- (BOOL)isPure_Int{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

@end
