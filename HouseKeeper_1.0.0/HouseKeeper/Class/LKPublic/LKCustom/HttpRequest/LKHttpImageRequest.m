//
//  HttpTool.m
//      
//
//  Created by heshenghui on 2018/1/10.
//

#import "LKHttpImageRequest.h"
#import "AFNetworking.h"
static AFHTTPSessionManager *manager;
@implementation LKHttpImageRequest
+ (AFHTTPSessionManager *)sharedHttpSession
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"multipart/form-data", nil];
    });
    return manager;
}
#pragma mark 上传单张图片
+ (void)uploadImageWithPath:(NSString *)path image:(UIImage *)image params:(NSDictionary *)params success:(HttpUploadSuccessBlock)success failure:(HttpUploadFailureBlock)failure
{
//    NSArray *array = [NSArray arrayWithObject:image];
    NSMutableArray * array =[[NSMutableArray alloc]init];
    if (image != nil) {
        [array addObject:image];
    }
    [self uploadImageWithPath:path photos:array params:params success:success failure:failure];
}


#pragma mark 上传图片
+ (void)uploadImageWithPath:(NSString *)path photos:(NSArray *)photos params:(NSDictionary *)params success:(HttpUploadSuccessBlock)success failure:(HttpUploadFailureBlock)failure
{
    path = [NSString stringWithFormat:@"%@%@",BaseHost,path];
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [LKHttpImageRequest sharedHttpSession];
    [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        for (int i = 0; i < photos.count; i ++) {
           
            id object = photos[i];

            if ([object isKindOfClass:[UIImage class]]) {
                NSString *fileName=[NSString stringWithFormat:@"%d.jpg",i];

                UIImage *image = photos[i];
                NSData *imageData = UIImageJPEGRepresentation(image, 0.28);
                [formData appendPartWithFileData:imageData name:@"filelist" fileName:fileName mimeType:@"image/jpeg"];

               
            }else if ([object isKindOfClass:[NSURL class]])
            {

                NSURL *resourcePath = (NSURL *)object;
                NSData *data = [NSData dataWithContentsOfURL:resourcePath];
                NSString *fileName = resourcePath.lastPathComponent;
                NSString *mimeType = [self fileMIMEType:fileName];
                [formData appendPartWithFileData:data
                                            name: @"filelist"
                                        fileName:fileName
                                        mimeType:mimeType];
            }
        }
        
        
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"resultInfo is %@",responseObject);
        success(responseObject);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure == nil) return ;
        failure();
    }];
    

}



+ (NSString*)fileMIMEType:(NSString*)file
{
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[file pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    return (__bridge NSString *)MIMEType;
}


@end
