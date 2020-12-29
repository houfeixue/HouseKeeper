//
//  LKLookPicCategoryModel.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/8/14.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LKLookPicModel;
@interface LKLookPicCategoryModel : NSObject

@property(nonatomic,copy)NSString * categoryName;
@property(nonatomic,strong)NSNumber * detailId;
@property(nonatomic,strong)NSArray<LKLookPicModel *>* images;

@end

@interface LKLookPicModel : NSObject
@property(nonatomic,copy)NSString * desc;
@property(nonatomic,copy)NSString * url;

@end
