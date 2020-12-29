//
//  UIFont+Extension.m
//  rqbao
//
//  Created by sunny on 2018/1/17.
//  Copyright © 2018年 sunny. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)
+ (UIFont *)systemCustomOfSize:(CGFloat)fontSize {
    if (kScreen_Width <= 320) {
        fontSize = fontSize - 1;
    }
#ifdef NSFoundationVersionNumber_iOS_8_x_Max
    if (LK_IS_IOS(9.0f)) {
        return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
    }
#endif
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)systemMediumOfSize:(CGFloat)fontSize {
#ifdef NSFoundationVersionNumber_iOS_8_x_Max
    if (LK_IS_IOS(9.0f)) {
        return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
    }
#endif
    return [UIFont systemFontOfSize:fontSize];
}
+ (UIFont *)systemSemiboldOfSize:(CGFloat)fontSize {
#ifdef NSFoundationVersionNumber_iOS_8_x_Max
    if (LK_IS_IOS(9.0f)) {
        return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
    }
#endif
    return [UIFont systemFontOfSize:fontSize];
}
+ (UIFont *)systemCondOfSize:(CGFloat)fontSize {
#ifdef NSFoundationVersionNumber_iOS_8_x_Max
    if (LK_IS_IOS(9.0f)) {
//        return [UIFont fontWithName:@"PingFangSC-Cond" size:fontSize];
        return [UIFont fontWithName:@"OPTIAkroGrotesk-Cond" size:fontSize];
    }
#endif
    return [UIFont systemFontOfSize:fontSize];
}
+ (UIFont *)systemLightOfSize:(CGFloat)fontSize {
#ifdef NSFoundationVersionNumber_iOS_8_x_Max
    if (LK_IS_IOS(9.0f)) {
        return [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];
    }
#endif
    return [UIFont systemFontOfSize:fontSize];
}

@end
