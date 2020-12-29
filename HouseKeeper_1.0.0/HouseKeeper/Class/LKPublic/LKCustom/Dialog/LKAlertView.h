//
//  LKAlertView.h
//      
//
//  Created by 侯良凯 on 2018/6/29.
//

#import <UIKit/UIKit.h>


typedef void(^SelectCallBack)(NSInteger);

@class LKCustomAlertViewOption;

@interface LKAlertView : UIView
LKSingletonH(LKAlertView);
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message options:(NSMutableArray *)options selectCallBack:(SelectCallBack)selectCallBack;

- (void)showAlertView;
@end

@interface LKCustomAlertViewOption: NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIColor *color;
- (instancetype)initWithTitle:(NSString *)title color:(UIColor *)color;
@end

