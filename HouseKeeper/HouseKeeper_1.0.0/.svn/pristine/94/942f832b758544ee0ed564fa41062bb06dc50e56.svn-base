//
//  LKSearchCommunityVC.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/19.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKSearchCommunityVC.h"
#import "UITableView+SCIndexView.h"
#import "LKSearchCommunityCell.h"
#import "LKSearchCommunityViewModel.h"
#import "SCIndexViewConfiguration.h"
#import "LKSearchBar.h"
#import "LKSearchCommunityBottomView.h"
#import "LKSearchCommunityResultVC.h"
#import "LKCheckSearchCommunityVC.h"
#import "LKSearchCommunityCityHeaderView.h"
#import "LKSelectCityListView.h"

@interface LKSearchCommunityVC ()
@property (nonatomic, strong) LKSearchCommunityViewModel *communityViewModel;
@property (nonatomic, strong) LKSearchBar *searchBar;
@property (nonatomic, strong) LKSearchCommunityBottomView *bottomView;
@property (nonatomic, strong) LKSearchCommunityCityHeaderView *cityHeaderView;


@property (nonatomic, strong) LKSelectCityListView *selectCityListView;
@property (nonatomic, strong) UIView *clearBgView;

@end

@implementation LKSearchCommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self bindViewModelData];
}

- (void)bindViewModelData {
    @weakify(self);
    [self.communityViewModel.selectCommunitySubject subscribeNext:^(NSMutableArray *  _Nullable communityArray) {
        @strongify(self);
        self.selectCommunityArray = [communityArray mutableCopy];
        [self.bottomView bindDataSelectCountCommunity:self.selectCommunityArray.count];
    }];
    [self.communityViewModel.loadDataSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.communityViewModel changeSelectDataArray:self.selectCommunityArray];
        [self.bottomView bindDataSelectCountCommunity:self.selectCommunityArray.count];
        [self.mainTableView reloadData];
        NSMutableArray *titleArray = [NSMutableArray array];
        for (LKTableSectionObject *sectionObject in self.communityViewModel.dataArray) {
            [titleArray addObject:sectionObject.sectionKey];
        }
        [titleArray insertObject:UITableViewIndexSearch atIndex:0];
        self.mainTableView.sc_indexViewDataSource = titleArray;
    }];
    [self.communityViewModel.changeDataSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.mainTableView reloadData];
    }];
    [self.communityViewModel.selectCitySubject subscribeNext:^(LKCityModel * _Nullable selectCity) {
        @strongify(self);
        self.currentSelectCityModel = selectCity;
        [self.cityHeaderView bindDataSelectCityModel:selectCity];
    }];

    if (self.currentSelectCityModel != nil) { /// 有城市的话直接获取小区列表
        NSMutableDictionary * brunchDict = [[NSMutableDictionary alloc]init];
        [brunchDict setObject:@"" forKey:@"name"];
        [brunchDict setObject:self.currentSelectCityModel.cityId forKey:@"regionId"];
        //请求小区数据
        self.communityViewModel.requestUrl = LKBrunchList;
        self.communityViewModel.requestTag = 2;
        self.communityViewModel.requestDict =  brunchDict;
        [self.cityHeaderView bindDataSelectCityModel:self.currentSelectCityModel];
    }else {
        //获取城市列表
        self.communityViewModel.requestUrl = LKCityList;
        self.communityViewModel.requestTag =  1;
        self.communityViewModel.requestDict = @{};
    }

}
- (void)createUI {
    self.navBarTitle = @"选择小区";
    self.mainTableView.rowHeight = 50.f;
    [self createBottomView];

    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    [self configSearchIndexView];
    [self createHeaderView];
}
- (void)configSearchIndexView {
    SCIndexViewConfiguration *configuration = [SCIndexViewConfiguration configurationWithIndexViewStyle:SCIndexViewStyleDefault];
    self.mainTableView.sc_indexViewConfiguration = configuration;
    self.mainTableView.sc_translucentForTableViewInNavigationBar = NO;
}
- (void)createHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 130)];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.searchBar];
    [headerView addSubview:self.cityHeaderView];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LKLeftMargin);
        make.width.mas_equalTo(kScreen_Width - 2 * LKLeftMargin);
        make.height.mas_equalTo(28);
        make.top.mas_equalTo(11);
    }];
    [self.cityHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.top.mas_equalTo(50);
    }];
    self.mainTableView.tableHeaderView = headerView;
    
    [self.view addSubview:self.clearBgView];
    self.clearBgView.hidden = YES;
    [self.view addSubview:self.selectCityListView];
    self.selectCityListView.hidden = YES;
    
    
    @weakify(self);
    self.searchBar.toSearch = ^{
        @strongify(self);
        LKSearchCommunityResultVC *vc = [[LKSearchCommunityResultVC alloc] init];
        vc.selectCommunityArray = [self.selectCommunityArray mutableCopy];
        NSString *regionId = @"";
        if ([LKCustomTool isBlankString:[NSString stringWithFormat:@"%@",self.currentSelectCityModel.cityId]] == NO) {
            regionId = [NSString stringWithFormat:@"%@",self.currentSelectCityModel.cityId];
        }
        vc.regionId = regionId;
        [self.navigationController pushViewController:vc animated:YES];
        @weakify(self);
        [vc.sureSelectSubject subscribeNext:^(NSMutableArray * _Nullable checkSelectCommunityArray) {
            @strongify(self);
            [self.communityViewModel changeSelectDataArray:checkSelectCommunityArray];
            self.selectCommunityArray = [checkSelectCommunityArray mutableCopy];
            [self.bottomView bindDataSelectCountCommunity:self.selectCommunityArray.count];
        }];
    };
    self.cityHeaderView.selectCity = ^(LKCityModel *cityModel) {
        @strongify(self);
        [self showSelectCityListView];
    };

    self.selectCityListView.selectCityClick = ^(LKCityModel *cityModel) {
        @strongify(self);
            if (![self.currentSelectCityModel.cityId isEqualToNumber:cityModel.cityId]) {
                self.currentSelectCityModel = cityModel;
                [self.cityHeaderView bindDataSelectCityModel:cityModel];
                NSMutableDictionary * brunchDict = [[NSMutableDictionary alloc]init];
                [brunchDict setObject:@"" forKey:@"name"];
                [brunchDict setObject:self.currentSelectCityModel.cityId forKey:@"regionId"];
                //请求小区数据
                self.communityViewModel.requestUrl = LKBrunchList;
                self.communityViewModel.requestTag = 2;
                self.communityViewModel.requestDict =  brunchDict;
            }
        [self showSelectCityListView];

    };
}


