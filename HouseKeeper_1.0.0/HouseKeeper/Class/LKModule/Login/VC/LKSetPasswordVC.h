//
//  LKSetPasswordVC.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseViewController.h"

@interface LKSetPasswordVC : LKBaseViewController
@property (nonatomic, copy) NSString *authCode;
@property (nonatomic, copy) NSString *mobile;
@property(nonatomic,assign) BOOL isModify;
@end
