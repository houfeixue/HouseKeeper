//
//  ViewFactory.m
//  MQ
//
//  Created by 田立彬 on 13-5-29.
//  Copyright (c) 2013年 . All rights reserved.
//

#import "ViewFactory.h"
#import "UIImage+Extra.h"


@implementation ViewFactory



+ (UIButton*)buttonWithTitle:(NSString*)title
                       frame:(CGRect)frame
                  bgImageKey:(NSString*)bgImageKey
                hlBgImageKey:(NSString*)hlBgImageKey
               disBgImageKey:(NSString*)disBgImageKey
                      target:(id)target
                      action:(SEL)action
{
    UIImage* normalImage = [UIImage imageNamed:bgImageKey];

    UIImage* highlitedImage = nil;
    if (hlBgImageKey != nil) {
        highlitedImage = [UIImage imageNamed:hlBgImageKey];
    }
    
    UIImage* disableImage = nil;
    if (disBgImageKey != nil) {
        disableImage = [UIImage imageNamed:disBgImageKey];
    }
    
    return [self buttonWithTitle:title
                           frame:frame
                         bgImage:normalImage
                       hlBgImage:highlitedImage
                      disBgImage:disableImage
                          target:target
                          action:action];
}

+ (UIButton*)buttonWithTitle:(NSString*)title
                       frame:(CGRect)frame
                     bgImage:(UIImage*)bgImage
                   hlBgImage:(UIImage*)hlBgImage
                  disBgImage:(UIImage*)disBgImage
                      target:(id)target
                      action:(SEL)action
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    if (bgImage != nil) {
        CGSize size = bgImage.size;
        [button setBackgroundImage:[bgImage stretchableImageWithLeftCapWidth:size.width/2.0f
                                                                topCapHeight:size.height/2.0f]
                          forState:UIControlStateNormal];
    }
    
    if (hlBgImage != nil) {
        CGSize size = hlBgImage.size;
        UIImage* image = [hlBgImage stretchableImageWithLeftCapWidth:size.width/2.0f
                                                        topCapHeight:size.height/2.0f];
        [button setBackgroundImage:image
                          forState:UIControlStateHighlighted];
        [button setBackgroundImage:image
                          forState:UIControlStateSelected];
    }
    
    if (disBgImage != nil) {
        CGSize size = disBgImage.size;
        [button setBackgroundImage:[disBgImage stretchableImageWithLeftCapWidth:size.width/2.0f
                                                                   topCapHeight:size.height/2.0f]
                          forState:UIControlStateDisabled];
    }
    
    if (target != nil && action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    return button;

}


