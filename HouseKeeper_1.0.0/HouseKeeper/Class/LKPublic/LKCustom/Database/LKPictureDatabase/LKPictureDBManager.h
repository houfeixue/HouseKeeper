//
//  LKPictureDBManager.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKPictureDBManager : NSObject

+(LKPictureDBManager *)shareManager;
/*
 插入 相册数据
 */
-(BOOL)insertDataWithAlumbName:(NSString *)alumbId withData:(LKPictureModel *)model;

/*
 删除
 */
-(void)deleteDataWithAlumbName:(NSString *)alumbId withData:(LKPictureModel *)model;
-(BOOL )deleteDataWithAlumbName:(NSString *)alumbId withArray:(NSArray<LKPictureModel *> *)array;
/*
 转移表数据
 */
-(BOOL )deleteDataWithAlumbName:(NSNumber *)alumbId withData:(NSArray *)array insertToAlumbname:(NSNumber *)newAlumbId;

/*
 获取相册全部数据
 */
-(NSArray *)fetchAllAlumbName:(NSString *)alumbName;


/*
 删除相册全部数据
 */
-(void)deleteDataWithAlumbName:(NSString *)alumbId;

/*
 更新数据库
 */
-(void)updateDataWithAlumbName:(NSString *)alumbId withData:(LKPictureModel *)model;

/*
 获取所有相册列表信息
 */
-(NSMutableArray *)fetchAlumbData;

/*
 获取某个相册个数
 */
-(NSInteger)fetchAlumbCountFromCategory:(NSNumber *)categoryId;

//编辑相册图片
-(BOOL)editDataWithAlumbName:(NSString *)alumbId withPicModel:(LKPictureModel *)model;


@end
