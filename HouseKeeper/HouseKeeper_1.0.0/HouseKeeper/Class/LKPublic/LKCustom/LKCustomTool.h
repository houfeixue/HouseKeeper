//
//  LKCustomTool.h
//      
//
//  Created by sunny on 2018/6/20.
//

#import <Foundation/Foundation.h>

@interface LKCustomTool : NSObject
/** 获取刷新页码 */
+ (NSString *)getIndex:(NSMutableArray *)listArray ;
/** 判断是否为空字符 */
+ (BOOL)isBlankString:(id)string;
/** 计算文字高度 */
+ (CGSize)calculateSize:(CGSize)size font:(UIFont *)font labelText:(NSString *)labelText;


#pragma mark - 图片相关
/**
 *  return 合成后的图片 (以坐标为参考点，准确)
 *  @param mainImage        第一张图片位画布                          （必传，不可空）
 *  @param viewFrame        第一张图片所在View的frame（获取压缩比用）    （必传，不可空）
 *  @param imgArray         子图片数组                               （必传，不可空）
 *  @param frameArray       子图片坐标数组                            （必传，不可空）
 */
+ (UIImage *)composeImageOnMainImage:(UIImage *)mainImage mainImageViewFrame:(CGRect)viewFrame subImageArray:(NSArray *)imgArray subImageFrameArray:(NSArray *)frameArray ;
/** view 转化成image的view size 转换成image的大小 */
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size;

/** 各种机型上不同数值，用于特殊要求 */
+(CGFloat)adjustScreensizeWithIphoneP4:(CGFloat)a iphone5:(CGFloat)b  iphone6:(CGFloat)c iphoneSp:(CGFloat)d iphoneX:(CGFloat)e;


@end