+ (UIButton*)buttonWithFrame:(CGRect)frame
                       title:(NSString*)title
                    imageKey:(NSString*)imageKey
                  hlImageKey:(NSString*)hlImageKey
                 disImageKey:(NSString*)disImageKey
                      target:(id)target
                      action:(SEL)action
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    if (imageKey != nil) {
        UIImage* image = [UIImage imageNamed:imageKey];
        if (image != nil) {
            [button setImage:image forState:UIControlStateNormal];
        }
    }
    
    if (hlImageKey != nil) {
        UIImage* image = [UIImage imageNamed:hlImageKey];
        if (image != nil) {
            [button setImage:image forState:UIControlStateHighlighted];
        }
    }
    
    if (disImageKey != nil) {
        UIImage* image = [UIImage imageNamed:disImageKey];
        if (image != nil) {
            [button setImage:image forState:UIControlStateDisabled];
        }
    }
    
    if (target != nil && action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }

    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                   bgImageKey:(UIImage *)bgImageKey
                     fontSize:(CGFloat)fontSize
                    titleColor:(UIColor *)titleColor
                       target:(id)target
                       action:(SEL)action
{

    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    if (bgImageKey != nil) {
        CGSize size = bgImageKey.size;
        [button setBackgroundImage:[bgImageKey stretchableImageWithLeftCapWidth:size.width/2.0f
                                                                topCapHeight:size.height/2.0f]
                          forState:UIControlStateNormal];
    }
    
    if (titleColor != nil) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    
    if (fontSize > 0.0f) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    
    if (target != nil && action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;


}

+ (UIButton*)buttonWithFrame:(CGRect)frame
                       title:(NSString*)title
                    imageKey:(NSString*)imageKey
                  hlImageKey:(NSString*)hlImageKey
                 selImageKey:(NSString*)selImageKey
                      target:(id)target
                      action:(SEL)action{

    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    if (imageKey != nil) {
        UIImage* image = [UIImage imageNamed:imageKey];
        if (image != nil) {
            [button setImage:image forState:UIControlStateNormal];
        }
    }
    
    if (hlImageKey != nil) {
        UIImage* image = [UIImage imageNamed:hlImageKey];
        if (image != nil) {
            [button setImage:image forState:UIControlStateHighlighted];
        }
    }
    
    if (selImageKey != nil) {
        UIImage* image = [UIImage imageNamed:selImageKey];
        if (image != nil) {
            [button setImage:image forState:UIControlStateSelected];
        }
    }
    
    if (target != nil && action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;

}

+ (UIButton*)buttonWithFrame:(CGRect)frame
                       title:(NSString*)title
                cornerRadius:(CGFloat)cornerRadius
                    fontSize:(CGFloat)fontSize
                  titleColor:(UIColor*)titleColor
                     bgColor:(UIColor*)bgColor
                      target:(id)target
                      action:(SEL)action
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    if (titleColor != nil) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    
    if (fontSize > 0.0f) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    
    if (bgColor != nil) {
        UIImage* bg = [UIImage imageWithColor:bgColor size:frame.size];
        [button setBackgroundImage:bg forState:UIControlStateNormal];
//        [button setBackgroundColor:bgColor];
    }
    else {
        [button setBackgroundColor:[UIColor clearColor]];
    }
    
    if (cornerRadius > 0.0f) {
        button.clipsToBounds = YES;
        button.layer.cornerRadius = cornerRadius;
    }
    
    if (target != nil && action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

+ (UIButton*)tagButtonWithFrame:(CGRect)frame
                   cornerRadius:(CGFloat)cornerRadius
                           icon:(NSString*)icon
                          title:(NSString*)title
                        bgColor:(UIColor*)bgColor
                      textColor:(UIColor*)textColor
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (icon != nil) {
        UIImage* iconImg = [UIImage imageNamed:icon];
        [button setImage:iconImg forState:UIControlStateNormal];
    }
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (bgColor != nil) {
        button.backgroundColor = bgColor;
    }
    else {
        button.backgroundColor = [UIColor clearColor];
    }
    if (textColor != nil) {
        [button setTitleColor:textColor forState:UIControlStateNormal];
    }
    if (cornerRadius > 0.0f) {
        button.clipsToBounds = YES;
        button.layer.cornerRadius = cornerRadius;
    }
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 2.0f, 0.0f, 0.0f)];
    button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    button.userInteractionEnabled = NO;
    
    return button;
}

+ (UIButton*)frameButtonWithFrame:(CGRect)frame
                            title:(NSString*)title
                     cornerRadius:(CGFloat)cornerRadius
                         fontSize:(CGFloat)fontSize
                       titleColor:(UIColor*)titleColor
                          bgColor:(UIColor*)bgColor
                           target:(id)target
                           action:(SEL)action
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    if (titleColor != nil) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        button.layer.borderColor = titleColor.CGColor;
        button.layer.borderWidth = 1.0f;
    }
    
    if (fontSize > 0.0f) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    
    if (bgColor != nil) {
        [button setBackgroundColor:bgColor];
    }
    else {
        [button setBackgroundColor:[UIColor clearColor]];
    }
    
    if (cornerRadius > 0.0f) {
        button.clipsToBounds = YES;
        button.layer.cornerRadius = cornerRadius;
    }
    
    if (target != nil && action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

+ (UILabel*)labelWithTitle:(NSString*)title
                      font:(UIFont*)font
                     frame:(CGRect)frame
                 textColor:(UIColor*)textColor
             textAlignment:(NSTextAlignment)textAlignment
{
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    if (font != nil) {
        label.font = font;
    }
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.backgroundColor = [UIColor clearColor];
    
    if (title.length > 0 && CGRectIsEmpty(frame)) {
        [label sizeToFit];
    }
    
    return label;
}

+ (UITextField*)textFiledWithFrame:(CGRect)frame
                          delegate:(id<UITextFieldDelegate>)delegate
                     editingAction:(SEL)editingAction
                       placeHolder:(NSString*)placeHolder
                      keyboardType:(UIKeyboardType)keyboardType
                     returnKeyType:(UIReturnKeyType)returnKeyType
{
    UITextField* textField = [[UITextField alloc] initWithFrame:frame];
    textField.delegate = delegate;
    textField.placeholder = placeHolder;
    textField.keyboardType = keyboardType;
    textField.returnKeyType = returnKeyType;
    
    UIView* leftView = [self emptyViewWithWidth:10.0f];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftView;
    //    textField.rightViewMode = UITextFieldViewModeAlways;
    //    textField.rightView = leftView;
    
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    textField.font = [UIFont systemFontOfSize:14.0f];
    textField.textColor = [UIColor blackColor];
    
    if (editingAction != nil) {
        [textField addTarget:delegate
                      action:editingAction
            forControlEvents:UIControlEventEditingChanged];
    }
    return textField;
}



+ (UITextField*)textFiledWithLabelFrame:(CGRect)frame
                          delegate:(id<UITextFieldDelegate>)delegate
                     editingAction:(SEL)editingAction
                       placeHolder:(NSString*)placeHolder
                      keyboardType:(UIKeyboardType)keyboardType
                     returnKeyType:(UIReturnKeyType)returnKeyType
{
    UITextField* textField = [[UITextField alloc] initWithFrame:frame];
    textField.delegate = delegate;
    textField.placeholder = placeHolder;
    textField.keyboardType = keyboardType;
    textField.returnKeyType = returnKeyType;
    
   // UIView* leftView = [self emptyViewWithWidth:10.0f];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:frame];
    nameLabel.text =@"234568";
    [nameLabel sizeToFit];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = nameLabel;
    //    textField.rightViewMode = UITextFieldViewModeAlways;
    //    textField.rightView = leftView;
    
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    textField.font = [UIFont systemFontOfSize:14.0f];
    textField.textColor = [UIColor blackColor];
    
    if (editingAction != nil) {
        [textField addTarget:delegate
                      action:editingAction
            forControlEvents:UIControlEventEditingChanged];
    }
    
    return textField;
}


+ (UIImageView*)imageViewWithImage:(UIImage*)image
                             frame:(CGRect)frame
                             round:(BOOL)round
{
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:frame];
    if (image != nil) {
        imgView.image = image;
        if (frame.size.width <= 0.0f) {
            [imgView sizeToFit];
        }
    }
    
    imgView.clipsToBounds = YES;
    if (round) {
        imgView.layer.cornerRadius = imgView.size.width / 2.0f;
    }
    
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    return imgView;
}

