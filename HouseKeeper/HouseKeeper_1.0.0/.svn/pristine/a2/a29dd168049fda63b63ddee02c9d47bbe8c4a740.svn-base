//
//  LKSearchCommunityResultViewModel.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/22.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewModel.h"
#import "LKSearchCommunityListModel.h"
#import "LKSearchCommunityCell.h"


@interface LKSearchCommunityResultViewModel : LKBaseTableViewModel
@property (nonatomic, strong) NSString *requestUrl;//请求接口地址
@property (nonatomic, strong) NSDictionary *requestDict;//请求接口参数
@property (nonatomic, strong)__block NSMutableArray *selectCommunityArray;
@property (nonatomic, strong) RACSubject *loadCommunityDataSubject;
@property (nonatomic, strong) RACSubject *changeCommunitySubject;

@property (nonatomic, strong) RACSubject *selectCommunitySubject;
- (void)changeSelectDataArray:(NSMutableArray *)currentSelectArray;
@end
