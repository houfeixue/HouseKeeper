//
//  LKQualityHistoryHeaderView.h
//  HouseKeeper
//
//  Created by sunny on 2018/8/3.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseView.h"

typedef void(^LKQualityHistoryHeaderViewSelectTime)(NSString *selectTime);

@interface LKQualityHistoryHeaderView : LKBaseView
@property (nonatomic, copy) LKQualityHistoryHeaderViewSelectTime selectTime;
@property (nonatomic, copy) NSString *currentSelectTime;
@end
