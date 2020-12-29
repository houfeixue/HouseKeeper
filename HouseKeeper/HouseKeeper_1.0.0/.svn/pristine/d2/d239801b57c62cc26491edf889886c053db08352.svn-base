//
//  LKPictureViewController.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseCollectionViewController.h"
#import "LKQualityListModel.h"

typedef void(^UrlPictureDeleteClick)(NSString * status);

@interface LKUrlPictureViewController : LKBaseCollectionViewController

@property(nonatomic,copy)NSString * type;//look : 查看照片， upload ：上传照片

@property(nonatomic,copy)NSNumber * detailId; 
@property(nonatomic,copy)NSString * name;//相册name
@property(nonatomic,strong) LKQualityListModel * qualityModel;
@property(nonatomic,strong) NSNumber * commityId;//小区ID
@property(nonatomic,copy) UrlPictureDeleteClick urlPictureDeleteClick;//小区ID


@end
