//
//  LKPIctureUploadManager.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/8/2.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPIctureUploadManager.h"
#import "LKUpLoadPictureModel.h"
static LKPIctureUploadManager * _instance = nil;


@implementation LKPIctureUploadManager

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
        
    }) ;
    
    return _instance ;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void) startUpLoadimage
{
    
//    if (_isSingle == NO) {
//        return;
//    }

    dispatch_queue_t concurrentQueue = dispatch_queue_create("LKimageUpload.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^(){
        //删除已上传完成的
        
        
        NSMutableArray *imagesArray = [NSMutableArray arrayWithArray:[UserDefaultsHelper getArrayForKey:LKUpLoadImageArrays]];
        NSMutableArray * cacheArray = [[NSMutableArray alloc]initWithArray:[UserDefaultsHelper getArrayForKey:LKUpLoadImageArrays]];
        
        for (int i=0; i<imagesArray.count; i++) {
            NSDictionary * dict = [imagesArray objectAtIndex:i];
            NSMutableArray * uploadImageArray = [dict objectForKey:@"imageArray"];
            
            BOOL isUploadImage = NO;//不存在上传图片
            for ( int j=0; j<uploadImageArray.count; j++) {
                
                NSDictionary * dictImage =[uploadImageArray objectAtIndex:j];
                LKUpLoadPictureModel *model =  [LKUpLoadPictureModel mj_objectWithKeyValues:dictImage];
                if (!model.upLoad) {
                    isUploadImage = YES;//不存在上传图片
                }
                
            }
            
            if (isUploadImage == NO) {
                //不存在上传图片 删除本地
                [cacheArray removeObject:dict];
            }
            
        }
        
        [UserDefaultsHelper setArrayForKey:cacheArray :LKUpLoadImageArrays];
    });
    
    dispatch_barrier_async(concurrentQueue, ^(){
        //上传没有上传的图片
   
    
                NSMutableArray *imagesArray = [NSMutableArray arrayWithArray:[UserDefaultsHelper getArrayForKey:LKUpLoadImageArrays]];
        
                if (imagesArray.count == 0) {
                    DLog(@"没有图片需要上传");
                    return;
                }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            NSInteger NetWorks =  [UserDefaultsHelper getIntForkey:LKNetWorksStatus];
            if(NetWorks != 2){
                
                DLog(@"非WIFT有图片需要上传");
                
                NSString * upLoadImageNetStatus = [UserDefaultsHelper getStringForKey:LKUpLoadImageNetStatus];
                if ([upLoadImageNetStatus isEqualToString:@"1"]) {
                    //非Wift
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [Dialog showCustomAlertViewWithTitle:@"提示" message:@"当前非wifi网络下会消耗大量数据流量" firstButtonName:@"wifi自动上传" secondButtonName:@"立即上传" dismissHandler:^(NSInteger index) {
                            if (index == 0) {
                                [UserDefaultsHelper setStringForKey:@"1" :LKUpLoadImageNetStatus ];
                                return ;
                                
                            }else if(index == 1){
                                [UserDefaultsHelper setStringForKey:@"2" :LKUpLoadImageNetStatus ];
                                
                                [self startUpLoadimage];
                            }
                        }];
                    });
                    return ;
                }
            }
            for(int i=0 ;i < imagesArray.count ;i++ ){
                
                BOOL isCancelLoad = [UserDefaultsHelper getBoolForKey:LKUser_IsCancelUpLoad];
                if (isCancelLoad) {
                    DLog(@"用户取消上传");
                    return;
                }
                
                NSDictionary * dict = [imagesArray objectAtIndex:i];
                
                NSNumber * category = [dict objectForKey:@"categoryId"];
                
                NSMutableArray * uploadImageArray = [dict objectForKey:@"imageArray"];
                
                BOOL isBack = NO;
                
                for ( int j=0; j<uploadImageArray.count; j++) {
                    
                    NSDictionary * dictImage =[uploadImageArray objectAtIndex:j];
                    LKUpLoadPictureModel *model =  [LKUpLoadPictureModel mj_objectWithKeyValues:dictImage];
                    if (!model.upLoad) {
                        NSDictionary * paramDict = [[NSDictionary alloc]initWithObjectsAndKeys:@"app",@"sign", nil];
                        
//                        UIImage * image =  [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",LKCompoundPicturePath,model.picName]];
                        
                        UIImage * image =  [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",LKCompoundPicturePath,model.picName]];
                        
                        if (image == nil) {
                            model.upLoad = YES;
                            [uploadImageArray replaceObjectAtIndex:j withObject:model];
                            [UserDefaultsHelper setArrayForKey:imagesArray :LKUpLoadImageArrays ];
                            [[NSNotificationCenter defaultCenter]postNotificationName:LKImageUploadOKNotiation object:nil];
                            //上传下一个
                            DLog(@"上传下一个");
                            [self startUpLoadimage];
                            
                            return;
                            
                        }
                        
                        
                        if (self.isSingleUpload == YES) {
                            return;
                        }
                        self.isSingleUpload = YES;

                        WS(weakSelf)
                        [LKHttpImageRequest uploadImageWithPath:LKUploadimg  image:image params:paramDict success:^(id Json) {
                            DLog(@"图片上传成功%@",Json);
                            NSDictionary * requestDict = (NSDictionary *)Json;
                            
                            if ([[requestDict numberForKey:@"status"] integerValue] == 1) {
                                self.isSingleUpload = YES;

                                DLog(@"Uploadimg : image  :   %@",[LKEntcry decryptAES:[requestDict objectForKey:@"data"]]);
                                
                                NSArray *dataArray =  [LKCustomMethods arrayWithJsonString:[LKEntcry decryptAES:[requestDict objectForKey:@"data"]]];
                                [weakSelf upLoadImageUrl:dataArray with:model withCategory:category];
                                DLog(@"%@",dataArray);
                            }else{
                                self.isSingleUpload = NO;

                            }
                            
                        } failure:^{
                            
                            DLog(@"图片上传失败");
                            self.isSingleUpload = NO;

                            
                        }];
                        
                        isBack = YES;
                        break;
                    }
                    if (isBack) {
                        break;
                    }
                    
                }
            }
            
        });
        
        
        
    });
}




