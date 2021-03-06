//
//  LKCustomMethods.m
//  Project
//
//  Created by heshenghui on 2018/7/1.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKCustomMethods.h"
#import "LKPictureModel.h"
#import "LKMergeView.h"
#import "LKPIctureUploadManager.h"
@interface LKCustomMethods()

@property(nonatomic,strong) LKMergeView * mergeView;

@end

typedef NS_ENUM(NSInteger,NetStatus) {
    NetStatus_G=1,
    NetStatus_wift,
    NetStatus_noNet,
    NetStatus_noSourse,
    
    
};


@implementation LKCustomMethods


+(CGFloat)strFitFromheight:(NSString*)text withFont:(UIFont *)font withWidth:(CGFloat)width
{
    CGSize size=[text sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
    
    return size.height;
}

/*
 提示
 */
+(void)showView:(id )viewVC withMessage:(NSString *)message
{
    if ([viewVC isKindOfClass:[UIView class]]) {
        
        UIView * hudView = (UIView *)viewVC;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:hudView animated:YES];
        
        // Set the text mode to show only text.
        hud.mode = MBProgressHUDModeText;
        hud.label.text = message;
        hud.label.numberOfLines = 2;
        hud.label.font = LK_15font;
        hud.label.textColor = [UIColor whiteColor];
        hud.bezelView.backgroundColor = [UIColor blackColor];
        // Move to bottm center.
        hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
        
        [hud hideAnimated:YES afterDelay:2.f];
    }else{
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        
        // Set the text mode to show only text.
        hud.mode = MBProgressHUDModeText;
        hud.label.text = message;
        hud.label.numberOfLines = 2;
        hud.label.font = LK_15font;
        hud.label.textColor = [UIColor whiteColor];
        hud.bezelView.backgroundColor = [UIColor blackColor];
        // Move to bottm center.
        hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
        
        [hud hideAnimated:YES afterDelay:2.f];
    }
    
}

+(void)showWindowMessage:(NSString *)message
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.numberOfLines = 2;
    hud.label.font = LK_15font;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.offset = CGPointMake(0.f, kScreen_Height/ 2 - 100 -  kSafeAreaBottomHeight);
    [hud hideAnimated:YES afterDelay:2.f];
    
}
+(void)showWindowMessage:(NSString *)message delayTime:(NSTimeInterval)delayTime dismissHandle:(dispatch_block_t)dismissHandle
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    dispatch_block_t  delayBlock = dismissHandle;

    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.numberOfLines = 2;
    hud.label.font = LK_15font;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.offset = CGPointMake(0.f, kScreen_Height/ 2 - 100 -  kSafeAreaBottomHeight);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
        delayBlock();
    });
}
+(void)showWindowMessage:(NSString *)message delay:(dispatch_block_t)delay
{
    
    
    dispatch_block_t  delayBlock = delay;
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.numberOfLines = 2;
    hud.label.font = LK_15font;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.offset = CGPointMake(0.f, kScreen_Height/ 2 - 100 -  kSafeAreaBottomHeight);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
        delayBlock();
    });
}


/*加载提示*/
+(void)showMBMBHUBView:(UIView * )view
{
    [view showHUD];
}
+(void)hideMBMBHUBView:(UIView * )view
{
    [view hideHUD];

}

/*
 网络检测
 */
+(void)checkNetWork
{
    // 1.创建检测网络状态管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager manager];
    
    // 2.检测网络状态改变
    /**
     AFNetworkReachabilityStatusUnknown          = -1, 未知
     AFNetworkReachabilityStatusNotReachable     = 0, 无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1, 蜂窝网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2, WIFI
     */
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝网络");
                [user setObject:@(NetStatus_G) forKey:LKNetWorksStatus];
                [user synchronize];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                [user setObject:@(NetStatus_wift) forKey:LKNetWorksStatus];
                [user synchronize];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                [user setObject:@(NetStatus_noNet) forKey:LKNetWorksStatus];
                [user synchronize];
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                [user setObject:@(NetStatus_noSourse) forKey:LKNetWorksStatus];
                [user synchronize];
                break;
            default:
                break;
        }
    }];
    
    // 3.开始检测
    [manager startMonitoring];
    

    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(networkStateChange:) name:kReachabilityChangedNotification object:nil];
    
    // 创建Reachability
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    // 开始监控网络(一旦网络状态发生改变, 就会发出通知kReachabilityChangedNotification)
    [reachability startNotifier];
    
    [LKCustomMethods networkStateChange];
    [LKCustomMethods deviceNetWorkStatus];

}

