//
//  LKQualityReportModel.h
//  HouseKeeper
//
//  Created by sunny on 2018/8/6.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKTableSectionObject.h"
#import "LKQualityDetailModel.h"

//@class LKQualityDetailListModel,LKQualityDetailImageInfoModel;

@interface LKQualityReportModel : LKTableSectionObject

@property (nonatomic, strong) NSNumber *categoryId;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, strong) NSNumber *detailId;
@property (nonatomic, strong) NSArray<LKQualityDetailListModel *> *items;
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, strong) NSNumber *recordId;
@property (nonatomic, assign) double totalScore;

@property (nonatomic, assign) BOOL show;

@end

