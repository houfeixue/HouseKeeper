//
//  HttpTool.h
//      
//
//  Created by heshenghui on 2018/1/10.
//

#import <Foundation/Foundation.h>


typedef void(^HttpUploadSuccessBlock)(id Json);
typedef void(^HttpUploadFailureBlock)(void);

@interface LKHttpImageRequest : NSObject
/**
 *  上传图片(单张)
 *
 *  @param path    路径
 *  @param image   图片
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)uploadImageWithPath:(NSString *)path image:(UIImage *)image params:(NSDictionary *)params success:(HttpUploadSuccessBlock)success failure:(HttpUploadFailureBlock)failure;

/**
 *  上传图片(多张)
 *
 *  @param path    路径
 *  @param photos  图片数组
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)uploadImageWithPath:(NSString *)path photos:(NSArray *)photos params:(NSDictionary *)params success:(HttpUploadSuccessBlock)success failure:(HttpUploadFailureBlock)failure;




@end
