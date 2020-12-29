//
//  LKQualityListModel.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKTableSectionObject.h"
@interface LKQualityListModel : LKTableSectionObject

@property(nonatomic,assign)BOOL isShow;

@property(nonatomic,strong)NSNumber * checkRecordId;
@property(nonatomic,strong)NSNumber * createDate;
@property(nonatomic,copy)NSString * createPeople;
@property(nonatomic,strong)NSNumber * detailId;
@property(nonatomic,strong)NSNumber * endFlag;
@property(nonatomic,copy)NSString * fullMark;
@property(nonatomic,copy)NSString * iconUrl;
@property(nonatomic,strong)NSNumber* levevl;
@property(nonatomic,strong)NSNumber* parentId;
@property(nonatomic,copy)NSString* ruleDesc;
@property(nonatomic,strong)NSNumber* ruleId;
@property(nonatomic,copy)NSString* ruleInfo;
@property(nonatomic,assign)double scort;
@property(nonatomic,strong)NSNumber* updateDate;
@property(nonatomic,copy)NSString* updatePeople;
@property(nonatomic,strong)NSNumber* imgNumber;


@end
