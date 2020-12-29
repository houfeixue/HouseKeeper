//
//  LKFrame.h
//  LKao
//
//  Created by sunny on 2018/1/16.
//  Copyright © 2018年 sunny. All rights reserved.
//

#ifndef LKFrame_h
#define LKFrame_h

// 获取屏幕 宽度、高度 bounds就是屏幕的全部区域
#define kScreen_Width ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Height ([UIScreen mainScreen].bounds.size.height)

/** 手机型号判断 */
/** 判断为iPhone */
#define LK_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define LK_IS_IOS(version)  ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
/** 判断是否为iOS11 */
//#define LK_IS_IOS_11  (@available(iOS 11.0, *))
#define LK_IS_IOS_11  LK_IS_IOS(11)
/** 判断是否为 iPhone X */
#define LK_IS_IPHONE_X (LK_IS_IOS_11 && LK_IS_IPHONE && (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 375 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 812))
#define LK_IS_IPHONE4 (LK_IS_IPHONE && [UIScreen mainScreen].bounds.size.height == 480)
#define LK_IS_IPHONE5 (LK_IS_IPHONE && [UIScreen mainScreen].bounds.size.height == 568)
#define LK_IS_IPHONE6 (LK_IS_IPHONE && [UIScreen mainScreen].bounds.size.height == 667)
#define LK_IS_IPHONE6p (LK_IS_IPHONE && [UIScreen mainScreen].bounds.size.height == 736)
/// 系统控件默认高度
#define kStatusBarHeight (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))

#define kNavBarHeight           (44.f)
#define kTabBarHeight           (LK_IS_IPHONE_X ? 83.f : 49.f)

/** iphone_x 适配 */
#define kSafeAreaTopHeight (kStatusBarHeight+kNavBarHeight)
#define kSafeAreaBottomHeight (LK_IS_IPHONE_X ? 34.f : 0)


#define kEnglishKeyboardHeight  (216.f)
#define kChineseKeyboardHeight  (252.f)


#define kScale  ([UIScreen mainScreen].scale)
//#define kAdaptiveValue(value) ((value) * kScreen_Width/375.f)
#define kAdaptiveValue(value) ((value))


#define kLineHeight (0.75f)
#define kThemeBorder (20)

/*适配 4, 5, 6, 6p, iphoneX上数值*/
#define mySizeThree(a,b,c,d,e) [LKCustomTool adjustScreensizeWithIphoneP4:a iphone5:b  iphone6:c iphoneSp:d iphoneX:e]


#endif /* LKFrame_h */
