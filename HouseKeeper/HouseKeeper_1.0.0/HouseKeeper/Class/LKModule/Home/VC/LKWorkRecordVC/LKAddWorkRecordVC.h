//
//  LKAddWorkRecordVC.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/30.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseViewController.h"

@class LKWorkRecordListModel;

@protocol LKAddWorkRecordVCDelegate <NSObject>
- (void)LKAddWorkRecordVCDelegateRefreshUI;
@end

@interface LKAddWorkRecordVC : LKBaseViewController
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, strong) LKWorkRecordListModel *listModel;
/** 工作记录的当前日期 */
@property (nonatomic, copy) NSString *workDate;

@property (nonatomic, weak) id<LKAddWorkRecordVCDelegate> delegate;
@end
