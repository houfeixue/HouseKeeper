//
//  AppDelegate.m
//  Project
//
//  Created by heshenghui on 2018/6/29.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "AppDelegate.h"
#import "CYLPlusButtonSubclass.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LKLocationManager.h"
#import "LKUpdateVersion.h"

#import "LKLoginVC.h"
#import "LKHomePageVc.h"
//图片上传
#import "LKPIctureUploadManager.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "LKSearchCommunityResultVC.h"
#import "introductoryPagesHelper.h"


@interface AppDelegate ()<UITabBarControllerDelegate>{
    CLLocationManager *manager;
}
@property(nonatomic,strong)NSString *app_url;

@end

@implementation AppDelegate


#define RANDOM_COLOR [UIColor colorWithHue: (arc4random() % 256 / 256.0) saturation:((arc4random()% 128 / 256.0 ) + 0.5) brightness:(( arc4random() % 128 / 256.0 ) + 0.5) alpha:1]


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //    [CYLPlusButtonSubclass registerPlusButton];
    

    self.window.backgroundColor = [UIColor whiteColor];
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    /** 去掉导航下面的细线 */
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    /** IQ开启 */
    [self startIQKeyboard];
    [self configYYImageCache];
    LKUserInfoModel * model = [LKCustomMethods readUserInfo];
    if (model == nil || model.userId == 0 || model.isLoginSuccess == NO) {
        LKLoginVC *vc = [[LKLoginVC alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.window setRootViewController:nav];
    }else{
        LKHomePageVc *vc = [[LKHomePageVc alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.window setRootViewController:nav];
    }
    
    manager = [[CLLocationManager alloc] init];
    [manager requestAlwaysAuthorization];
    [manager requestWhenInUseAuthorization];
    
    //检测网络
    [LKCustomMethods checkNetWork];
    
    if (model == nil || model.userId == 0 || model.isLoginSuccess == NO) {
        //获取相册管理
        [self getAlumbCategorys];
    }
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"loginSuccess" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self jumpToHome];
        //获取相册管理
        [self getAlumbCategorys];
    }];
    
    //默认上传打开
    [UserDefaultsHelper setBoolForKey:NO :LKUser_IsCancelUpLoad];
    [UserDefaultsHelper setStringForKey:@"1" :LKUpLoadImageNetStatus ];

    [[LKPIctureUploadManager shareInstance] startUpLoadimage];
    
     [self getEdition];//版本更新
    
    [self.window makeKeyAndVisible];

    [self setupIntroductoryPage];

    return YES;
    

}

-(void)jumpToHome{
    LKHomePageVc *vc = [[LKHomePageVc alloc] init];
     UINavigationController * nav = [[UINavigationController  alloc] initWithRootViewController:vc];
    [self.window setRootViewController:nav];
}

#pragma mark 引导页
-(void)setupIntroductoryPage
{

  BOOL firstOpen = [UserDefaultsHelper getBoolForKey:LKUser_FirstOpen];
    if (firstOpen == YES) {
        return;
    }
    
    NSArray *images = [NSArray array];
//    if (kScreen_Width == 320)
//    {
//        if (kScreen_Height == 480 ) {
//
//            images = @[@"1",@"2",@"3",@"4"];
//
//        }else
//        {
//            images = @[@"1",@"2",@"3",@"4"];
//        }
//
//    }
//    else if (kScreen_Width == 375)
//    {
//        images = @[@"1",@"2",@"3",@"4"];
//    }else
//    {
//        images = @[@"1",@"2",@"3",@"4"];
//    }
    
    if (LK_IS_IPHONE_X) {
      images = @[@"1iX",@"2iX",@"3iX",@"4iX"];

    }else{
        images = @[@"1",@"2",@"3",@"4"];

    }
    
    [introductoryPagesHelper showIntroductoryPageView:images];
}

