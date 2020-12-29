//
//  LKHttpRequest.m
//  Project
//
//  Created by heshenghui on 2018/7/1.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKHttpRequest.h"

static LKHttpRequest *request = nil;
static AFHTTPSessionManager *afnManager = nil;

@implementation LKHttpRequest



+ (LKHttpRequest *)request{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[LKHttpRequest alloc] init];
        afnManager = [AFHTTPSessionManager manager];
    });
    
    return request;
}


/**
 *功能：GET请求
 *参数：(1)请求的url: urlString
 *     (2)请求成功调用的Block: success
 *     (3)请求失败调用的Block: failure
 */
- (void)GET:(NSString *)URLString
 parameters:(NSDictionary*)parameters tag:(NSInteger )tag
    success:(void (^)(LKHttpRequest *request, NSInteger tag, NSString* responseString))success
    failure:(void (^)(LKHttpRequest *request, NSInteger tag, NSError *error))failure
{
    
    self.operationQueue=afnManager.operationQueue;
    afnManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [afnManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"[CMRequest]: %@",responseJson);
        
        success(self,tag,responseJson);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"[CMRequest]: %@",error.localizedDescription);
        failure(self,tag,error);
    }];
    
}

/*
 post,请求
 */

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary*)parameters tag:(NSInteger )tag
     success:(void (^)(LKHttpRequest *request, NSInteger tag, NSString* responseString))success
     failure:(void (^)(LKHttpRequest *request, NSInteger tag, NSError *error))failure
{
    URLString = [NSString stringWithFormat:@"%@%@",LKHostIP,URLString];
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [afnManager.requestSerializer setValue:deviceUUID forHTTPHeaderField:@"DEVICE_ID"];
    LKUserInfoModel * userInfoModel =[LKCustomMethods readUserInfo];
    if (userInfoModel != nil) {
        [afnManager.requestSerializer setValue:[LKCustomTool isBlankString:userInfoModel.token] == NO ? userInfoModel.token :@"" forHTTPHeaderField:@"TOKEN"];
        [afnManager.requestSerializer setValue:[NSString stringWithFormat:@"%d",userInfoModel.userId] forHTTPHeaderField:@"USER_ID"];
    }


    NSMutableDictionary * dict;
    if (parameters != nil&&parameters.allKeys.count>0) {
        
        
        dict = [NSMutableDictionary new];
        [dict setObject:[LKEntcry encryptAES:[LKCustomMethods dictionaryToJson:parameters]] forKey:@"param"];
    }else{
        dict = nil;
    }
    
    self.operationQueue = afnManager.operationQueue;
    afnManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [afnManager POST:URLString parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString* responseJson = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        // responseJson=[self decrypt:responseJson];
        success(self,tag,responseJson);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"[CMRequest]: %@",error.localizedDescription);
        failure(self,tag,error);
        
    }];
}


@end
