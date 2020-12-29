//
//  LKRegisterModel.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKRegisterModel : NSObject
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *verifyCode;
@end