+ (void)networkStateChange:(NSNotification *)notification
{
    Reachability *reach = [notification object];

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

    if([reach isKindOfClass:[Reachability class]]){
        NetworkStatus status = [reach currentReachabilityStatus];
        // 两种检测:路由与服务器是否可达  三种状态:手机流量联网、WiFi联网、没有联网
        if (status == NotReachable) {
            NSLog(@"routerReachability NotReachable");
            [user setObject:@(NetStatus_noSourse) forKey:LKNetWorksStatus];
            [user synchronize];
        } else if (status == ReachableViaWiFi) {
            NSLog(@"routerReachability ReachableViaWiFi");
            [user setObject:@(NetStatus_wift) forKey:LKNetWorksStatus];
            [user synchronize];
            
            [[LKPIctureUploadManager shareInstance] startUpLoadimage];

            
        } else if (status == ReachableViaWWAN) {
            NSLog(@"routerReachability ReachableViaWWAN");
            [user setObject:@(ReachableViaWWAN) forKey:LKNetWorksStatus];
            [user synchronize];
        }
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:LKNetStatusNotiation object:[user objectForKey:LKNetWorksStatus]];

}

+ (void)networkStateChange
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    // 1.检测网络状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络
    Reachability *connect = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) {
        NSLog(@"有wifi");
        [user setObject:@(NetStatus_wift) forKey:LKNetWorksStatus];
        [user synchronize];
    }
    else if ([connect currentReachabilityStatus] != NotReachable) {
        NSLog(@"使用手机自带网络进行上网");
        [user setObject:@(NetStatus_G) forKey:LKNetWorksStatus];
        [user synchronize];
    }
    else {
        NSLog(@"没有网络");
        [user setObject:@(NetStatus_noSourse) forKey:LKNetWorksStatus];
        [user synchronize];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:LKNetStatusNotiation object:[user objectForKey:LKNetWorksStatus]];
}


//通过系统statusBar判断设备网络状态
+ (NSString *)deviceNetWorkStatus
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

    
    UIApplication *app = [UIApplication sharedApplication];
    int type = 0;
    if (!LK_IS_IPHONE_X) {  // 非iPhone X
        NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
        for (id child in children) {
            if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            }
        }
    } else {  //iPhone X
        NSArray *array = [[[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
        NSArray *children = [array[2] subviews];
        for (id child in children) {
            if ([child isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                type = 5;
            } else if ([child isKindOfClass:NSClassFromString(@"_UIStatusBarStringView")]){
                return [child valueForKeyPath:@"originalText"];
            }
        }
    }
    
    switch (type) {
        case 1:
            [user setObject:@(NetStatus_G) forKey:LKNetWorksStatus];
            [user synchronize];
            return @"2G";

        case 2:
            [user setObject:@(NetStatus_G) forKey:LKNetWorksStatus];
            [user synchronize];
            return @"3G";

        case 3:
            [user setObject:@(NetStatus_G) forKey:LKNetWorksStatus];
            [user synchronize];
            return @"4G";

        case 5:
            [user setObject:@(NetStatus_wift) forKey:LKNetWorksStatus];
            [user synchronize];
            return @"WIFI";
        default:
            [user setObject:@(NetStatus_noSourse) forKey:LKNetWorksStatus];
            [user synchronize];
            return @"UNKNOWN";//代表未知网络
    }
}

/*
 保存用户信息
 */
+(void)saveUserInfo:(LKUserInfoModel *)userModel
{
    // 归档
    [NSKeyedArchiver archiveRootObject:userModel toFile:LKUserInfoPath];
}

/*
 删除用户信息
 */
+(void)removeUserInfo
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:LKUserInfoPath error:nil];
    
}

/*
 读取用户信息
 */
+(LKUserInfoModel *)readUserInfo
{
    LKUserInfoModel *userModel = [NSKeyedUnarchiver unarchiveObjectWithFile:LKUserInfoPath];
    return userModel;
}

//字典转json格式字符串：
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return nil;
   
}


//json格式字符串转字典：

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}


//json格式字符串转数组：
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                      
                                                     options:NSJSONReadingMutableContainers
                      
                                                       error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
        
    }
    
    return array;
    
}


//json格式字符串：
+ (id )objectWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
   id array = [NSJSONSerialization JSONObjectWithData:jsonData
                      
                                                     options:NSJSONReadingMutableContainers
                      
                                                       error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
        
    }
    
    return array;
    
}

/*
 删除Views上的控件
 */

+(void)removeViewFromSuperView:(UIView *)view
{
    
    
    [[view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
/*
    NSArray * array = view.subviews;
    for (int i=0; i<array.count; i++) {
        UIView * v =[array objectAtIndex:i];
        [v removeFromSuperview];
    }
 */
}


//时间戳转化时间
+(NSString *)timeStrFormTime:(long long   )count
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:count/1000];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

+(NSString *)timeStrFormTime:(long long   )count withFormatter:(NSString * )formatterText
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:formatterText]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:count];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}


+(NSString *)timeSSStrFormTime:(long long   )count withFormatter:(NSString * )formatterText
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:formatterText]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:count/1000];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}


