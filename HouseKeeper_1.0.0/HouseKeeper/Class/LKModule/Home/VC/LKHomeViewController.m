//
//  LKHomeViewController.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/10.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKHomeViewController.h"
#import "LKHomeAllViewModel.h"
#import "LKHomeTableViewCell.h"
#import "LKLocationManager.h"
#import "LKCameraTool.h"
#import "LKCalendarVC.h"
#import "LKAuthorViewController.h"
#import "CustomActionSheet.h"
#import "LKPictureHandleVC.h"
#import "LKAlumbsViewController.h"
#import "LKTestViewController.h"

@interface LKHomeViewController ()<UITableViewDelegate>
@property (nonatomic, strong) LKHomeListViewModel *requestListModel;

@end

@implementation LKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //UI初始化加载功能
//    self.dataSource = self.requestListModel;
    [self conFigTableRefresh];
    [self conFigTableLoadMoreData];
    
//    UIImage *image = [UIImage imageNamed:@"message_highlight"];
//
//    NSString * imagePath = [NSString stringWithFormat:@"%@/%@.jpg",LKPicturePath,@"123"];
//
//    BOOL saveImage = [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    
//    
//    [LKHttpImageRequest uploadImageWithPath:LKUploadimg image:[UIImage imageNamed:@""] params:[NSDictionary new] success:^(id Json) {
//        <#code#>
//    } failure:^{
//        <#code#>
//    }]
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = LKRedColor;
    [btn setTitle:@"拍照" forState:UIControlStateNormal];

    btn.frame = CGRectMake(100, 100, 100, 100);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @weakify(self);
        
//        LKTestViewController * vc =[[LKTestViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
        [ [LKCameraTool sharedLKCameraTool]showPickerController:self pictureHandle:^(NSMutableDictionary * dict) {
            LKPictureHandleVC *vc = [[LKPictureHandleVC alloc] init];
            vc.pictureDict = dict;
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }];
    [self.view addSubview:btn];
    [self.view bringSubviewToFront:btn];
    
   
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = LKBlueColor;
    [btn1 setTitle:@"工作相册" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(100, 200, 100, 100);
    @weakify(self);

    [[btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        LKAlumbsViewController * vc = [[LKAlumbsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
       
    }];
    [self.view addSubview:btn1];
    [self.view bringSubviewToFront:btn1];
    
    [self.dataSource.refreshLoadData subscribeNext:^(id x) {
        //加载数据
          @strongify(self)
        
//        //验证吗
//        self.requestListModel.requestUrl = LKSendAuthCode;
//        self.requestListModel.requestTag =  1;
//        self.requestListModel.requestDict = @{@"mobile":@"18310348645",@"type":@"2"};
       

    }];
    
//    CustomActionSheet * sheet = [[CustomActionSheet alloc]initWithTitle:nil OtherButtons:@[@"1",@"2"] CancleButton:@"quxiao" Rect:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
//    [sheet show];
    
    [self.requestListModel.cellClickSubject subscribeNext:^(id x) {
        @strongify(self);
        CustomActionSheet * sheet = [[CustomActionSheet alloc]initWithTitle:nil OtherButtons:@[@"1",@"2"] CancleButton:@"quxiao" Rect:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        [sheet show];
        
//        LKAuthorViewController * lvc = [[LKAuthorViewController alloc]initAuthorType:@"1"];
//        [self.navigationController pushViewController:lvc animated:YES];
//
//        return ;
        
        LKPictureModel * model = [[LKPictureModel alloc]init];
        model.picName = [NSString stringWithFormat:@"%@",x];
        
        
        //增
        [[LKPictureDBManager shareManager]insertDataWithAlumbName:@"id" withData:model];
        
        //删
//        [[LKPictureDBManager shareManager]deleteDataWithAlumbName:@"id" withData:model];
        
        LKPictureModel * model1 = [[LKPictureModel alloc]init];
        model1.picName = [NSString stringWithFormat:@"%@",@"123"];
        LKPictureModel * model2 = [[LKPictureModel alloc]init];
        model2.picName = [NSString stringWithFormat:@"%@",@"2"];
        NSMutableArray * array = [[NSMutableArray alloc]initWithObjects:model1,model2, nil];
        
        //迁移
//        [[LKPictureDBManager shareManager] deleteDataWithAlumbName:@"" withData:array insertToAlumbname:@""];
        
        //获取全部数据
//        NSArray * fetchArray = [[LKPictureDBManager shareManager]fetchAllAlumbName:@""];
//        DLog(@"array : %@",fetchArray);
        
        //存储图片
        DLog(@"LKPicturePath : %@",LKPicturePath);
        [[LKImageFileManager shareManager] saveImageToPicture:[UIImage imageNamed:@"home_highlight"] withImageName:@"home_highlight"];
        
        [[LKImageFileManager shareManager]deleteImageToPictureName:@"home_highlight"];
        
    }];
    
}
- (void)getCurrentLocation {
    
    @weakify(self);
    [LKLocationManager getResposeLocation:^(LKLocationModel *locationModel) {
        @strongify(self);
        if (locationModel == nil) {
            @weakify(self);
            [Dialog showCustomAlertViewWithTitle:@"提示" message:@"重新定位" firstButtonName:@"取消" secondButtonName:@"确定" dismissHandler:^(NSInteger index) {
                @strongify(self);
                if (index == 1) {
                    [self getCurrentLocation];
                }
            }];
        }else {
            DLog(@"地点 ：  %@",locationModel.name);
        }
    }];
}

/**  */
-(Class)tableCellClass
{
    return [LKHomeTableViewCell class];
}
//- (Class)dataSourceClass
//{
//    return [LKHomeListViewModel class];
//}
- (LKBaseTableViewModel*)createDataSource
{
    return self.requestListModel;
}


//lazy
-(LKHomeListViewModel *)requestListModel
{
    if (_requestListModel == nil) {
        _requestListModel = [[LKHomeListViewModel alloc]init];
    }
    return _requestListModel;
}


@end
