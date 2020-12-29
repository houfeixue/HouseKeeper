//
//  LKLoginModel.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/18.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKLoginModel : NSObject
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, assign) BOOL isQuickLogin;
@end
