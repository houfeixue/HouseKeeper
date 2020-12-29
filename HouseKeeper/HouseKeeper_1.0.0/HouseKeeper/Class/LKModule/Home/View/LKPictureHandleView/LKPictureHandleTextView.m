//
//  LKPictureHandleTextView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/26.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPictureHandleTextView.h"

@interface LKPictureHandleTextView ()
@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, strong) UILabel *placeHolderDescLabel;


@end

@implementation LKPictureHandleTextView
CGFloat const UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION = 0.25;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];

    if (!self.placeholder) {
        _placeholder = @"";
    }
    
    if (!self.placeholderColor) {
        [self setPlaceholderColor:LKGrayColor];
    }
    if (!self.placeholderDescColor) {
        [self setPlaceholderDescColor:LKDisableGrayColor];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        _placeholder = @"";
        [self setPlaceholderColor:LKGrayColor];
        [self setPlaceholderDescColor:LKDisableGrayColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification
{
    
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    [UIView animateWithDuration:UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION animations:^{
        if([[self text] length] == 0)
        {
            //修改了text默认文字的透明度来实现的隐藏和现实
            [self viewWithTag:999].alpha = 1;
            [self viewWithTag:9999].alpha = 1;

        }
        else
        {
            [self viewWithTag:999].alpha = 0;
            [self viewWithTag:9999].alpha = 0;

        }
    }];
    
    if (_maxLength == 0) {
        return;
    }
    
    NSString *lang = self.textInputMode.primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (self.text.length >_maxLength) {
                self.text = [self.text substringToIndex:_maxLength];
            }
        }
    }else {
        if (self.text.length >_maxLength) {
            self.text = [self.text substringToIndex:_maxLength];
        }
    }
    
    
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        UIEdgeInsets insets = self.textContainerInset;
        if (_placeHolderLabel == nil ) {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(insets.left+5,insets.top,self.bounds.size.width - (insets.left +insets.right+10),1.0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        if (_placeHolderDescLabel == nil ) {
            _placeHolderDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(insets.left+5,insets.top,self.bounds.size.width - (insets.left +insets.right+10),1.0)];
            _placeHolderDescLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderDescLabel.numberOfLines = 0;
            _placeHolderDescLabel.font = self.font;
            _placeHolderDescLabel.backgroundColor = [UIColor clearColor];
            _placeHolderDescLabel.textColor = self.placeholderDescColor;
            _placeHolderDescLabel.textAlignment = NSTextAlignmentRight;
            _placeHolderDescLabel.alpha = 0;
            _placeHolderDescLabel.tag = 9999;
            [self addSubview:_placeHolderDescLabel];
        }
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [_placeHolderLabel setFrame:CGRectMake(insets.left+5,insets.top,self.bounds.size.width - (insets.left +insets.right+10),CGRectGetHeight(_placeHolderLabel.frame))];
        [self sendSubviewToBack:_placeHolderLabel];
        
        _placeHolderDescLabel.text = self.placeholderDesc;
        [_placeHolderDescLabel sizeToFit];
        [_placeHolderDescLabel setFrame:CGRectMake(insets.left+5,insets.top,self.bounds.size.width - (insets.left +insets.right+10),CGRectGetHeight(_placeHolderLabel.frame))];
        [self sendSubviewToBack:_placeHolderDescLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [self viewWithTag:999].alpha = 1;
    }
    if( [[self text] length] == 0 && [[self placeholderDesc] length] > 0 )
    {
        [self viewWithTag:9999].alpha = 1;
    }
    
    [super drawRect:rect];
}
- (void)setPlaceholder:(NSString *)placeholder{
    if (_placeholder != placeholder) {
        _placeholder = placeholder;
        [self setNeedsDisplay];
    }
}
-(void)setPlaceholderDesc:(NSString *)placeholderDesc {
    if (_placeholderDesc != placeholderDesc) {
        _placeholderDesc = placeholderDesc;
        [self setNeedsDisplay];
    }
}

@end
