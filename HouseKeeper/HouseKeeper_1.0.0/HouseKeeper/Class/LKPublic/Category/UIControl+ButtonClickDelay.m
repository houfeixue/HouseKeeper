//
//  UIControl+ButtonClickDelay.m
//  rqbao
//
//  Created by sunny on 2018/3/2.
//  Copyright © 2018年 sunny. All rights reserved.
//

#import "UIControl+ButtonClickDelay.h"
#import <objc/runtime.h>

@interface UIControl ()
/** 是否忽略点击 */
@property(nonatomic, assign)BOOL ignoreEvent;
@end

@implementation UIControl (ButtonClickDelay)
+(void)load{
    Method sys_Method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method add_Method = class_getInstanceMethod(self, @selector(rqb_sendAction:to:forEvent:));
    method_exchangeImplementations(sys_Method, add_Method);
}

-(void)rqb_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    if (self.ignoreEvent) return;
    
    if (self.acceptEventInterval > 0) {
        self.ignoreEvent = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.acceptEventInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.ignoreEvent = NO;
        });
    }
    [self rqb_sendAction:action to:target forEvent:event];
}

-  (void) setIgnoreEvent:(BOOL)ignoreEvent{
    objc_setAssociatedObject(self, @selector(ignoreEvent), @(ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL) ignoreEvent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void) setAcceptEventInterval:(NSTimeInterval)acceptEventInterval{
    objc_setAssociatedObject(self, @selector(acceptEventInterval), @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)acceptEventInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
@end
