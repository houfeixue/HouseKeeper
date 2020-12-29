//
//  LKSearchCommunityViewModel.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseTableViewModel.h"
#import "LKSearchCommunityListModel.h"
#import "LKSearchCommunityCell.h"
#import "LKCitysModel.h"


@interface LKSearchCommunityViewModel : LKBaseTableViewModel
@property (nonatomic, strong) NSString *requestUrl;//请求接口地址
@property (nonatomic, strong) NSDictionary *requestDict;//请求接口参数


@property (nonatomic, strong) NSMutableArray *cityArray;//请求城市列表接口

@property (nonatomic, strong)__block NSMutableArray *selectCommunityArray;
@property (nonatomic, strong) RACSubject *selectCommunitySubject;
@property (nonatomic, strong) RACSubject *loadDataSubject;
@property (nonatomic, strong) RACSubject *changeDataSubject;
@property (nonatomic, strong) RACSubject *selectCitySubject;



/** 其他页面修改选中小区回调 */
- (void)changeSelectDataArray:(NSMutableArray *)currentSelectArray;

@end
