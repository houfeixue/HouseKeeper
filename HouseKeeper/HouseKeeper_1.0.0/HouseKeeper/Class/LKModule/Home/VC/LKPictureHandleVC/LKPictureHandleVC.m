
//
//  LKPictureHandleVC.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/17.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPictureHandleVC.h"
#import "LKMergeView.h"
#import "LKPictureHandleBottomView.h"
#import "LKLocationManager.h"
#import "LKSelectClassityListView.h"

@interface LKPictureHandleVC ()<UITextViewDelegate>
@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UIImageView *pictureImageView;

@property (nonatomic, strong) LKPictureHandleBottomView *bottomView;

/** 当前定位位置 */
@property (nonatomic, copy)__block NSString *currentLocationAddress;
@property (nonatomic, strong)__block UIImage *currentSelectImage;
/** 时间戳 */
@property (nonatomic, copy)__block NSString *currentTime;
/** 相册列表 **/
@property (nonatomic, strong) LKSelectClassityListView *selectClassifyListView;
@property (nonatomic, copy) NSNumber *alumbSelectId;//** 相册Id*/

@property (nonatomic, strong) CLLocationManager *manager;
@end

@implementation LKPictureHandleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.alumbSelectId = @(0);
    if (self.picModel != nil) { /** 编辑图片 */
        NSString * imagePath = [NSString stringWithFormat:@"%@/%@",LKPicturePath,self.picModel.picName];
        self.currentSelectImage = [UIImage imageWithContentsOfFile:imagePath];
        if (self.currentSelectImage == nil) {
            self.currentSelectImage = [UIImage imageNamed:LKPicture_Default];
        }
        self.currentTime = self.picModel.time;
        self.currentLocationAddress = self.picModel.area;
        self.bottomView.textView.text = self.picModel.des;
        NSString *alumbName = @"默认";
        NSNumber *alumbID = @(0);
        if (self.alumbModel != nil) {
            alumbName =  [LKCustomTool isBlankString:self.alumbModel.name] == YES ? @"默认" :self.alumbModel.name;
            alumbID = self.alumbModel.categoryId;
        }
        self.bottomView.selectTypeLabel.text = alumbName;
        self.alumbSelectId = alumbID;
    }else {
        self.currentSelectImage = [self.pictureDict objectForKey:@"currentImage"];
        self.currentTime = [self.pictureDict objectForKey:@"currentTime"];
    }
    self.manager = [LKLocationManager sharedLKLocationManager].locationManager;
    [self getCurrentLocation:NO];
    [self createUI];
    self.pictureImageView.image = self.currentSelectImage;
}
- (void)getCurrentLocation:(BOOL)isRepeat {
    @weakify(self);
    if (isRepeat) {
        [LKCustomMethods showWindowMessage:@"正在定位"];
    }
    [LKLocationManager getResposeLocation:^(LKLocationModel *locationModel) {
        /** 结束菊花转圈 */
        @strongify(self);
        if (locationModel == nil) {
            @weakify(self);
            if (isRepeat) {
                [Dialog showCustomAlertViewWithTitle:@"温馨提示" message:@"请确定重新定位打开，再次定位" firstButtonName:@"取消" secondButtonName:@"确定" dismissHandler:^(NSInteger index) {
                    @strongify(self);
                    if (index == 1) {
                        [self getCurrentLocation:isRepeat];
                    }
                }];
            }
        }else {
            self.currentLocationAddress = [NSString stringWithFormat:@"%@%@%@",locationModel.currentCity,locationModel.subLocality,locationModel.name];
        }
    }];
}
- (void)createUI {
    [self addRightNavButtonWithTitle:@"保存" action:@selector(savePicture)];
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.bgScrollView addSubview:self.pictureImageView];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.bgScrollView);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(kScreen_Height - kStatusBarHeight - kNavBarHeight - 130);
        make.bottom.equalTo(self.bgScrollView.mas_bottom).inset(130);
    }];
    [self createBottomView];
}
- (void)createBottomView {
    [self.bgScrollView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.equalTo(self.bgScrollView.mas_right);
        make.width.mas_equalTo(kScreen_Width);
        make.bottom.equalTo(self.bgScrollView.mas_bottom);
    }];
    WS(weakSelf)
    self.bottomView.selectPictureType = ^{
        DLog(@"选择类型");
        [weakSelf.view endEditing:YES];
        //类别名称
        [weakSelf.view addSubview:weakSelf.selectClassifyListView];
        weakSelf.selectClassifyListView.currentAlumbId = weakSelf.alumbSelectId;
        [weakSelf.selectClassifyListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.view);
        }];
    };
}
#pragma mark - btnClick
/** 保存图片 */
- (void)savePicture {
    [self.view endEditing:YES];
    /** 保存图片  图片-时间-定位 -   描述（选填） */
    /** 1.定位 */
    if ([LKCustomTool isBlankString:self.currentLocationAddress] == YES) {
        [self getCurrentLocation:YES];
        return;
    }
    if (self.picModel != nil) { /** 编辑页面 */
        self.picModel.des = self.bottomView.textView.text;
        self.picModel.time = [NSString stringWithFormat:@"%@",self.currentTime];
        self.picModel.area = self.currentLocationAddress;
        BOOL insert =  [[LKPictureDBManager shareManager]deleteDataWithAlumbName:self.alumbModel.categoryId withData:@[self.picModel] insertToAlumbname:self.alumbSelectId];
        if (insert) {
            
            
            
////            //保存图片
////            -(void)saveImageToPicture:(UIImage *)image withImageName:(NSString *)imageName mergeModel:(LKPictureModel *)pictureModel;
////            //删除图片
////            -(void)deleteImageToPictureName:(NSString *)imageName;
//
//            [[LKImageFileManager shareManager] deleteNOJpgImageToPictureName:self.picModel.picName];
////            [[LKImageFileManager shareManager] deleteImageToPictureName:self.picModel.picName];
//            [[LKImageFileManager shareManager]saveImageToPicture:self.pictureImageView.image withImageName:self.picModel.picName mergeModel:self.picModel];
            
            
            [[LKImageFileManager shareManager]editCompoundToPictureName:self.picModel.picName withPictureModel:self.picModel withImage:self.pictureImageView.image];

            [LKCustomMethods showWindowMessage:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
            if (_pictureHandleBackClick) {
                self.pictureHandleBackClick(_alumbSelectId);
            }
            
        }else{
            [LKCustomMethods showWindowMessage:@"保存失败"];
        }
    }else { /** 直接保存数据 */
        LKPictureModel *model = [[LKPictureModel alloc]init];
        model.picName = @"";
        model.des = self.bottomView.textView.text;
        model.time = [NSString stringWithFormat:@"%@",self.currentTime];
        model.area = self.currentLocationAddress;
        model.image = self.currentSelectImage;
        BOOL insert =  [[LKPictureDBManager shareManager]insertDataWithAlumbName:[NSString stringWithFormat:@"%@",_alumbSelectId] withData:model];
        if (insert) {
            [LKCustomMethods showWindowMessage:@"保存成功" delayTime:1 dismissHandle:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LKPictureHandleVCFinishShowCamera" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [LKCustomMethods showWindowMessage:@"保存失败"];
        }
    }
}
- (void)backAction:(id)sender {
    if (self.picModel == nil) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LKPictureHandleVCFinishShowCamera" object:nil];
    }
    [super backAction:sender];
}
#pragma mark - lazy
- (UIImageView *)pictureImageView {
    if (_pictureImageView == nil) {
        _pictureImageView = [[UIImageView alloc] init];
        _pictureImageView.contentMode = UIViewContentModeScaleAspectFit;
        _pictureImageView.userInteractionEnabled = YES;
        _pictureImageView.backgroundColor = LKF2Color;
    }
    return _pictureImageView;
}
- (LKPictureHandleBottomView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[LKPictureHandleBottomView alloc] init];
    }
    return _bottomView;
}
- (UIScrollView *)bgScrollView {
    if (_bgScrollView == nil) {
        _bgScrollView = [[UIScrollView alloc] init];
    }
    return _bgScrollView;
}

-(LKSelectClassityListView *)selectClassifyListView {
    if (_selectClassifyListView == nil) {
        _selectClassifyListView = [[LKSelectClassityListView alloc]initWithType:@"1"];
        _selectClassifyListView.currentAlumbId = _alumbSelectId;
        WS(weakSelf)
        _selectClassifyListView.selectListClick = ^(LKAlumbModel *model) {
            DLog(@"selectListClick : %@",model);
            weakSelf.bottomView.selectTypeLabel.text = model.name;
            weakSelf.alumbSelectId = model.categoryId;
            [weakSelf.selectClassifyListView removeFromSuperview];
        };
    }
    return _selectClassifyListView;
}
@end