//上传接口
-(void)upLoadImageUrl:(NSArray *)urlArray with:(LKUpLoadPictureModel * )model withCategory:(NSNumber *)categoryId
{
    
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i=0; i<urlArray.count; i++) {
        
        NSString *imageUrl = [urlArray objectAtIndex:i];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setObject:model.classifyId forKey:@"masterId"];
        [dict setObject:imageUrl forKey:@"url"];
        [dict setObject:@"img" forKey:@"type"];
        [dict setObject:model.commityId forKey:@"residenceId"];
        [dict setObject:model.area forKey:@"position"];
        [dict setObject:model.des forKey:@"desc"];
        [array addObject:dict];
    }
    

    [paramDict setObject:array forKey:@"attachMent"];
    
    DLog(@"Attchment : paramDict :   %@",paramDict);
    
    [[LKHttpRequest request]POST:LKUploadAttchment parameters:paramDict tag:0 success:^(LKHttpRequest * _Nonnull request, NSInteger tag, NSString * _Nonnull responseString) {
        DLog(@"LKUploadAttchment : %@",responseString);
        
        NSDictionary * requestDict = [LKCustomMethods dictionaryWithJsonString:responseString];

        if ([[requestDict numberForKey:@"status"] integerValue] == 1) {
            
            NSMutableArray *imagesArray = [NSMutableArray arrayWithArray:[UserDefaultsHelper getArrayForKey:LKUpLoadImageArrays]];
            
            for (int i=0; i<imagesArray.count; i++) {
                NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[imagesArray objectAtIndex:i]];
                NSNumber * category = [dict objectForKey:@"categoryId"];
                if ([category isEqualToNumber:categoryId]) {
                    NSMutableArray * uploadImageArray =  [NSMutableArray arrayWithArray:[dict objectForKey:@"imageArray"]];
                    
                    for ( int j=0; j<uploadImageArray.count; j++) {
                        
                        NSDictionary * dictImage =[uploadImageArray objectAtIndex:j];
                        LKUpLoadPictureModel *m =  [LKUpLoadPictureModel mj_objectWithKeyValues:dictImage];
                        if ([self isEqualUploadModel:model withModel:m]) {
                            m.upLoad = YES;
                            NSMutableDictionary * selectImageDict = m.mj_keyValues;
                            [uploadImageArray replaceObjectAtIndex:j withObject:selectImageDict];
                            [dict setValue:uploadImageArray forKey:@"imageArray"];
                            
                            [imagesArray replaceObjectAtIndex:i withObject:dict];
                            [UserDefaultsHelper setArrayForKey:imagesArray :LKUpLoadImageArrays ];
                            [[NSNotificationCenter defaultCenter]postNotificationName:LKImageUploadOKNotiation object:nil];
                            //上传下一个
                            DLog(@"上传下一个");
                            self.isSingleUpload = NO;
                            [self startUpLoadimage];

                        }
                    }
                }

            }
        }else{
            self.isSingleUpload = NO;

        }
        
    } failure:^(LKHttpRequest * _Nonnull request, NSInteger tag, NSError * _Nonnull error) {
        DLog(@"LKUploadAttchment : %@",error.localizedDescription);
        self.isSingleUpload = NO;

    }];
}


-(BOOL)isEqualUploadModel:(LKUpLoadPictureModel *)m1 withModel:(LKUpLoadPictureModel *)m2{
    
    if ([m1.classifyId isEqualToNumber:m2.classifyId]&&[m1.commityId isEqualToNumber:m2.commityId]&&[m1.picName isEqualToString:m2.picName]&&((m1.des == nil && m2.des== nil) ||[m1.des isEqualToString:m2.des])&& ((m1.time == nil && m2.time== nil) || [m1.time isEqualToString:m2.time])&& ((m1.area == nil && m2.area== nil) ||  [m1.area isEqualToString:m2.area])&&m1.upLoad == m2.upLoad ) {
        DLog(@"图片一样");
        return YES;
        
    }
    return NO;
    
}



@end