- (void)showSelectCityListView {
    if (self.communityViewModel.cityArray.count == 0) {
        return;
    }
    NSMutableArray *tempCityModelArray = [self.communityViewModel.cityArray mutableCopy];
    for (NSInteger index = 0; index <tempCityModelArray.count; index ++ ) {
        LKCityModel *model = [tempCityModelArray objectAtIndex:index];
        model.isSelected = NO;
        if ([self.currentSelectCityModel.cityId isEqualToNumber:model.cityId]) {
            model.isSelected = YES;
            [tempCityModelArray replaceObjectAtIndex:index withObject:model];
            break;
        }
    }
    [self.view bringSubviewToFront:self.clearBgView];
    [self.view bringSubviewToFront:self.selectCityListView];
    CGRect currentRect = [self.view convertRect:self.cityHeaderView.bottomView.frame fromView:self.mainTableView];
    CGFloat originY = currentRect.origin.y + 100 >=0 ? currentRect.origin.y + 100 : 0;
    self.selectCityListView.frame = CGRectMake(0, originY, kScreen_Width, 0);
    self.selectCityListView.isShow = !self.selectCityListView.isShow;

    if (self.selectCityListView.isShow == YES) {
        self.selectCityListView.hidden = NO;
        self.clearBgView.hidden = NO;
        self.clearBgView.frame = CGRectMake(0, originY, kScreen_Width, kScreen_Height - kStatusBarHeight - kNavBarHeight - originY);
        self.selectCityListView.frame = CGRectMake(0, originY, kScreen_Width, 300);
        self.selectCityListView.isShow = YES;
        [self.selectCityListView.tableView layoutIfNeeded];
        self.mainTableView.scrollEnabled = NO;
        self.searchBar.userInteractionEnabled = NO;
    }else {
        self.selectCityListView.frame = CGRectMake(0, originY, kScreen_Width, 0);
        self.selectCityListView.hidden = YES;
        self.selectCityListView.isShow = NO;
        self.clearBgView.hidden = YES;
        self.mainTableView.scrollEnabled = YES;
        self.searchBar.userInteractionEnabled = YES;
        [self.selectCityListView.tableView layoutIfNeeded];
    }
    [self.selectCityListView bindData:tempCityModelArray];
}




