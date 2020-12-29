//
//  LKHttpRequest.h
//  Project
//
//  Created by heshenghui on 2018/7/1.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKHttpRequest : NSObject

/**
 *[AFNetWorking]的operationManager对象
 */
//@property (nonatomic, strong) AFHTTPSessionManager* operationManager;

/**
 *当前的请求operation队列
 */
@property (nonatomic, strong) NSOperationQueue* operationQueue;


/**
 *功能: 创建CMRequest的对象方法
 */
+ (LKHttpRequest *)request;



/**
 *功能：GET请求
 *参数：(1)请求的url: urlString
 *     (2)请求成功调用的Block: success
 *     (3)请求失败调用的Block: failure
 */
- (void)GET:(NSString *)URLString
 parameters:(NSDictionary*)parameters tag:(NSInteger )tag
    success:(void (^)(LKHttpRequest *request, NSInteger tag, NSString* responseString))success
    failure:(void (^)(LKHttpRequest *request, NSInteger tag, NSError *error))failure;



/*
post,请求
*/

- (void)POST:(NSString *)URLString
      parameters:(NSDictionary*)parameters tag:(NSInteger )tag
         success:(void (^)(LKHttpRequest *request, NSInteger tag, NSString* responseString))success
         failure:(void (^)(LKHttpRequest *request, NSInteger tag, NSError *error))failure;

/*
 取消全部请求
 */


@end

NS_ASSUME_NONNULL_END
