//
//  EaseBlankPageView.h
//  HouseKeeper
//
//  Created by Lin Hu on 2018/8/2.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseBlankPageView.h"

@interface UIView(EaseBlankPage)

@property (strong, nonatomic) EaseBlankPageView *blankPageView;



-(void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;

- (void)configBlankPage:(EaseBlankPageType)blankPageType  frame:(CGRect )frame hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block;
@end
