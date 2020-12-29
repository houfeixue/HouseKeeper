//
//  LKImageFileManager.h
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKImageFileManager : NSObject

+(LKImageFileManager *)shareManager;

//保存图片
-(void)saveImageToPicture:(UIImage *)image withImageName:(NSString *)imageName mergeModel:(LKPictureModel *)pictureModel;
//删除图片
-(void)deleteImageToPictureName:(NSString *)imageName;
-(void)editCompoundToPictureName:(NSString *)imageName withPictureModel:(LKPictureModel *)pictureModel withImage:(UIImage *)image;

@end
