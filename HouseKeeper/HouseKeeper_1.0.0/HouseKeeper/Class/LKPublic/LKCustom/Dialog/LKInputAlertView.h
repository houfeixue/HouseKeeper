//
//  LKInputAlertView.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InputSelectCallBack)(NSString *score,NSInteger selectIndex, id);

@class LKCustomAlertViewOption;

@interface LKInputAlertView : UIView
- (instancetype)initWithTitle:(NSString *)title tipMessage:(NSString *)tipMessage placeholderString:(NSString *)placeholderString score:(CGFloat)score message:(NSString *)message options:(NSMutableArray *)options selectCallBack:(InputSelectCallBack)selectCallBack;
- (instancetype)initWithTitle:(NSString *)title tipMessage:(NSString *)tipMessage inputText:(NSString *)inputText placeholderString:(NSString *)placeholderString score:(CGFloat)score message:(NSString *)message options:(NSMutableArray *)options selectCallBack:(InputSelectCallBack)selectCallBack;

- (void)showAlertView;
- (void)close;
@end