//获取相册管理
-(void)getAlumbCategorys{
    [[LKHttpRequest request]POST:LKGetCateGroys parameters:@{} tag:0 success:^(LKHttpRequest * _Nonnull request, NSInteger tag, NSString * _Nonnull responseString) {
        NSDictionary * responseDict = [LKCustomMethods dictionaryWithJsonString:responseString];
        if ([[responseDict objectForKey:@"status"] integerValue] == 1) {

           NSMutableArray *alumbArray = [NSMutableArray arrayWithArray:[LKCustomMethods arrayWithJsonString:[LKEntcry decryptAES:[responseDict objectForKey:@"data"]]]] ;
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            [dict setObject:@(0) forKey:@"categoryId"];
            [dict setObject:@"默认" forKey:@"categoryName"];
            [alumbArray insertObject:dict atIndex:0];
            [UserDefaultsHelper setArrayForKey:alumbArray :LKUser_Alumb];

        }else{

            [self reloadAlumbCategorys];

           [LKCustomMethods showWindowMessage:[responseDict objectForKey:@"msg"]];
        }


    } failure:^(LKHttpRequest * _Nonnull request, NSInteger tag, NSError * _Nonnull error) {
        [self reloadAlumbCategorys];

        NSLog(@"%@",error.localizedDescription);
    }];
}


-(void)reloadAlumbCategorys
{
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接失败" delegate:self cancelButtonTitle:@"重试" otherButtonTitles: nil];
    
    [alert show];
    @weakify(self);
    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self getAlumbCategorys];
        
    }];
    
}

//设置导航栏

//- (void)customizeInterfaceWithTabBarController:(CYLTabBarController *)tabBarController {
//    //设置导航栏
//    [self setUpNavigationBarAppearance];
//
//    [tabBarController hideTabBadgeBackgroundSeparator];
//    //添加小红点
//    UIViewController *viewController = tabBarController.viewControllers[0];
//    UIView *tabBadgePointView0 = [UIView cyl_tabBadgePointViewWithClolor:RANDOM_COLOR radius:4.5];
//    [viewController.tabBarItem.cyl_tabButton cyl_setTabBadgePointView:tabBadgePointView0];
//    [viewController cyl_showTabBadgePoint];
//
//    UIView *tabBadgePointView1 = [UIView cyl_tabBadgePointViewWithClolor:RANDOM_COLOR radius:4.5];
//    @try {
//        [tabBarController.viewControllers[1] cyl_setTabBadgePointView:tabBadgePointView1];
//        [tabBarController.viewControllers[1] cyl_showTabBadgePoint];
//
//        UIView *tabBadgePointView2 = [UIView cyl_tabBadgePointViewWithClolor:RANDOM_COLOR radius:4.5];
//        [tabBarController.viewControllers[2] cyl_setTabBadgePointView:tabBadgePointView2];
//        [tabBarController.viewControllers[2] cyl_showTabBadgePoint];
//
//        [tabBarController.viewControllers[3] cyl_showTabBadgePoint];
//
//        //添加提示动画，引导用户点击
//        [self addScaleAnimationOnView:tabBarController.viewControllers[3].cyl_tabButton.cyl_tabImageView repeatCount:20];
//    } @catch (NSException *exception) {}
//}

/**
 *  设置navigationBar样式
 */
