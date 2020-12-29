//
//  LKBaseView.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseView.h"

@implementation LKBaseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI {
    
}
- (void)updateUI {
    
}

- (void)dealloc {
    NSLog(@"dealloc -- %@",NSStringFromClass([self class]));
    
}
@end
