//
//  LKCheckSearchCommunityVC.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/22.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKCheckSearchCommunityVC.h"
#import "LKCheckSearchCommunityViewModel.h"


@interface LKCheckSearchCommunityVC ()
@property (nonatomic, strong) LKCheckSearchCommunityViewModel *communityViewModel;

@end

@implementation LKCheckSearchCommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self bindViewModelData];
}

- (void)bindViewModelData {
    @weakify(self);

    [self.communityViewModel.cellClickSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isKindOfClass:[NSString class]]) {
            NSString *type = (NSString *)x;
            if ([type isEqualToString:@"reload"]) {
                [self.mainTableView reloadData];
            }
        }
    }];
    [self.communityViewModel.selectCommunitySubject subscribeNext:^(NSMutableArray *  _Nullable communityArray) {
        @strongify(self);
        [self.mainTableView reloadData];
        self.selectCommunityArray = communityArray;
    }];
    [self.communityViewModel bindDataWithSelectArray:self.selectCommunityArray];
}
- (void)createUI {
    self.mainTableView.rowHeight = 50.f;
    [self setNavBarTitle:@"已选择小区"];
    [self addLeftNavLabelWithTitle:@""];
    [self addRightNavButtonWithTitle:@"确定" action:@selector(rightNavBtnClick)];
    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)backAction:(id)sender {
    [self.checkSureSelectSubject sendNext:self.selectCommunityArray];
    [super backAction:sender];
}
- (void)rightNavBtnClick {
    [self.checkSureSelectSubject sendNext:self.selectCommunityArray];
    [self.navigationController popViewControllerAnimated:YES];
}
-(Class)tableCellClass {
    return [LKCheckSearchCommunityCell class];
}
- (LKBaseTableViewModel *)createDataSource
{
    return self.communityViewModel;
}
- (LKCheckSearchCommunityViewModel *)communityViewModel {
    if (_communityViewModel == nil) {
        _communityViewModel = [[LKCheckSearchCommunityViewModel alloc] init];
    }
    return _communityViewModel;
}

- (NSMutableArray *)selectCommunityArray {
    if (_selectCommunityArray == nil) {
        _selectCommunityArray = [NSMutableArray array];
    }
    return _selectCommunityArray;
}
- (RACSubject *)checkSureSelectSubject {
    if (_checkSureSelectSubject == nil) {
        _checkSureSelectSubject = [RACSubject subject];
    }
    return _checkSureSelectSubject;
}
@end
