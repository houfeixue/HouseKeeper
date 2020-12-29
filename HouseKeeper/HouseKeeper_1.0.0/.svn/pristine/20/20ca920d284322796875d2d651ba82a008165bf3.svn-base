//
//  LKHomeAllViewModel.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/10.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKRequestViewModel.h"
#import "LKHomeListViewModel.h"
#import "LKHomeHeaderViewModel.h"
typedef NS_ENUM(NSInteger,RequestUrl) {
    RequestUrlHeader,
    RequestUrlTable,
};
@interface LKHomeAllViewModel : LKRequestViewModel
@property(nonatomic,strong)LKHomeHeaderViewModel * headerModel;
@property(nonatomic,strong)LKHomeListViewModel * tableModel;
@property(nonatomic,assign)RequestUrl requestUrlType;

-(void)initRequestUrl:(RequestUrl)type withDict:(NSDictionary *)dict;
@end
