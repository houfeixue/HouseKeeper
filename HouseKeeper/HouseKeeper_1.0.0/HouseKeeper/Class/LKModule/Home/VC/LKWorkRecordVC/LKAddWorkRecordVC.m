//
//  LKAddWorkRecordVC.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/30.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKAddWorkRecordVC.h"
#import "LKAddWorkDescriptionItemView.h"
#import "LKAddPictureItemView.h"
#import "LKAddPictureView.h"
#import "LKAddWorkRecordBottomView.h"
#import "THPickerView.h"
#import "LKLocationManager.h"
#import "LKWorkRecordListModel.h"
#import "LKAddWorkRecordViewModel.h"
#import "LKAlumbsViewController.h"
#import "LKSelectViewModel.h"
#import "SDPhotoBrowser.h"
#import "UIControl+ButtonClickDelay.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface LKAddWorkRecordVC ()<LKAddWorkDescriptionItemViewDelegate,LKAddPictureItemViewDelegate,SDPhotoBrowserDelegate>
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) LKInputTextView *workTimeItem;
@property (nonatomic, strong) LKInputTextView *workCommunityItem;
@property (nonatomic, strong) LKInputTextView *workAddressItem;
@property (nonatomic, strong) LKInputTextView *workTypeItem;
@property (nonatomic, strong) LKInputTextView *workerNameItem;
@property (nonatomic, strong) LKAddWorkDescriptionItemView *workDescItem;
@property (nonatomic, strong) LKAddPictureItemView *pictureItem;
@property (nonatomic, strong) LKAddWorkRecordBottomView *bottomView;
@property (nonatomic, strong) NSMutableArray *workTypeArray;
@property (nonatomic, strong) THPickerView *areaPickerView;
@property (nonatomic, strong) THPickerView *timePickerView;
@property (nonatomic, strong) THPickerView *communityPickerView;
@property (nonatomic, strong) NSMutableArray *workTimeArray;

@property (nonatomic, strong) NSMutableArray *workCommunityArray;
@property (nonatomic, assign) CGFloat pictureViewHeight;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UIButton *rightBtn;

/** 当前选中数据 */
/** 选中的工作类别 */
@property (nonatomic, assign)__block NSInteger currentSelectWorkType;
/** 当前选择的工作时间 */
@property (nonatomic, copy)__block NSString *currentSelectWorkTime;
/** 当前选择的工作小区 ID */
@property (nonatomic, copy)__block NSString *currentSelectWorkCommunity;
/** 当前选择所有照片模型的数组 */
@property (nonatomic, strong) NSMutableArray *currentSelectPictureModelArray;
/** 当前选择的图片数组 */
@property (nonatomic, strong) NSMutableArray *selectPictureArray;

/** 当前选择小区的连接字符串 */
@property (nonatomic, copy) NSString *currentSelectPictureString;
@property (nonatomic, strong) LKAddWorkRecordViewModel *recordViewModel;
@property (nonatomic, strong) LKSelectViewModel *selectCommunityViewModel;

@property (nonatomic, assign) CGFloat systemKeyboardHeight;

@end

