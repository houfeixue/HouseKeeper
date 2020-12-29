//
//  LKSearchCommunityResultVC.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewController.h"

@interface LKSearchCommunityResultVC : LKBaseTableViewController
/** 选择完小区回调 */
@property (nonatomic, strong) RACSubject *sureSelectSubject;
/** 选择小区数组 */
@property (nonatomic, strong) NSMutableArray *selectCommunityArray;
@property (nonatomic, copy) NSString *regionId;
@end
