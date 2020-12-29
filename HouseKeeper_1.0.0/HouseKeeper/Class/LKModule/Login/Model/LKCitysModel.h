//
//  LKCitysModel.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/23.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKCitysModel : NSObject

@property (strong, nonatomic) NSMutableArray *data;

@end


@interface LKCityModel : NSObject

@property(nonatomic,strong)NSNumber *cityId;
@property(nonatomic,copy)NSString *name;
@property (nonatomic, assign) BOOL isSelected;

@end