+ (UIImageView*)imageViewWithImageName:(NSString*)imageName
                                 frame:(CGRect)frame
                                 round:(BOOL)round
{
    UIImage* image = nil;
    if (imageName != nil) {
        image = [UIImage imageNamed:imageName];
    }
    return [self imageViewWithImage:image frame:frame round:round];
}


+ (UIView*)lineWithWidth:(CGFloat)width
{
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGFloat h = 1.0f;
    if (screenScale > 0.0f) {
        h = 1.0f / screenScale;
    }
    
    CGRect rc = CGRectMake(0.0f, 0.0f, width, h);
    UIView* lineView = [[UIView alloc] initWithFrame:rc];
    lineView.backgroundColor = [ColorUtil colorWithHex:@"#DCDCDC"];
    return lineView;
}

+ (UIView*)vLineWithHeight:(CGFloat)height
{
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGFloat w = 1.0f;
    if (screenScale > 0.0f) {
        w = 1.0f / screenScale;
    }
    
    CGRect rc = CGRectMake(0.0f, 0.0f, w, height);
    UIView* lineView = [[UIView alloc] initWithFrame:rc];
//    lineView.backgroundColor = RGBCOLOR(200.0f, 200.0f, 200.0f);
    
    return lineView;
}

+(UIView *)lineWithWidth:(CGFloat)width color:(UIColor *)color
{
    UIView * view = [self lineWithWidth:width];
    view.backgroundColor = color;
    return view;
}

+(UIView *)vLineWithHeight:(CGFloat)height color:(UIColor *)color
{
    UIView * view = [self vLineWithHeight:height];
    view.backgroundColor = color;
    return view;
}

+ (void)addBorderForView:(UIView *)view
{
//    UIColor* color = [ColorUtil colorWithHex:@"#e6e6e6"];
    UIColor* color = [ColorUtil colorWithR:172 G:175 B:178];
    [self addBorderForView:view color:color];
}

+ (void)addBorderForView:(UIView*)view color:(UIColor*)color
{
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGFloat h = 2.0f;
    if (screenScale > 0.0f) {
        h = 2.0f / screenScale;
    }
    view.layer.borderWidth = h;
    view.layer.borderColor = color.CGColor;
}


+ (UIView*)emptyViewWithWidth:(CGFloat)width
{
    CGRect rc = CGRectMake(0.0f, 0.0f, width, 1.0f);
    return [self emptyViewWithFrame:rc];
}

+ (UIView*)emptyViewWithHeight:(CGFloat)height
{
    CGRect rc = CGRectMake(0.0f, 0.0f, 1.0f, height);
    return [self emptyViewWithFrame:rc];
}

+ (UIView*)emptyViewWithFrame:(CGRect)frame
{
    UIView* view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    return view;
}



@end
