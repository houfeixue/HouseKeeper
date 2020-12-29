//
//  LKPicturesViewController.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSelectPicturesViewController.h"
#import "LKPictureCell.h"
#import "LKSelectPicturesViewModel.h"
#import "LKPicturesHeadView.h"
#import "LKPicturesSectionHeaderReusableView.h"
#import "LKPictureActionVIew.h"

#import "LKPictureHandleVC.h"
#import "LKSelectClassityListView.h"
#import "LKWorkPicUpLoadViewController.h"

@interface LKSelectPicturesViewController ()

@property(nonatomic,assign)NSInteger picSelectCount;
@property(nonatomic,strong)LKSelectPicturesViewModel *pictureViewModel;
@property(nonatomic,strong)LKPicturesHeadView *picturesHeadView;
//@property(nonatomic,strong)LKPictureActionVIew *pictureActionVIew;
///** 相册列表 **/
//@property (nonatomic, strong) LKSelectClassityListView *selectClassifyListView;
///** 相册选择移动Model */
//
//@property (nonatomic, strong) LKAlumbModel *selectAlumbModel;

@end

@implementation LKSelectPicturesViewController

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
    layout.headerReferenceSize = CGSizeMake(kScreen_Width,50);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return layout;
}
- (Class)collectionCellClass
{
    return [LKPictureCell class];
}

- (Class)collectionHeaderReusableViewClass//section  header
{
    return [LKPicturesSectionHeaderReusableView class];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _setUpView];
    
    
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
            NSString *type = [dict stringForKey:@"type"];
            if ([type isEqualToString:@"count"]) {
                NSNumber *count = [dict numberForKey:@"count"];
                self.picSelectCount = [count integerValue];
                if ([count integerValue] == 0) {
                    [self setNavBarTitle:self.name];
                    
                }else{
                    [self setNavBarTitle:[NSString stringWithFormat:@"已选择%@张",count]];
                    
                }
            }else if ([type isEqualToString:@"sureSelectPicS"]){
                NSArray * imageArray = [dict arrayForKey:@"data"];
                
                NSMutableArray * dataImageArray = [[NSMutableArray alloc]init];
                
                for (LKPictureModel *model  in imageArray) {
                    model.picName = [NSString stringWithFormat:@"%@/%@",LKCompoundPicturePath,model.picName];
                    [dataImageArray addObject:model];
                }
                
                if ([self.delegate respondsToSelector:@selector(selectPicturesArray:)]) {
                    [self.delegate selectPicturesArray:dataImageArray];
                }
                
                [self.navigationController popToViewController:self.formVC animated:YES];
                
            }else if ([type isEqualToString:@"allCount"]){
                //allCount
                NSNumber * data = [dict objectForKey:@"data"];
                BOOL hasNOData = [data intValue] == 0 ? YES : NO;
                [self.view configBlankPage:EaseBlankPageTypeNoButton_noImageData frame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - kNavBarHeight - kStatusBarHeight - kSafeAreaBottomHeight) hasData:!hasNOData hasError:NO reloadButtonBlock:^(id sender) {

                }];
                self.picturesHeadView.hidden = hasNOData;
                
                [self.mainCollectionView reloadData];
            }
        }
    }];
    self.pictureViewModel.categoryId = _categoryId;

}

-(void)_setUpView
{
    //导航栏
    [self setNavBarTitle:_name];
    [self addRightNavButtonWithTitle:@"确认" action:@selector(savePicture)];
     //view
    [self.view addSubview:self.picturesHeadView];
    
    
    NSInteger count = [[LKPictureDBManager shareManager]fetchAlumbCountFromCategory:_categoryId];
    [self.picturesHeadView conDataName:_name withCount:[NSString stringWithFormat:@"%ld",(long)count]];
    [self.picturesHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(40));
        
    }];
    
    [self.mainCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.picturesHeadView.mas_bottom);
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuide);
            } else {
                make.bottom.equalTo(self.view.mas_bottom);
            }
    }];
    
}

-(void)savePicture{
    
     self.pictureViewModel.actionType = @"sureSelectPicS";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//lazy

-(LKSelectPicturesViewModel *)pictureViewModel
{
    if (_pictureViewModel == nil) {
        _pictureViewModel = [[LKSelectPicturesViewModel alloc]init];
        _pictureViewModel.selectCount = self.selectCount;
    }
    return _pictureViewModel;
}

-(LKPicturesHeadView *)picturesHeadView{
    if (_picturesHeadView == nil) {
        _picturesHeadView = [[LKPicturesHeadView alloc]init];
    }
    return _picturesHeadView;
}

//-(LKPictureActionVIew *)pictureActionVIew{
//    if (_pictureActionVIew == nil) {
//        _pictureActionVIew = [[LKPictureActionVIew alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
//        _pictureActionVIew.backgroundColor =  [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1/1.0];
//        _pictureActionVIew.upLoadBtn.userInteractionEnabled = NO;
//        _pictureActionVIew.moveBtn.userInteractionEnabled = NO;
//        _pictureActionVIew.deleteBtn.userInteractionEnabled = NO;
//
//        WS(weakSelf);
//        _pictureActionVIew.pictureActionClick = ^(NSString *status) {
//            if ([status isEqualToString:@"upLoad"]) {
//                //一键上传
//
//                [Dialog showCustomAlertViewWithTitle:@"提示" message:[NSString stringWithFormat:@"确定上传这%ld张照片？", (long)weakSelf.picSelectCount] firstButtonName:@"取消" secondButtonName:@"确定" dismissHandler:^(NSInteger index) {
//                    if (index == 1) {
//
//                        weakSelf.pictureViewModel.actionType = @"upLoad";
//
//
//
//                    }
//                }];
//
//            }else if ([status isEqualToString:@"move"]){
//                  //转移
//
//                [Dialog showCustomAlertViewWithTitle:@"提示" message:[NSString stringWithFormat:@"确定转移这%ld张照片？", (long)weakSelf.picSelectCount] firstButtonName:@"取消" secondButtonName:@"确定" dismissHandler:^(NSInteger index) {
//                    if (index == 1) {
//                        [weakSelf.view addSubview:weakSelf.selectClassifyListView];
//                        [weakSelf.selectClassifyListView mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.left.right.top.equalTo(weakSelf.view);
//                            make.bottom.equalTo(weakSelf.pictureActionVIew.mas_top);
//
//                        }];
//                    }
//                }];
//
//
//
//            }else if ([status isEqualToString:@"delete"]){
//                //删除
//                [Dialog showCustomAlertViewWithTitle:@"提示" message:[NSString stringWithFormat:@"确定删除这%ld张照片？", (long)weakSelf.picSelectCount] firstButtonName:@"取消" secondButtonName:@"确定" dismissHandler:^(NSInteger index) {
//                    if (index == 1) {
//                        weakSelf.pictureViewModel.actionType = @"delete";
//                    }
//                }];
//            }
//        };
//    }
//    return _pictureActionVIew;
//}
//
//-(LKSelectClassityListView *)selectClassifyListView
//{
//    if (_selectClassifyListView == nil) {
//        _selectClassifyListView = [[LKSelectClassityListView alloc]init];
//        WS(weakSelf)
//        _selectClassifyListView.selectListClick = ^(LKAlumbModel *model) {
//            DLog(@"selectListClick : %@",model);
//
////            weakSelf.pictureViewModel.categoryId = model.categoryId;
//            [weakSelf.selectClassifyListView removeFromSuperview];
//            weakSelf.selectAlumbModel = model;
//
//            weakSelf.pictureViewModel.actionType = @"move";
//
//        };
//
//    }
//    return _selectClassifyListView;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