@implementation LKAddWorkRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];

    self.systemKeyboardHeight = 0;
    self.currentSelectPictureString = @"";
    self.currentSelectWorkCommunity = @"";
    NSString *leftBtnTitle = @"提交";
    if (self.isEdit) {
        leftBtnTitle = @"保存";
    }
    self.rightBtn = [self addRightNavButtonWithTitle:leftBtnTitle action:@selector(rightBtnClick)];
    self.rightBtn.acceptEventInterval = 2.0f;
    @weakify(self);
    [RACObserve(self.recordViewModel, saveWorkRecordBtnEnable) subscribeNext:^(id  _Nullable enabled) {
        @strongify(self);
        self.rightBtn.enabled = [enabled boolValue];
    }];
    
    self.pictureViewHeight = 150.0f;
    self.workTimeArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 24; i ++ ) {
        NSMutableDictionary *hourDict = [NSMutableDictionary dictionary];
        [hourDict setObject:[NSString stringWithFormat:@"%.2ld",(long)i] forKey:@"name"];
        NSMutableArray *minuteArray = [NSMutableArray array];
        for (NSInteger j = 0; j < 60 ; j ++ ) {
            NSMutableDictionary *minuteDict = [NSMutableDictionary dictionary];
            [minuteDict setObject:[NSString stringWithFormat:@"%.2ld",(long)j] forKey:@"name"];
            [minuteArray addObject:minuteDict];
            
        }
        [hourDict setObject:minuteArray forKey:@"data"];
        [self.workTimeArray addObject:hourDict];
    }
    self.workTypeArray = [NSMutableArray arrayWithObjects:@"保安",@"保洁",@"消防",@"其他", nil];
    self.itemHeight = 50.0f;
    [self createUI];
    [self bindData];
    [self bindViewModelData];
    [self loadCommunityDataAndShowPicker:NO];
}
#pragma mark - Datasource
- (void)bindViewModelData {
    @weakify(self);
    [self.recordViewModel.addWorkRecordSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [LKCustomMethods showWindowMessage:@"提交成功"];
        if ([self.delegate respondsToSelector:@selector(LKAddWorkRecordVCDelegateRefreshUI)]) {
            [self.delegate LKAddWorkRecordVCDelegateRefreshUI];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.recordViewModel.updateWorkRecordSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [LKCustomMethods showWindowMessage:@"编辑成功"];
        if ([self.delegate respondsToSelector:@selector(LKAddWorkRecordVCDelegateRefreshUI)]) {
            [self.delegate LKAddWorkRecordVCDelegateRefreshUI];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.recordViewModel.deleteWorkRecordSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [LKCustomMethods showWindowMessage:@"删除成功"];
        if ([self.delegate respondsToSelector:@selector(LKAddWorkRecordVCDelegateRefreshUI)]) {
            [self.delegate LKAddWorkRecordVCDelegateRefreshUI];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
/** 查看工作记录的时候先绑定数据 */
- (void)bindData {
    if (self.listModel != nil) { /** 编辑页面 */
        /** 工作时间 */
        if ([LKCustomTool isBlankString:self.listModel.createTimeM] == NO) {
            NSArray *timeArray =[self.listModel.createTimeM componentsSeparatedByString:@" "] ;
            if (timeArray.count == 2) {
                NSString *time = [timeArray objectAtIndex:1];
                if (time.length >= 5) {
                    self.workTimeItem.textField.text = [time substringToIndex:5];
                }
            }
            self.currentSelectWorkTime = self.listModel.createTimeM;
        }
        /** 工作地点 */
        if ([LKCustomTool isBlankString:self.listModel.workPosition] == NO) {
            self.workAddressItem.textField.text = self.listModel.workPosition;
        }
        /** 工作类别 */
        NSInteger workTypeIndex = self.listModel.workType - 1 >= 0 ? self.listModel.workType - 1 : 0;
        self.workTypeItem.textField.text = [self.workTypeArray objectAtIndex:workTypeIndex];
        self.currentSelectWorkType = self.listModel.workType;
        /** 员工用本地的，didLoad已赋值 */
        /** 工作描述 */
        if ([LKCustomTool isBlankString:self.listModel.workDesc] == NO) {
            [self.workDescItem bindWorkDescriptionData:self.listModel.workDesc];
            self.workDescItem.textView.userInteractionEnabled = NO;
            [self.workDescItem.textView resignFirstResponder];
        }
        /** 工作照片 */
        if (self.listModel.urls != nil && self.listModel.urls.count > 0) {
            [self.pictureItem bindPictureData:[self.listModel.urls mutableCopy] titleName:@"工作照片"];
            self.currentSelectPictureModelArray = [NSMutableArray arrayWithArray:self.listModel.urls];
        }else {
            [self.pictureItem bindPictureData:[NSMutableArray array] titleName:@"工作照片"];
            self.currentSelectPictureModelArray = [NSMutableArray array];
        }
        [self editStatusChangeEnable:NO];
    }else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
        [dateFormatter setTimeZone:timeZone];
        self.workTimeItem.textField.text = [dateFormatter stringFromDate:[NSDate date]];
        self.currentSelectWorkTime = [NSString stringWithFormat:@"%@ %@",self.workDate,self.workTimeItem.textField.text];
    }
    [self.view endEditing:YES];
}
- (void)loadCommunityDataAndShowPicker:(BOOL)isShowCommunityPicker {
    LKUserInfoModel *model = [LKCustomMethods readUserInfo];
    NSString *userId = @"";
    if (model != nil) {
        userId = [NSString stringWithFormat:@"%d",model.userId];
    }
    self.selectCommunityViewModel.requestUrl = LKGetCommunity;
    self.selectCommunityViewModel.requestDict = @{@"customerId":userId};
    @weakify(self);
    [self.selectCommunityViewModel.cellClickSubject subscribeNext:^(NSDictionary *  _Nullable communityDict) {
        @strongify(self);
        NSArray *communitArray = [LKCommityModel mj_objectArrayWithKeyValuesArray:[communityDict objectForKey:@"data"]];
        self.workCommunityArray = [NSMutableArray arrayWithArray:communitArray];
        if (isShowCommunityPicker == YES) {
            [self handleCommunity];
        }else {
            if (self.listModel != nil && self.listModel.communityId != nil ) {
                self.currentSelectWorkCommunity = @"0";
                for (NSInteger i = 0; i < self.workCommunityArray.count; i ++ ) {
                    LKCommityModel *model = [self.workCommunityArray objectAtIndex:i];
                    if ([model.Id isEqualToNumber:self.listModel.communityId]) {
                        self.currentSelectWorkCommunity = [NSString stringWithFormat:@"%ld",(long)i];
                        self.workCommunityItem.textField.text = model.name;
                        break;
                    }
                }
            }
        }
    }];
}
#pragma mark - Action
/** 保存按钮 */
- (void)rightBtnClick {
    [self.view endEditing:YES];
    if ([self checkWorkRecordInputFinish] == YES) {
        /** 请求保存成功 */
        if (self.isEdit) {
            self.recordViewModel.requestTag = 2;
            self.recordViewModel.requestUrl = LKUpdateWorkRecord;
        }else {
            self.recordViewModel.requestTag = 1;
            self.recordViewModel.requestUrl = LKAddWorkRecord;
        }
        [self imageDataHandle];
    }
}
/** 返回按钮点击事件 */
- (void)backAction:(id)sender {
    if (self.isEdit) { /** 编辑的时候，判断是否修改 */
        if (self.listModel != nil) {
            NSString *currentTime = [NSString stringWithFormat:@"%@ %@",self.workDate,self.workTimeItem.textField.text];
            if (![currentTime isEqualToString:self.listModel.createTimeM]) {
                [self showAlertSave];
                return;
            }
            if (self.listModel.communityId != nil) { /** 兼容以前没有小区id */
                NSNumber *currentCommunityId = ((LKCommityModel *)([self.workCommunityArray objectAtIndex:[self.currentSelectWorkCommunity integerValue]])).Id;
                if (![currentCommunityId isEqualToNumber:self.listModel.communityId]) {
                    [self showAlertSave];
                    return;
                }
            }
            if (![self.listModel.workPosition isEqualToString:self.workAddressItem.textField.text]) {
                [self showAlertSave];
                return;
            }
            if (self.currentSelectWorkType != self.listModel.workType) {
                [self showAlertSave];
                return;
            }
            if (![self.workDescItem.textView.text isEqualToString:self.listModel.workDesc]) {
                [self showAlertSave];
                return;
            }
            NSMutableArray *pictureArray = [NSMutableArray array];
            for (LKPictureModel *pictureModel in self.listModel.urls) {
                [pictureArray addObject:[NSString stringWithFormat:@"%@",pictureModel.picName]];
            }
            NSMutableArray *pictureArray2 = [NSMutableArray array];
            for (LKPictureModel *pictureModel in self.pictureItem.pictureArray) {
                [pictureArray2 addObject:[NSString stringWithFormat:@"%@",pictureModel.picName]];
            }
            if (![self judgeArrayEqualFirstArray:pictureArray secondArray:pictureArray2]) {
                [self showAlertSave];
                return;
            }
        }
    }
    [super backAction:sender];
}

- (BOOL)judgeArrayEqualFirstArray:(NSArray *)firstArray secondArray:(NSArray *)secondArray {
    if (firstArray.count != secondArray.count) {
        return NO;
    }
    for (NSString *str in firstArray) {
        if (![secondArray containsObject:str]) {
            return NO;
        }
    }
    return YES;
}
- (void)showAlertSave {
    [Dialog showCustomAlertViewWithTitle:@"提示" message:@"修改了信息还未保存，确认现在返回吗？" firstButtonName:@"取消" firstButtonColor:LKLightGrayColor secondButtonName:@"确定" secondButtonColor:LKCrownColor dismissHandler:^(NSInteger index) {
        if (index == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
- (void)submitDictData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *userId = [NSString stringWithFormat:@"%d",[LKCustomMethods readUserInfo].userId];
    [params setObject:userId forKey:@"managerId"];
    [params setObject:[NSString stringWithFormat:@"%ld",(long)self.currentSelectWorkType] forKey:@"workType"];
    if (self.listModel != nil) {
        if (self.listModel.workItemId != 0) {
            [params setObject:[NSString stringWithFormat:@"%d",self.listModel.workItemId] forKey:@"workItemId"];
        }
    }
    LKCommityModel *model = [self.workCommunityArray objectAtIndex:[self.currentSelectWorkCommunity integerValue]];
    [params setObject:model.Id forKey:@"communityId"];
    [params setObject:self.workAddressItem.textField.text forKey:@"workPosition"];
    [params setObject:self.workDescItem.textView.text forKey:@"workDesc"];
    [params setObject:self.currentSelectWorkTime forKey:@"time"];
    [params setObject:self.currentSelectPictureString forKey:@"urls"];
    self.recordViewModel.requestDict = params;
}
- (void)imageDataHandle {
    self.selectPictureArray = [NSMutableArray array];
    [self.pictureItem.pictureViewArray enumerateObjectsUsingBlock:^(LKAddPictureView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.selectPictureArray addObject:obj.imageView.image];
    }];
    NSMutableArray *tempLocalImageArray = [NSMutableArray array];
    NSMutableArray *tempNetPicArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.currentSelectPictureModelArray.count; i ++ ) {
        LKPictureModel *model = [self.currentSelectPictureModelArray objectAtIndex:i];
        if ([model.picName hasPrefix:LKCompoundPicturePath]) {
            [tempLocalImageArray addObject:[self.selectPictureArray objectAtIndex:i]];
        }else {
            [tempNetPicArray addObject:model.picName];
        }
    }
    if (tempLocalImageArray.count > 0) {
        /** 上传图片服务器 */
        [self uploadImageData:tempLocalImageArray netPictureArray:tempNetPicArray];
    }else {
        self.currentSelectPictureString = [tempNetPicArray componentsJoinedByString:@","];
        [self submitDictData];
    }
}
- (void)uploadImageData:(NSMutableArray *)imageArray netPictureArray:(NSMutableArray *)netPictureArray {
    NSDictionary * dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"app",@"sign", nil];
    [LKCustomMethods showMBMBHUBView:self.view];
    [LKHttpImageRequest uploadImageWithPath:LKUploadimg photos:imageArray params:dict success:^(id Json) {
        [LKCustomMethods hideMBMBHUBView:self.view];
        if ([[Json numberForKey:@"status"] isEqualToNumber:@(1)]) {
           id data =  [LKCustomMethods objectWithJsonString:[LKEntcry decryptAES:[Json objectForKey:@"data"]]];
           if ([data isKindOfClass:[NSArray class]]) {
               NSArray * array = (NSArray *)data;
               NSString * localPictureString = @"";
               for (int i = 0; i < array.count; i++) {
                   NSString * imageStr = [array objectAtIndex:i];
                   if ([imageStr hasSuffix:@".jpg"]) {
                       if ([LKCustomTool isBlankString:localPictureString] == YES) {
                           localPictureString = imageStr;
                       }else{
                           localPictureString = [NSString stringWithFormat:@"%@,%@",localPictureString,imageStr];
                       }
                   }
               }
               NSString *netPictureString = @"";
               if (netPictureArray.count > 0) {
                   netPictureString = [netPictureArray componentsJoinedByString:@","];
                   self.currentSelectPictureString = [NSString stringWithFormat:@"%@,%@",netPictureString,localPictureString];
               }else {
                   self.currentSelectPictureString = localPictureString;
               }
               [self submitDictData];
           }
        }else {
            [LKCustomMethods showWindowMessage:[Json objectForKey:@"msg"]];
        }
    } failure:^{
        [LKCustomMethods hideMBMBHUBView:self.view];
        [LKCustomMethods showWindowMessage:@"网络连接失败，请稍后重试"];
    }];
}
/** 删除编辑 */
- (void)bottomViewAction {
    @weakify(self);
    [[self.bottomView.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [Dialog showCustomAlertViewWithTitle:@"提示" message:@"确认删除该记录？" firstButtonName:@"取消" firstButtonColor:LKLightGrayColor secondButtonName:@"确定" secondButtonColor:LKCrownColor dismissHandler:^(NSInteger index) {
            if (index == 1) {
                /** 请求接口删除该条工作记录，回调刷新列表数据 */
                self.recordViewModel.requestTag = 3;
                self.recordViewModel.requestUrl = LKDeleteWorkRecord;
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                [params setObject:[NSString stringWithFormat:@"%d",self.listModel.workItemId] forKey:@"workItemId"];
                NSString *userId = [NSString stringWithFormat:@"%d",[LKCustomMethods readUserInfo].userId];
                [params setObject:userId forKey:@"managerId"];
                self.recordViewModel.requestDict = params;
            }
        }];
    }];
    /** 编辑 */
    [[self.bottomView.editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.navigationItem.rightBarButtonItem == nil) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
            [self.pictureItem reRefreshPictureView];
            [self editStatusChangeEnable:YES];
            [self setNavBarTitle:@"编辑工作记录"];
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(0);
                make.bottom.equalTo(self.view).inset(kSafeAreaBottomHeight);
            }];
        }
    }];
}
- (void)showAreaPickerView {
    [self.view endEditing:YES];
    @weakify(self);
    [self.areaPickerView showConfirmBlock:^(NSArray<NSString *> *indexArray) {
        @strongify(self);
        for (NSString *index in indexArray) {
            self.currentSelectWorkType = [index integerValue] + 1;
            self.workTypeItem.textField.text = [self.workTypeArray objectAtIndex:[index integerValue]];
        }
    }];
}
- (void)showTimePickerView {
    [self.view endEditing:YES];
    if (self.isEdit == NO) {
        NSInteger selectFirstRow = 0;
        NSInteger selectSecondRow = 0;
        if ([LKCustomTool isBlankString:self.currentSelectWorkTime] == NO) {
            NSArray *dateArray = [self.currentSelectWorkTime componentsSeparatedByString:@" "];
            if (dateArray.count >= 2 ) {
                NSArray *timeArray = [[dateArray objectAtIndex:1] componentsSeparatedByString:@":"];
                if (timeArray.count >= 2) {
                    NSString *hour = [timeArray objectAtIndex:0];
                    NSString *minute = [timeArray objectAtIndex:1];
                    if ([hour integerValue] >=0 && [hour integerValue] < 24 ) {
                        selectFirstRow = [hour integerValue];
                    }
                    if ([minute integerValue] >= 0 && [minute integerValue] < 60) {
                        selectSecondRow = [minute integerValue];
                    }
                }
            }
        }
        [self.timePickerView.pickerView selectRow:selectFirstRow inComponent:0 animated:NO];
        [self.timePickerView.pickerView selectRow:selectSecondRow inComponent:1 animated:NO];
        [self.timePickerView.pickerView reloadAllComponents];
    }
    @weakify(self);
    [self.timePickerView showConfirmBlock:^(NSArray<NSString *> *indexArray) {
        @strongify(self);
        if (indexArray.count >=2) {
            NSInteger firstComponents = [[indexArray objectAtIndex:0] integerValue];
            NSInteger secondComponents = [[indexArray objectAtIndex:1] integerValue];
            NSString *hour = [[self.workTimeArray objectAtIndex:firstComponents] objectForKey:@"name"];
            NSString *minute = [[[[self.workTimeArray objectAtIndex:firstComponents] objectForKey:@"data"] objectAtIndex:secondComponents] objectForKey:@"name"];
            NSString *workTime = [NSString stringWithFormat:@"%@:%@",hour,minute];
            self.workTimeItem.textField.text = workTime;
            /** 加上年月日 */
            self.currentSelectWorkTime = [NSString stringWithFormat:@"%@ %@",self.workDate,workTime];
        }
    }];
}
- (void)showWorkCommunityPickerView {
    [self.view endEditing:YES];
    if (self.workCommunityArray.count == 0) {
        [self loadCommunityDataAndShowPicker:YES];
    }else {
        [self handleCommunity];
    }
}
- (void)handleCommunity {
    NSMutableArray *communityNameArray = [NSMutableArray array];
    for (LKCommityModel *model in self.workCommunityArray) {
        [communityNameArray addObject:model.name];
    }
    self.communityPickerView = [[THPickerView alloc] initWithDataKey:@"data" AndDataArray:communityNameArray AndTestKey:@"name" AndNumberOfComponents:1];
    self.communityPickerView.titleLabel.text = @"工作小区";
    [self communityPickerViewHandle];
}
- (void)communityPickerViewHandle {
    @weakify(self);
    [self.communityPickerView showConfirmBlock:^(NSArray<NSString *> *indexArray) {
        @strongify(self);
        for (NSString *index in indexArray) {
            self.currentSelectWorkCommunity = index;
            LKCommityModel *model = [self.workCommunityArray objectAtIndex:[self.currentSelectWorkCommunity integerValue]];
            self.workCommunityItem.textField.text = model.name;
        }
    }];
}
- (void)editStatusChangeEnable:(BOOL)editing {
    if (editing == YES) {
        self.workTimeItem.nextBtn.enabled = YES;
        self.workCommunityItem.nextBtn.enabled = YES;
        self.workAddressItem.textField.enabled = YES;
        self.workTypeItem.nextBtn.enabled = YES;
        self.workDescItem.userInteractionEnabled = YES;
        self.workDescItem.textView.userInteractionEnabled = YES;
    }else {
        self.workTimeItem.nextBtn.enabled = NO;
        self.workCommunityItem.nextBtn.enabled = NO;
        self.workAddressItem.textField.enabled = NO;
        self.workTypeItem.nextBtn.enabled = NO;
        self.workDescItem.userInteractionEnabled = NO;
        self.workDescItem.textView.userInteractionEnabled = NO;
    }
}
#pragma mark - UI
- (void)createUI {
    [self setNavBarTitle:@"工作记录"];
    [self createBottomAndScrollView];
    [self createItemView];
}
- (void)createBottomAndScrollView {
    [self.view addSubview:self.bgScrollView];
    if (self.isEdit) {
        [self.view addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(50);
            make.bottom.equalTo(self.view).inset(kSafeAreaBottomHeight);
        }];
        [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.bottom.equalTo(self.bottomView.mas_top);
        }];
        [self bottomViewAction];
        [self.pictureItem hiddenPictureDeteleBtn];
        self.navigationItem.rightBarButtonItem = nil;
        [self.view layoutIfNeeded];
        CGFloat maxHeight = CGRectGetMaxY(self.pictureItem.frame);
        if (maxHeight > kScreen_Height - kStatusBarHeight -kNavBarHeight - 50 - kSafeAreaBottomHeight) {
            self.bgScrollView.contentSize = CGSizeMake(kScreen_Width, maxHeight);
        }else {
            self.bgScrollView.contentSize = CGSizeMake(kScreen_Width, kScreen_Height - kStatusBarHeight -kNavBarHeight - 50 - kSafeAreaBottomHeight + 1);
        }
    }else {
        [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
        self.locationManager = [LKLocationManager sharedLKLocationManager].locationManager;
        [LKLocationManager getResposeLocation:^(LKLocationModel *locationModel) {
            if (locationModel != nil) {
                self.workAddressItem.textField.text = [NSString stringWithFormat:@"%@%@%@",locationModel.currentCity,locationModel.subLocality,locationModel.name];
            }
        }];
        [self.view layoutIfNeeded];
        CGFloat maxHeight = CGRectGetMaxY(self.pictureItem.frame);
        if (maxHeight > kScreen_Height - kStatusBarHeight -kNavBarHeight ) {
            self.bgScrollView.contentSize = CGSizeMake(kScreen_Width, maxHeight);
        }else {
            self.bgScrollView.contentSize = CGSizeMake(kScreen_Width, kScreen_Height - kStatusBarHeight -kNavBarHeight + 1);
        }
    }
}
- (void)createItemView {
    [self.bgScrollView addSubview:self.workTimeItem];
    [self.workTimeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(self.itemHeight);
    }];
    [self.workTimeItem bindDataWithText:@"工作时间" TextFont:LK_14font TextColor:LKGrayColor placeholder:@"请选择工作时间" textFieldText:@"" textFieldCanEdit:NO isShowNextBtn:YES];
    /** 选择工作时间 */
    @weakify(self);
    [[self.workTimeItem.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self showTimePickerView];
    }];
    [self.bgScrollView addSubview:self.workCommunityItem];
    [self.workCommunityItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.workTimeItem.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(self.itemHeight);
    }];
    [self.workCommunityItem bindDataWithText:@"工作小区" TextFont:LK_14font TextColor:LKGrayColor placeholder:@"请选择工作小区" textFieldText:@"" textFieldCanEdit:NO isShowNextBtn:YES];
    /** 选择工作小区 */
    [[self.workCommunityItem.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self showWorkCommunityPickerView];
    }];
    [self.bgScrollView addSubview:self.workAddressItem];
    [self.workAddressItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.workCommunityItem.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(self.itemHeight);
    }];
    [[self.workAddressItem.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        
        NSString *lang = self.workAddressItem.textField.textInputMode.primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) {
            UITextRange *selectedRange = [self.workAddressItem.textField markedTextRange];
            UITextPosition *position = [self.workAddressItem.textField positionFromPosition:selectedRange.start offset:0];
            if (!position) {
                if (x.length >= 32) {
                    x = [x substringToIndex:32];
                    self.self.workAddressItem.textField.text = x;
                }
            }
        }else {
            if (x.length >= 32) {
                x = [x substringToIndex:32];
                self.self.workAddressItem.textField.text = x;
            }
        }
    }];
    [self.workAddressItem bindDataWithText:@"工作地点" TextFont:LK_14font TextColor:LKGrayColor placeholder:@"请输入您的工作地点" textFieldText:@"" textFieldCanEdit:YES isShowNextBtn:NO];
    [self.bgScrollView addSubview:self.workTypeItem];
    [self.workTypeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.workAddressItem.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(self.itemHeight);
    }];
    [self.workTypeItem bindDataWithText:@"工作类别" TextFont:LK_14font TextColor:LKGrayColor placeholder:@"请选择工作类别" textFieldText:@"" textFieldCanEdit:NO isShowNextBtn:YES];
    /** 选择工作类别  */
    [[self.workTypeItem.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self showAreaPickerView];
    }];
    [self.bgScrollView addSubview:self.workerNameItem];
    [self.workerNameItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.workTypeItem.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(self.itemHeight);
    }];
    LKUserInfoModel *userModel = [LKCustomMethods readUserInfo];
    NSString *userName = @"";
    if (userModel != nil && [LKCustomTool isBlankString:userModel.name] == NO) {
        userName = userModel.name;
    }
    [self.workerNameItem bindDataWithText:@"员工姓名" TextFont:LK_14font TextColor:LKGrayColor placeholder:@"请输入员工姓名" textFieldText:userName textFieldCanEdit:NO isShowNextBtn:NO];
    [self.bgScrollView addSubview:self.workDescItem];
    [self.workDescItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.workerNameItem.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(self.itemHeight);
    }];
    [self.bgScrollView addSubview:self.pictureItem];
    [self.pictureItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.workDescItem.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(self.pictureViewHeight);
        make.bottom.equalTo(self.bgScrollView.mas_bottom).inset(20);
    }];
}
#pragma mark - workDesc
- (void)LKAddWorkDescriptionItemViewDelegateViewHeight:(CGFloat)viewHeight {
    [self.workDescItem mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.workerNameItem.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(viewHeight);
    }];
    [self.pictureItem mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.workDescItem.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(self.pictureViewHeight);
        make.bottom.equalTo(self.bgScrollView.mas_bottom).inset(20);
    }];
    [self.workDescItem layoutIfNeeded];
    CGRect frame = [[UIApplication sharedApplication].keyWindow convertRect:self.workDescItem.frame fromView:self.bgScrollView];
    if (CGRectGetMaxY(frame) + self.systemKeyboardHeight > kScreen_Height ) {
        [self.bgScrollView setContentOffset:CGPointMake(0, viewHeight - 50)];
    }
}
#pragma mark - LKSelectPicturesViewControllerDelegate
- (void)selectPicturesArray:(NSArray *)imageArray {
    [self.currentSelectPictureModelArray addObjectsFromArray:imageArray];
    for (LKPictureModel *model in imageArray) {
        [self.pictureItem.pictureArray addObject:model];
    }
    [self.pictureItem reRefreshPictureView];
}
#pragma mark - pictViewDelegate
- (void)LKAddPictureItemViewDelegateViewHeight:(CGFloat)pictureViewHeight {
    [self.view endEditing:YES];
    if (pictureViewHeight < 150) {
        pictureViewHeight = 150;
    }
    self.pictureViewHeight = pictureViewHeight;
    [self.pictureItem mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.workDescItem.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(pictureViewHeight);
        make.bottom.equalTo(self.bgScrollView.mas_bottom).inset(20);
    }];
    [self.bgScrollView layoutIfNeeded];
}
/** 选择照片 */
- (void)LKAddPictureItemViewDelegateSelectPictureIndex:(NSInteger)pictureIndex {
    [self.view endEditing:YES];
    LKAlumbsViewController *vc = [[LKAlumbsViewController alloc] init];
    vc.type = @"select";
    vc.selectCount = 9 - self.pictureItem.pictureArray.count;
    vc.formVC = self;
    [self.navigationController pushViewController:vc animated:YES];
}
/** 删除照片 */
- (void)LKAddPictureItemViewDelegatetureDeletePicture:(NSInteger)pictureIndex {
    [self.currentSelectPictureModelArray removeObjectAtIndex:pictureIndex];
}
/** 查看照片 */
- (void)LKAddPictureItemViewDelegatetureCheckBigPicture:(NSInteger)pictureIndex pictureView:(LKAddPictureView *)pictureView imageArray:(NSMutableArray *)imageArray {
    self.selectPictureArray = imageArray;
    SDPhotoBrowser *photoBrowser = [[SDPhotoBrowser alloc] init];
    photoBrowser.sourceImagesContainerView = self.pictureItem.pictureBgView;
    photoBrowser.imageCount = imageArray.count;
    photoBrowser.currentImageIndex = pictureIndex;
    photoBrowser.delegate = self;
    [photoBrowser show];
}
#pragma mark - photoBrowser
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return [self.selectPictureArray objectAtIndex:index];
}
#pragma mark - 键盘高度处理
- (void)keyboardWillShow:(NSNotification *)notification {
    if (self.workDescItem.textView.isFirstResponder == YES) {
        self.systemKeyboardHeight = [[notification.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height + 44 ;
        [self.workDescItem layoutIfNeeded];
        CGRect frame = [[UIApplication sharedApplication].keyWindow convertRect:self.workDescItem.frame fromView:self.bgScrollView];
        if (CGRectGetMaxY(frame) + self.systemKeyboardHeight  > kScreen_Height ) {
            [self.bgScrollView setContentOffset:CGPointMake(0, self.workDescItem.height - 50)];
        }
    }
}

- (void)keyboardWillHidden:(NSNotification *)notify {
    self.systemKeyboardHeight = 0;
}

#pragma mark - 判断输入
- (BOOL)checkWorkRecordInputFinish {
    if ([LKCustomTool isBlankString:self.workTimeItem.textField.text]) {
        [LKCustomMethods showWindowMessage:@"请选择工作时间"];
        return NO;
    }
    if ([LKCustomTool isBlankString:self.workCommunityItem.textField.text]) {
        [LKCustomMethods showWindowMessage:@"请选择工作小区"];
        return NO;
    }
    if ([LKCustomTool isBlankString:self.workAddressItem.textField.text]) {
        [LKCustomMethods showWindowMessage:@"请输入工作地点"];
        return NO;
    }
    if ([LKCustomTool isBlankString:self.workTypeItem.textField.text]) {
        [LKCustomMethods showWindowMessage:@"请选择工作类别"];
        return NO;
    }
    if ([LKCustomTool isBlankString:self.workDescItem.textView.text]) {
        [LKCustomMethods showWindowMessage:@"请输入工作事件"];
        return NO;
    }
    return YES;
}
#pragma mark - lazy
- (UIScrollView *)bgScrollView {
    if (_bgScrollView == nil) {
        _bgScrollView = [[UIScrollView alloc] init];
    }
    return _bgScrollView;
}
- (LKInputTextView *)workTimeItem {
    if (_workTimeItem == nil) {
        _workTimeItem = [[LKInputTextView alloc] init];
    }
    return _workTimeItem;
}
- (LKInputTextView *)workCommunityItem {
    if (_workCommunityItem == nil) {
        _workCommunityItem = [[LKInputTextView alloc] init];
    }
    return _workCommunityItem;
}
- (LKInputTextView *)workAddressItem {
    if (_workAddressItem == nil) {
        _workAddressItem = [[LKInputTextView alloc] init];
    }
    return _workAddressItem;
}
- (LKInputTextView *)workTypeItem {
    if (_workTypeItem == nil) {
        _workTypeItem = [[LKInputTextView alloc] init];
    }
    return _workTypeItem;
}
- (LKInputTextView *)workerNameItem {
    if (_workerNameItem == nil) {
        _workerNameItem = [[LKInputTextView alloc] init];
    }
    return _workerNameItem;
}
- (LKAddWorkDescriptionItemView *)workDescItem {
    if (_workDescItem == nil) {
        _workDescItem = [[LKAddWorkDescriptionItemView alloc] init];
        _workDescItem.delegate = self;
        _workDescItem.titleLabel.text = @"工作事件";
        _workDescItem.textView.wzb_placeholder = @"请描述工作事件";
    }
    return _workDescItem;
}
- (LKAddPictureItemView *)pictureItem {
    if (_pictureItem == nil) {
        _pictureItem = [[LKAddPictureItemView alloc] init];
        _pictureItem.delegate = self;
    }
    return _pictureItem;
}
- (LKAddWorkRecordBottomView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[LKAddWorkRecordBottomView alloc] init];
    }
    return _bottomView;
}
- (THPickerView *)areaPickerView {
    if (_areaPickerView == nil) {
        _areaPickerView =[[THPickerView alloc] initWithDataKey:@"datas" AndDataArray:self.workTypeArray AndTestKey:@"test" AndNumberOfComponents:1];
        _areaPickerView.titleLabel.text = @"工作类别";
    }
    return _areaPickerView;
}
- (THPickerView *)timePickerView {
    if (_timePickerView == nil) {
        _timePickerView =[[THPickerView alloc] initWithDataKey:@"data" AndDataArray:self.workTimeArray AndTestKey:@"name" AndNumberOfComponents:2];
        _timePickerView.titleLabel.text = @"工作时间";
    }
    return _timePickerView;
}
- (NSMutableArray *)currentSelectPictureModelArray {
    if (_currentSelectPictureModelArray == nil) {
        _currentSelectPictureModelArray = [NSMutableArray array];
    }
    return _currentSelectPictureModelArray;
}
- (LKAddWorkRecordViewModel *)recordViewModel {
    if (_recordViewModel == nil) {
        _recordViewModel = [[LKAddWorkRecordViewModel alloc] init];
    }
    return _recordViewModel;
}
- (LKSelectViewModel *)selectCommunityViewModel {
    if (_selectCommunityViewModel == nil) {
        _selectCommunityViewModel = [[LKSelectViewModel alloc] init];
    }
    return _selectCommunityViewModel;
}
- (NSMutableArray *)workCommunityArray {
    if (_workCommunityArray == nil) {
        _workCommunityArray = [NSMutableArray array];
    }
    return _workCommunityArray;
}
- (NSMutableArray *)selectPictureArray {
    if (_selectPictureArray == nil) {
        _selectPictureArray = [NSMutableArray array];
    }
    return _selectPictureArray;
}
- (LKRequestViewModel *)createDataSource {
    return self.recordViewModel;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
@end