- (void)setUpNavigationBarAppearance {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName : [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        textAttributes = @{
                           UITextAttributeFont : [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor : [UIColor blackColor],
                           UITextAttributeTextShadowColor : [UIColor clearColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

#pragma mark - delegate

//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
//    return YES;
//}
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
//    UIView *animationView;
//
//    if ([control cyl_isTabButton]) {
//        //更改红标状态
//        if ([[self cyl_tabBarController].selectedViewController cyl_isShowTabBadgePoint]) {
//            [[self cyl_tabBarController].selectedViewController cyl_removeTabBadgePoint];
//        } else {
//            [[self cyl_tabBarController].selectedViewController cyl_showTabBadgePoint];
//        }
//
//        animationView = [control cyl_tabImageView];
//    }
//
//    // 即使 PlusButton 也添加了点击事件，点击 PlusButton 后也会触发该代理方法。
//    if ([control cyl_isPlusButton]) {
//        UIButton *button = CYLExternPlusButton;
//        animationView = button.imageView;
//    }
//
//    if ([self cyl_tabBarController].selectedIndex % 2 == 0) {
//        [self addScaleAnimationOnView:animationView repeatCount:1];
//    } else {
//        [self addRotateAnimationOnView:animationView];
//    }
//}

//缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

//旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
    // 针对旋转动画，需要将旋转轴向屏幕外侧平移，最大图片宽度的一半
    // 否则背景与按钮图片处于同一层次，当按钮图片旋转时，转轴就在背景图上，动画时会有一部分在背景图之下。
    // 动画结束后复位
    animationView.layer.zPosition = 65.f / 2;
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    // 清空磁盘缓存，带进度回调
    [cache.memoryCache removeAllObjects];
    [cache.diskCache removeAllObjects];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];

}
- (void)startIQKeyboard {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    [manager setEnable:YES];
    [manager setEnableAutoToolbar:YES];
    [manager setShouldResignOnTouchOutside:YES];
}
- (void)configYYImageCache {
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    YYMemoryCache *memoryCache = cache.memoryCache;
    memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;//内存警告的时候删除所有内容
    memoryCache.countLimit = 100;
    [[SDWebImageManager sharedManager].imageCache setMaxMemoryCountLimit:20];

}
#pragma mark - 版本更新
-(void)getEdition
{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSString *bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [dict setObject:bundleVersion forKey:@"version"];
    [dict setObject:@"1" forKey:@"type"];
    
    [[LKHttpRequest  request] POST:LKGetInfoByVersion parameters:dict tag:0 success:^(LKHttpRequest * _Nonnull request, NSInteger tag, NSString * _Nonnull responseString) {
        NSDictionary *requestJson = [LKCustomMethods dictionaryWithJsonString:responseString];
        int successResult  = [[requestJson objectForKey:@"status"] intValue];
        if ( successResult == 1) {
            NSString * data = [LKEntcry decryptAES:[requestJson objectForKey:@"data"]];
            id  dataDict = [LKCustomMethods dictionaryWithJsonString:data];
            if ([dataDict isKindOfClass:[NSDictionary class]]) {
                 NSDictionary * d = (NSDictionary *)dataDict;
                 NSNumber * isForce = [d numberForKey:@"isForce"];
                 NSString * version = [NSString stringWithFormat:@"%@",[d stringForKey:@"version"]];
                 [UserDefaultsHelper setStringForKey:version :LKUser_LatestVersion];
                 self.app_url = [d stringForKey:@"appUrl"];
                
                 NSString * fixBug = [NSString stringWithFormat:@"%@",[d stringForKey:@"func"]];
                 LKUpdateVersion * versionView = [[LKUpdateVersion alloc]initWithTitle:version withContent:fixBug withUpdate:[NSString stringWithFormat:@"%@",isForce]];
                 versionView.careLeftClick = ^(NSString *status) {
                        if ([status isEqualToString:@"1"]) {
                              //强制更新
                              NSString *appPath=self.app_url;
                              NSLog(@"%@",appPath);
                              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.app_url]];
                              exit(0);
                                    ;
                            }else if ([status isEqualToString:@"2"]){

                            }else if ([status isEqualToString:@"3"]){
                               NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                               [defaults setObject:version forKey:LKVersion];
                               [defaults synchronize];
                            }
            
                            };
                 versionView.careRightClick = ^(NSString *status) {
                                if ([status isEqualToString:@"1"]) {
                                    ;
                                }else if ([status isEqualToString:@"2"]){
                                    NSString *appPath=self.app_url;
                                    NSLog(@"%@",appPath);
                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.app_url]];
                                    exit(0);
            
                                }else if ([status isEqualToString:@"3"]){
            
                                    NSString *appPath=self.app_url;
                                    NSLog(@"%@",appPath);
                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.app_url]];
                                    exit(0);
            
                                }
                            };
            
            
                            if ([isForce intValue] == 3){
                                NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                                NSString *lkVersion = [defaults stringForKey:LKVersion];
                                if (![lkVersion isEqualToString:version]) {
                                    [versionView show];
            
                                }
                            }else{
                                [versionView show];
            
                            }
            
                        }
            
        }else  if(successResult == 2){
            NSString * data = [LKEntcry decryptAES:[requestJson objectForKey:@"data"]];
            id  dataDict = [LKCustomMethods dictionaryWithJsonString:data];
            
            if ([dataDict isKindOfClass:[NSDictionary class]]) {
                NSString * version = [NSString stringWithFormat:@"%@",[dataDict stringForKey:@"version"]];
                [UserDefaultsHelper setStringForKey:version :LKUser_LatestVersion];
            }
            DLog(@"data : %@",data);
        }
        
    } failure:^(LKHttpRequest * _Nonnull request, NSInteger tag, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
       
    }];
    
    
}


@end
