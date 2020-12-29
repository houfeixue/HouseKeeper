//
//  LKSearchCommunityBottomView.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseView.h"

typedef void(^LKSearchCommunityBottomViewCheckSelectCommunity)(void);
typedef void(^LKSearchCommunityBottomViewsureBtnClick)(void);

@interface LKSearchCommunityBottomView : LKBaseView
@property (nonatomic, copy) LKSearchCommunityBottomViewsureBtnClick sureBtnClick;

@property (nonatomic, copy) LKSearchCommunityBottomViewCheckSelectCommunity checkSelectCommunity;


- (void)bindDataSelectCountCommunity:(NSInteger)selectCountCommunity;
@end
