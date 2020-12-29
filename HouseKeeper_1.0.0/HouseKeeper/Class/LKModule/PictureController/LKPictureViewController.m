//
//  LKPictureViewController.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPictureViewController.h"
#import "LKPictureViewModel.h"
#import "LKPictureCell.h"
#import "LKPictureBottomView.h"
#import "LKPictureCliassifyView.h"
#import "LKSelectClassityListView.h"
#import "LKPIctureUploadManager.h"

@interface LKPictureViewController ()
@property (nonatomic, strong) LKPictureViewModel *pictureViewModel;
@property (nonatomic, strong) LKPictureBottomView *pictureBottomView;
@property (nonatomic, strong) LKPictureCliassifyView *pictureCliassifyView;
@property (nonatomic, strong) LKSelectClassityListView *selectClassifyListView;
@property (nonatomic, assign)BOOL isImageSelectAll;//图片是否选择全部

@property (nonatomic, assign)NSInteger imageSelecCount;//图片选择个数


@end

@implementation LKPictureViewController
#pragma mark - create base views=---重写
//设置代理
- (LKBaseCollectionViewModel*)createDataSource
{
    return self.pictureViewModel;
    
}
- (UICollectionViewFlowLayout*)createLayOut
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width-2*6)/3,(kScreen_Width-2*6)/3);
    layout.minimumLineSpacing = 6;
    layout.minimumInteritemSpacing = 6;
    layout.headerReferenceSize = CGSizeMake(kScreen_Width,0);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return layout;
}
- (Class)collectionCellClass
{
    return [LKPictureCell class];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置UI
    [self conFigUI];
    @weakify(self);
    [self.pictureViewModel.cellClickSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)

        if ([x isKindOfClass:[NSString class]]) {
            NSString * type = (NSString *)x;
            if ([type isEqualToString:@"MainCollectReload"]) {
                [self.mainCollectionView reloadData];
            }
        }else if ([x isKindOfClass:[NSDictionary class]]){
            NSDictionary * dict = (NSDictionary *)x;
            NSString * type = [dict objectForKey:@"type"];
            if ([type isEqualToString:@"upload"]) {
                //确定上传
                
                NSArray * imageArray = [dict objectForKey:@"data"];
                
                
                [Dialog showCustomAlertViewWithTitle:@"提示" message:[NSString stringWithFormat:@"是否上传这%lu张照片？",(unsigned long)imageArray.count] firstButtonName:@"取消上传" secondButtonName:@"立即上传" dismissHandler:^(NSInteger index) {
                     if(index == 1){

                         [LKCustomMethods saveUpLoadImages:imageArray withCategoryId:self.qualityModel.detailId withCommityId:self.commityId];
                         
                         [self.navigationController popViewControllerAnimated:YES];
                         
                         [[LKPIctureUploadManager shareInstance] startUpLoadimage];
                    }
                    
                }];
                
                
            }else if ([type isEqualToString:@"SelectAll"]){
                //全选
                NSNumber * imageCount = [dict objectForKey:@"count"];
                [self.pictureCliassifyView.uploadBtn setTitle:[NSString stringWithFormat:@"确定 (%@)",imageCount] forState:UIControlStateNormal];
                
                self.imageSelecCount = [imageCount integerValue];
                
                if (self.isImageSelectAll) {
                    [self setNavBarTitle:[NSString stringWithFormat:@"已选择%@张",imageCount]];
                }else{
                    
                    [self setNavBarTitle: self.name];
                }
                [self.mainCollectionView reloadData];
                
            }else if ([type isEqualToString:@"SelectImage"]){
                
                //选择图片
                NSNumber * imageCount = [dict objectForKey:@"count"];
                [self.pictureCliassifyView.uploadBtn setTitle:[NSString stringWithFormat:@"确定 (%@)",imageCount] forState:UIControlStateNormal];
                
                self.imageSelecCount = [imageCount integerValue];

                [self.mainCollectionView reloadData];
                
                if (imageCount == 0) {
                    [self setNavBarTitle:@"选择照片"];
                    
                }else{
                    [self setNavBarTitle:[NSString stringWithFormat:@"已选择%@张",imageCount]];
                }
                NSNumber * selectAll = [dict objectForKey:@"isSelectAll"];
                
                if ([selectAll integerValue] == 1) {
                    self.isImageSelectAll = YES;
                    [self addRightNavButtonWithTitle:@"取消全选" action:@selector(rightNavBtnClick)];

                }else{
                    self.isImageSelectAll = NO;
                    [self addRightNavButtonWithTitle:@"全选" action:@selector(rightNavBtnClick)];

                }
                
            }else if ([type isEqualToString:@"CollectReload"]){
              
                //图片个数
                NSNumber * imageCount = [dict objectForKey:@"Count"];
                BOOL hasNOData = [imageCount integerValue] == 0 ? YES  : NO ;
                [self.view configBlankPage:EaseBlankPageTypeNoButton_noImageData frame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 50 - kNavBarHeight - kStatusBarHeight - kSafeAreaBottomHeight) hasData:!hasNOData hasError:NO reloadButtonBlock:^(id sender) {
                          
                }];
                
                if (hasNOData) {
                    self.navigationItem.rightBarButtonItem = nil;

                }else{
                    [self addRightNavButtonWithTitle:@"全选" action:@selector(rightNavBtnClick)];
                }
              
                [self.mainCollectionView reloadData];
            }
            
        }
    }];
    
    
    self.pictureViewModel.categoryId = self.categoryId;
    [self.pictureCliassifyView conFigClassifyName:self.name];
    
}

