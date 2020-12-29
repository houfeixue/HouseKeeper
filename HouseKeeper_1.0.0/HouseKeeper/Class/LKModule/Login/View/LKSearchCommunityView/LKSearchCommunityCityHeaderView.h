//
//  LKSearchCommunityCityHeaderView.h
//  HouseKeeper
//
//  Created by sunny on 2018/7/24.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseView.h"

@class LKCityModel;

typedef void(^LKSearchCommunityCityHeaderViewSelectCity)(LKCityModel *);

@interface LKSearchCommunityCityHeaderView : LKBaseView
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, copy) LKSearchCommunityCityHeaderViewSelectCity selectCity;
@property (nonatomic, strong) LKCityModel *selectCityModel;
- (void)bindDataSelectCityModel:(LKCityModel *)selectedCityModel;
@end
