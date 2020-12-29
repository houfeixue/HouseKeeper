//
//  UIImage+Extra.h
//  MQ
//
//  Created by tianlibin on 14/12/29.
//  Copyright (c) 2014年 ilovedev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extra)

+ (UIImage *)SDResizeWithIma:(UIImage *)image isOther:(BOOL) isOther;
+ (UIImage*)resizebleImageNamed:(NSString*)name;
+ (UIImage*)resizebleImageNamed:(NSString*)name insets:(UIEdgeInsets)insets;

+ (UIImage*)imageWithName:(NSString*)name size:(CGSize)size;

+ (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size;

+ (UIImage*)imageWithView:(UIView*)view;

+ (UIImage*)circleImageWithName:(NSString*)name;
+ (UIImage*)circelImageWithImage:(UIImage*)image;

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;


+ (CGSize)rescaleImageToSize:(UIImage *)image max:(NSInteger)max;
+ (UIImage *)scaleAndRotateImage:(UIImage*) image size:(NSInteger)size;


+ (NSData *)imageChangeToData:(UIImage *)image;

- (NSString *)UIImageToBase64Str:(UIImage *) image;

/**
 *  拉伸图片
 */
+ (UIImage *)pullImage:(NSString *)imageName;

/**
 *  拉伸图片，可指定拉伸位置
 */
+ (UIImage *)pullImage:(NSString *)imageName leftRatio:(CGFloat)leftratio topRatio:(CGFloat)topratio;


@end
