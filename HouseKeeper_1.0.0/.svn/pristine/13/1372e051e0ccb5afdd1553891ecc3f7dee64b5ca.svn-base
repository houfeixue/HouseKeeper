//
//  LKCustomMethods.h
//  Project
//
//  Created by heshenghui on 2018/7/1.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKUserInfoModel.h"

@class LKPictureModel;


@interface LKCustomMethods : NSObject
/*
 隐藏导航栏
 */

/*
显示导航栏
*/

/*
 提示
 */
+(void)showView:(id )viewVC withMessage:(NSString *)message;
+(void)showWindowMessage:(NSString *)message;
+(void)showWindowMessage:(NSString *)message delay:(dispatch_block_t)delay;
+(void)showWindowMessage:(NSString *)message delayTime:(NSTimeInterval)delayTime dismissHandle:(dispatch_block_t)dismissHandle;
/*加载提示*/
+(void)showMBMBHUBView:(UIView * )view;
+(void)hideMBMBHUBView:(UIView * )view;

/*
 网络检测
 */
+(void)checkNetWork;

/*
 保存用户信息
 */
+(void)saveUserInfo:(LKUserInfoModel *)userModel;
/*
  删除用户信息
 */
+(void)removeUserInfo;

/*
 读取用户信息
 */
+(LKUserInfoModel *)readUserInfo;


//字典转json格式字符串：
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;


//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//json格式字符串转数组：
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;
//json格式字符串：
+ (id )objectWithJsonString:(NSString *)jsonString;


/*
 删除Views上的控件
 */
+(void)removeViewFromSuperView:(UIView *)view;


//时间戳转化时间
+(NSString *)timeStrFormTime:(long long )count;
+(NSString *)timeStrFormTime:(long long   )count withFormatter:(NSString * )formatterText;
+(NSString *)timeSSStrFormTime:(long long   )count withFormatter:(NSString * )formatterText;



//保存上传图片信息
+(BOOL)saveUpLoadImages:(NSArray *)array withCategoryId:(NSNumber *)categoryId withCommityId:(NSNumber *)commityId;
//获取上传图片
+(NSArray * )getUpLoadImagesCountFromCategoryId:(NSNumber *)categoryId;
//删除需要上传数据
+(NSArray * )deleteleteUpLoadImagesCountFromCategoryId:(NSNumber *)categoryId;
//合成图片
- (UIImage *)mergePicture:(LKPictureModel *)pictureModel withImagePath:(NSString *)url;


+(CGFloat)strFitFromheight:(NSString*)text withFont:(UIFont *)font withWidth:(CGFloat)width;

//
+ (void)calulateImageFileSize:(NSData *)data  ;

@end

