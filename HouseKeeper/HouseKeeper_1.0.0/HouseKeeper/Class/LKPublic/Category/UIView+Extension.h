//
//  UIView+Extension.h
//  rqbao
//
//  Created by sunny on 2018/1/22.
//  Copyright © 2018年 sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LKBorderSideType) {
    UIBorderSideTypeAll  = 0,
    UIBorderSideTypeTop = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft = 1 << 2,
    UIBorderSideTypeRight = 1 << 3,
};


@interface UIView (Extension)
/// 直接获取view的x轴坐标
@property (nonatomic, assign) CGFloat x;
/// 直接获取view的y轴坐标
@property (nonatomic, assign) CGFloat y;
/// 直接获取view的中心点x坐标
@property (nonatomic, assign) CGFloat centerX;
/// 直接获取view的中心点y轴坐标
@property (nonatomic, assign) CGFloat centerY;
/// 直接获取view宽度
@property (nonatomic, assign) CGFloat width;
/// 直接获取view高度
@property (nonatomic, assign) CGFloat height;
/// 直接获取view大小尺寸
@property (nonatomic,assign) CGSize size;

/** 添加渐变色 */
- (void)setCAGradientLayer;

/** 获取当前view的控制器 */
- (UIViewController *)getCurrentViewController;
/** 绘制指定位置圆角 */
- (void)drawCornerRadiuss:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners;
/** 绘制圆角 */
- (void)drawCornerRadiuss:(CGFloat)cornerRadius ;
/** 添加圆角和阴影 -- 默认偏移量为(0,0) */
- (void)addShadowPathCornerRadiuss:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor ;
/** 添加圆角和阴影 -- 偏移量为shadowOffset */
- (void)addShadowPathCornerRadiuss:(CGFloat)cornerRadius shadowOffset:(CGSize )shadowOffset backgroundColor:(UIColor *)backgroundColor;
- (void)addShadowPathCornerRadiuss:(CGFloat)cornerRadius shadowOffset:(CGSize )shadowOffset shadowColor:(UIColor *)shadowColor backgroundColor:(UIColor *)backgroundColor;

- (void)addTopCornerRadiuss:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor;


//view 添加线
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(LKBorderSideType)borderType;

@end
