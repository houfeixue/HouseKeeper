//
//  LKAuthorViewController.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/23.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseViewController.h"

@interface LKAuthorViewController : LKBaseViewController

-(instancetype)initAuthorType:(NSString *)type;//1成功 ；2.失败
@property (nonatomic, copy) NSString *auditFailDescription;
@end