- (void)backAction:(id)sender {
//    [self.sureSelectSubject sendNext:self.selectCommunityArray];
    [super backAction:sender];

}
- (void)createBottomView {
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            // Fallback on earlier versions
            make.bottom.equalTo(self.view.mas_bottom);
        }
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(50);
    }];
    [self.bottomView bindDataSelectCountCommunity:0];
    @weakify(self);
    self.bottomView.checkSelectCommunity = ^{
        @strongify(self);
        LKCheckSearchCommunityVC *vc = [[LKCheckSearchCommunityVC alloc] init];
        vc.selectCommunityArray = [self.selectCommunityArray mutableCopy];
        [self.navigationController pushViewController:vc animated:YES];
        @weakify(self);
        [vc.checkSureSelectSubject subscribeNext:^(NSMutableArray * _Nullable checkSelectCommunityArray) {
            @strongify(self);
            [self.communityViewModel changeSelectDataArray:checkSelectCommunityArray];
            self.selectCommunityArray = [checkSelectCommunityArray mutableCopy];
            [self.bottomView bindDataSelectCountCommunity:self.selectCommunityArray.count];
        }];
    };
    self.bottomView.sureBtnClick = ^{
        @strongify(self);
        [self.sureSelectSubject sendNext:self.selectCommunityArray];
        [self.navigationController popViewControllerAnimated:YES];
    };
}
-(Class)tableCellClass {
    return [LKSearchCommunityCell class];
}
- (LKBaseTableViewModel *)createDataSource
{
    return self.communityViewModel;
}
- (LKSearchCommunityViewModel *)communityViewModel {
    if (_communityViewModel == nil) {
        _communityViewModel = [[LKSearchCommunityViewModel alloc] init];
    }
    return _communityViewModel;
}
- (LKSearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[LKSearchBar alloc] init];
        _searchBar.backgroundColor = LKF7Color;
        _searchBar.searchTextField.placeholder = @"输入小区名称搜索";
        _searchBar.inputHidden = YES;
    }
    return _searchBar;
}
- (LKSearchCommunityBottomView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[LKSearchCommunityBottomView alloc] init];
    }
    return _bottomView;
}
- (NSMutableArray *)selectCommunityArray {
    if (_selectCommunityArray == nil) {
        _selectCommunityArray = [NSMutableArray array];
    }
    return _selectCommunityArray;
}
- (RACSubject *)sureSelectSubject {
    if (_sureSelectSubject == nil) {
        _sureSelectSubject = [RACSubject subject];
    }
    return _sureSelectSubject;
}
- (LKSearchCommunityCityHeaderView *)cityHeaderView {
    if (_cityHeaderView == nil) {
        _cityHeaderView = [[LKSearchCommunityCityHeaderView alloc] init];
    }
    return _cityHeaderView;
}
- (LKSelectCityListView *)selectCityListView {
    if (_selectCityListView == nil) {
        _selectCityListView = [[LKSelectCityListView alloc] init];
    }
    return _selectCityListView;
}
- (UIView *)clearBgView {
    if (_clearBgView == nil) {
        _clearBgView = [[UIView alloc] init];
        _clearBgView.backgroundColor = [UIColor clearColor];
    }
    return _clearBgView;
}
@end
