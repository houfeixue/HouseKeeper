//
//  UIControl+ButtonClickDelay.h
//  rqbao
//
//  Created by sunny on 2018/3/2.
//  Copyright © 2018年 sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (ButtonClickDelay)
/** 延迟时间 */
@property(nonatomic, assign)NSTimeInterval acceptEventInterval;
@end