//保存上传图片信息
+(BOOL)saveUpLoadImages:(NSArray *)array withCategoryId:(NSNumber *)categoryId withCommityId:(NSNumber *)commityId
{
  NSMutableArray *imagesArray = [NSMutableArray arrayWithArray:[UserDefaultsHelper getArrayForKey:LKUpLoadImageArrays]];
    
    if (imagesArray == nil || imagesArray.count == 0) {
        imagesArray = [[NSMutableArray alloc]init];
    }
    BOOL isExist = NO;
    for (int i=0; i<imagesArray.count; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[imagesArray objectAtIndex:i]] ;
        
        NSNumber * category = [dict objectForKey:@"categoryId"];
        if ([category isEqualToNumber:categoryId]) {
            isExist = YES;
            NSMutableArray * imageArray =  [NSMutableArray arrayWithArray:[dict objectForKey:@"imageArray"]];
            
            for (int i=0; i<array.count; i++) {
                LKPictureModel * model = [array objectAtIndex:i];
                
                NSMutableDictionary * modelDict = model.mj_keyValues;
                
                
                [modelDict setValue:categoryId forKey:@"classifyId"];
                [modelDict setValue:commityId forKey:@"commityId"];
                
                
                [imageArray addObject:modelDict];
            }
            
            [dict setObject:imageArray forKey:@"imageArray"];
            
            [imagesArray replaceObjectAtIndex:i withObject:dict];
            
            
        }
        
    }
    if(!isExist ){
        
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
        [dict setObject:categoryId forKey:@"categoryId"];
        
        NSMutableArray * dataArray = [[NSMutableArray alloc]init];
        for (int i=0; i<array.count; i++) {
            LKPictureModel * model = [array objectAtIndex:i];
            
            NSMutableDictionary * modelDict = model.mj_keyValues;
            
            [modelDict setValue:categoryId forKey:@"classifyId"];
            [modelDict setValue:commityId forKey:@"commityId"];
            
            
            [dataArray addObject:modelDict];
        }
        [dict setObject:dataArray forKey:@"imageArray"];
        
        [imagesArray addObject:dict];

    }
    [UserDefaultsHelper setArrayForKey:imagesArray :LKUpLoadImageArrays];
    
    return YES;
    
}

//获取上传图片
+(NSArray * )getUpLoadImagesCountFromCategoryId:(NSNumber *)categoryId
{
    NSMutableArray *imagesArray = [NSMutableArray arrayWithArray:[UserDefaultsHelper getArrayForKey:LKUpLoadImageArrays]];

    NSMutableArray * dataArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i<imagesArray.count; i++) {
        NSMutableDictionary *dict =[imagesArray objectAtIndex:i];
        NSNumber * category = [dict objectForKey:@"categoryId"];
        if ([category isEqualToNumber:categoryId]) {
            
            NSArray * array = [dict objectForKey:@"imageArray"];
            dataArray = [LKUpLoadPictureModel mj_objectArrayWithKeyValuesArray:array];
        }
        
    }
    
    return dataArray;
    
}
//删除需要上传数据
+(NSArray * )deleteleteUpLoadImagesCountFromCategoryId:(NSNumber *)categoryId
{
    NSMutableArray *imagesArray = [NSMutableArray arrayWithArray:[UserDefaultsHelper getArrayForKey:LKUpLoadImageArrays]];
    
    NSMutableArray * dataArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i<imagesArray.count; i++) {
        NSMutableDictionary *dict =[imagesArray objectAtIndex:i];
        NSNumber * category = [dict objectForKey:@"categoryId"];
        if ([category isEqualToNumber:categoryId]) {
            
            [imagesArray removeObject:dict];
        }
        
    }
    [UserDefaultsHelper setArrayForKey:imagesArray :LKUpLoadImageArrays ];
    
    
    return dataArray;
    
}

//合成图片

- (UIImage *)mergePicture:(LKPictureModel *)pictureModel withImagePath:(NSString *)url{
    
    
    if (_mergeView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 2 * kScreen_Height)];
        [view addSubview:self.mergeView];
        [self.mergeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20000);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(kScreen_Width);
        }];
    }
    /** 合成图片 */
    self.mergeView.locationLabel.text = pictureModel.area;
    self.mergeView.tipLabel.text = pictureModel.des;
    self.mergeView.timeLabel.text = [LKCustomMethods timeStrFormTime:[pictureModel.time longLongValue] withFormatter:@"YYYY年MM月dd日 HH:mm:ss"];
    [self.mergeView layoutIfNeeded];
    UIImage *extraImage = [LKCustomTool makeImageWithView:self.mergeView.extraView withSize:self.mergeView.extraView.size];
    UIImage *originImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@",url,pictureModel.picName]];
    if (originImage == nil) {
        return nil;
    }
    UIImage *mergeImage = [LKCustomTool composeImageOnMainImage:originImage mainImageViewFrame:self.mergeView.frame subImageArray:@[extraImage] subImageFrameArray:@[NSStringFromCGRect(CGRectMake(0, self.mergeView.mergeImageView.height - extraImage.size.height, self.mergeView.mergeImageView.width, extraImage.size.height))]];
    
    return mergeImage;
}


+ (void)calulateImageFileSize:(NSData *)data {
    
    double dataLength = [data length] * 1.0;
    NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
    NSInteger index = 0;
    while (dataLength > 1024) {
        dataLength /= 1024.0;
        index ++;
    }
    NSLog(@"image = %.3f %@",dataLength,typeArray[index]);
}


//lazy

- (LKMergeView *)mergeView {
    if (_mergeView == nil) {
        _mergeView = [[LKMergeView alloc]init];
    }
    return _mergeView;
}

@end
