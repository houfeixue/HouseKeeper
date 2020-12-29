//
//  UIView+Extension.m
//  rqbao
//
//  Created by sunny on 2018/1/22.
//  Copyright © 2018年 sunny. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setCAGradientLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:253/255.0f green:183/255.0f blue:139/255.0f alpha:1].CGColor, (__bridge id)[UIColor colorWithRed:254/255.0f green:72/255.0f blue:96/255.0f alpha:1].CGColor];
    gradientLayer.locations = @[@0.2,@0.8];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.type = kCAGradientLayerAxial;
    gradientLayer.frame = self.bounds;
    gradientLayer.cornerRadius = self.layer.cornerRadius;
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (UIViewController *)getCurrentViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
- (void)drawCornerRadiuss:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners {
    [self layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    maskLayer.fillColor = [self.backgroundColor CGColor];
    self.layer.mask = maskLayer;
}
- (void)drawCornerRadiuss:(CGFloat)cornerRadius {
    [self layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    maskLayer.fillColor = [self.backgroundColor CGColor];
    self.layer.mask = maskLayer;
}
- (void)addShadowPathCornerRadiuss:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor{
    [self addShadowPathCornerRadiuss:cornerRadius shadowOffset:CGSizeMake(0, 0) backgroundColor:backgroundColor];
}
- (void)addShadowPathCornerRadiuss:(CGFloat)cornerRadius shadowOffset:(CGSize )shadowOffset backgroundColor:(UIColor *)backgroundColor{
//    [self addShadowPathCornerRadiuss:cornerRadius shadowOffset:shadowOffset shadowColor:RQBLineColor backgroundColor:backgroundColor];
}
- (void)addShadowPathCornerRadiuss:(CGFloat)cornerRadius shadowOffset:(CGSize )shadowOffset shadowColor:(UIColor *)shadowColor backgroundColor:(UIColor *)backgroundColor {
    [self layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    maskLayer.fillColor = [backgroundColor CGColor];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    maskLayer.shadowPath = path.CGPath;
    maskLayer.shadowOpacity = 0.8f;
    maskLayer.shadowColor = [shadowColor CGColor];
    maskLayer.shadowOffset = shadowOffset;
    [self.layer insertSublayer:maskLayer atIndex:0];
}
- (void)addTopCornerRadiuss:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor {
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer * mask  = [[CAShapeLayer alloc] init];
    mask.path = path.CGPath;
//    mask.backgroundColor = [RQBRedColor CGColor];
    self.layer.mask = mask;
    
    CALayer * temp = [CALayer layer];
    [temp setBackgroundColor:[backgroundColor CGColor]];
    temp.frame = CGRectMake(0, borderWidth, self.bounds.size.width, self.bounds.size.height - borderWidth);
    
    UIBezierPath * subPath = [UIBezierPath bezierPathWithRoundedRect:temp.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius - borderWidth, cornerRadius - borderWidth)];
    CAShapeLayer * subMask  = [[CAShapeLayer alloc] initWithLayer:temp];
    subMask.path = subPath.CGPath;
    temp.mask = subMask;
    [self.layer insertSublayer:temp atIndex:0];
}



//view 添加线
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(LKBorderSideType)borderType
{
    [self layoutIfNeeded];

    if (borderType == UIBorderSideTypeAll) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = color.CGColor;
        return self;
    }
    
    
    /// 左侧
    if (borderType & UIBorderSideTypeLeft) {
        /// 左侧线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    /// 右侧
    if (borderType & UIBorderSideTypeRight) {
        /// 右侧线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    /// top
    if (borderType & UIBorderSideTypeTop) {
        /// top线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, 0.0f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:color borderWidth:borderWidth]];
    }
    
    /// bottom
    if (borderType & UIBorderSideTypeBottom) {
        /// bottom线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    return self;

}


- (CAShapeLayer *)addLineOriginPoint:(CGPoint)p0 toPoint:(CGPoint)p1 color:(UIColor *)color borderWidth:(CGFloat)borderWidth {
    
    /// 线的路径
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p0];
    [bezierPath addLineToPoint:p1];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    /// 添加路径
    shapeLayer.path = bezierPath.CGPath;
    /// 线宽度
    shapeLayer.lineWidth = borderWidth;
    return shapeLayer;

}
@end
