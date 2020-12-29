//
//  LKUpLoadPictureModel.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/8/2.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPictureModel.h"

@interface LKUpLoadPictureModel : LKPictureModel

@property(nonatomic,strong)NSNumber * commityId;//上传小区ID
@property(nonatomic,strong)NSNumber * classifyId;//上传分类
@property(nonatomic,assign)BOOL upLoad;//是否上传分类

@end