-(void)rightNavBtnClick
{
    self.isImageSelectAll = !self.isImageSelectAll;
    self.pictureViewModel.isSelectAll = self.isImageSelectAll;
    if (self.pictureViewModel.isSelectAll) {
        [self addRightNavButtonWithTitle:@"取消全选" action:@selector(rightNavBtnClick)];
        
    }else{
        
        [self addRightNavButtonWithTitle:@"全选" action:@selector(rightNavBtnClick)];
    }
    
}


-(void)conFigUI
{
      //设置导航栏
    [self setNavBarTitle:self.name];
    [self addRightNavButtonWithTitle:@"全选" action:@selector(rightNavBtnClick)];
    
    if ([_type isEqualToString:@"look"]) {
        [self.view addSubview:self.pictureBottomView];
        [self.pictureBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuide);
            }else{
                make.bottom.equalTo(self.view.mas_bottom);
            }
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(50));
        }];
        [self.mainCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.equalTo(self.pictureBottomView.mas_top);
            
        }];
    }else if ([_type isEqualToString:@"upload"]){
        [self.view addSubview:self.pictureCliassifyView];
        [self.pictureCliassifyView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuide);
            }else{
                make.bottom.equalTo(self.view.mas_bottom);
            }
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(50));
        }];
        [self.mainCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.equalTo(self.pictureCliassifyView.mas_top);
            
        }];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//lazy
-(LKPictureViewModel *)pictureViewModel
{
    if (_pictureViewModel == nil) {
        _pictureViewModel = [[LKPictureViewModel alloc]init];
    }
    return _pictureViewModel;
}

-(LKPictureBottomView *)pictureBottomView
{
    if (_pictureBottomView == nil) {
        _pictureBottomView = [[LKPictureBottomView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
    }
    return _pictureBottomView;
}
-(LKPictureCliassifyView *)pictureCliassifyView{
    
    if (_pictureCliassifyView == nil) {
        _pictureCliassifyView = [[LKPictureCliassifyView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
        WS(weakSelf)
        _pictureCliassifyView.pictureClassifyClick = ^(NSString *status) {
            if ([status isEqualToString:@"pictureClassify"]) {
                //类别名称
                [weakSelf.view addSubview:weakSelf.selectClassifyListView];
                [weakSelf.selectClassifyListView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.top.equalTo(weakSelf.view);
                    make.bottom.equalTo(weakSelf.pictureCliassifyView.mas_top);
                }];
                [weakSelf.pictureCliassifyView.uploadBtn setTitle:@"确定" forState:UIControlStateNormal];
                weakSelf.selectClassifyListView.currentAlumbId = weakSelf.categoryId;
                
            }else if ([status isEqualToString:@"upload"]){
                
                if (weakSelf.imageSelecCount ==0) {
                    [LKCustomMethods showWindowMessage:@"未选择图片"];
                    return ;
                }
                
                if (weakSelf.imageSelecCount > 20) {
                    [LKCustomMethods showWindowMessage:@"上传照片数量已超出范围，最多可上传20张"];
                    return ;
                }
                
                //确定按钮
                weakSelf.pictureViewModel.sure = @"upload";
            }
        };
    }
    return _pictureCliassifyView;
}


-(LKSelectClassityListView *)selectClassifyListView
{
    if (_selectClassifyListView == nil) {
        _selectClassifyListView = [[LKSelectClassityListView alloc]init];
        WS(weakSelf)
        _selectClassifyListView.selectListClick = ^(LKAlumbModel *model) {
            DLog(@"selectListClick : %@",model);
            
            weakSelf.pictureViewModel.categoryId = [model.categoryId stringValue];
            weakSelf.categoryId = model.categoryId;
            [weakSelf.pictureCliassifyView conFigClassifyName:model.name];
            
            [weakSelf setNavBarTitle:model.name];
            [weakSelf.selectClassifyListView removeFromSuperview];
        };
        
    }
    return _selectClassifyListView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
