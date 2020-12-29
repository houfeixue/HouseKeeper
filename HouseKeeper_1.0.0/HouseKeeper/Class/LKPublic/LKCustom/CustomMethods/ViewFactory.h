//
//  ViewCreatorHelper.h
//  MQ
//
//  Created by 田立彬 on 13-5-29.
//  Copyright (c) 2013年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Extra.h"

@interface ViewFactory : NSObject


+ (UIButton*)buttonWithTitle:(NSString*)title
                       frame:(CGRect)frame
                  bgImageKey:(NSString*)bgImageKey
                hlBgImageKey:(NSString*)hlBgImageKey
               disBgImageKey:(NSString*)disBgImageKey
                      target:(id)target
                      action:(SEL)action;

+ (UIButton*)buttonWithTitle:(NSString*)title
                       frame:(CGRect)frame
                     bgImage:(UIImage*)bgImage
                   hlBgImage:(UIImage*)hlBgImage
                  disBgImage:(UIImage*)disBgImage
                      target:(id)target
                      action:(SEL)action;

+ (UIButton*)buttonWithFrame:(CGRect)frame
                       title:(NSString*)title
                    imageKey:(NSString*)imageKey
                  hlImageKey:(NSString*)hlImageKey
                 disImageKey:(NSString*)disImageKey
                      target:(id)target
                      action:(SEL)action;
+ (UIButton*)buttonWithFrame:(CGRect)frame
                       title:(NSString*)title
                  bgImageKey:(UIImage *)bgImageKey
                    fontSize:(CGFloat)fontSize
                   titleColor:(UIColor*)titleColor
                      target:(id)target
                      action:(SEL)action;

+ (UIButton*)buttonWithFrame:(CGRect)frame
                       title:(NSString*)title
                    imageKey:(NSString*)imageKey
                  hlImageKey:(NSString*)hlImageKey
                 selImageKey:(NSString*)selImageKey
                      target:(id)target
                      action:(SEL)action;

+ (UIButton*)buttonWithFrame:(CGRect)frame
                       title:(NSString*)title
                cornerRadius:(CGFloat)cornerRadius
                    fontSize:(CGFloat)fontSize
                  titleColor:(UIColor*)titleColor
                     bgColor:(UIColor*)bgColor
                      target:(id)target
                      action:(SEL)action;

+ (UIButton*)tagButtonWithFrame:(CGRect)frame
                   cornerRadius:(CGFloat)cornerRadius
                           icon:(NSString*)icon
                          title:(NSString*)title
                        bgColor:(UIColor*)bgColor
                      textColor:(UIColor*)coltextColoror;

+ (UIButton*)frameButtonWithFrame:(CGRect)frame
                            title:(NSString*)title
                     cornerRadius:(CGFloat)cornerRadius
                         fontSize:(CGFloat)fontSize
                       titleColor:(UIColor*)titleColor
                          bgColor:(UIColor*)bgColor
                           target:(id)target
                           action:(SEL)action;

+ (UILabel*)labelWithTitle:(NSString*)title
                      font:(UIFont*)font
                     frame:(CGRect)frame
                 textColor:(UIColor*)textColor
             textAlignment:(NSTextAlignment)textAlignment;


+ (UITextField*)textFiledWithFrame:(CGRect)frame
                          delegate:(id<UITextFieldDelegate>)delegate
                     editingAction:(SEL)editingAction
                       placeHolder:(NSString*)placeHolder
                      keyboardType:(UIKeyboardType)keyboardType
                     returnKeyType:(UIReturnKeyType)returnKeyType;


+ (UITextField*)textFiledWithLabelFrame:(CGRect)frame
                               delegate:(id<UITextFieldDelegate>)delegate
                          editingAction:(SEL)editingAction
                            placeHolder:(NSString*)placeHolder
                           keyboardType:(UIKeyboardType)keyboardType
                          returnKeyType:(UIReturnKeyType)returnKeyType;

+ (UIImageView*)imageViewWithImage:(UIImage*)image
                             frame:(CGRect)frame
                             round:(BOOL)round;
+ (UIImageView*)imageViewWithImageName:(NSString*)imageName
                                 frame:(CGRect)frame
                                 round:(BOOL)round;

+ (UIView*)lineWithWidth:(CGFloat)width;
+ (UIView*)vLineWithHeight:(CGFloat)width;

+ (UIView*)lineWithWidth:(CGFloat)width color:(UIColor *)color;
+ (UIView*)vLineWithHeight:(CGFloat)height color:(UIColor *)color;

+ (UIView*)emptyViewWithWidth:(CGFloat)width;
+ (UIView*)emptyViewWithHeight:(CGFloat)height;
+ (UIView*)emptyViewWithFrame:(CGRect)frame;

+ (void)addBorderForView:(UIView*)view;
+ (void)addBorderForView:(UIView*)view color:(UIColor*)color;



@end

@interface IconBehindButton : UIButton


@end
