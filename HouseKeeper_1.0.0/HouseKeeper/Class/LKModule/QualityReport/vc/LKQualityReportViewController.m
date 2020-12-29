//
//  LKQualityReportViewController.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/20.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKQualityReportViewController.h"
#import "LKQualityReportViewModel.h"
#import "LKQualityReportViewCell.h"
#import "LKQualityDetailViewController.h"
#import "LKScoreBottomView.h"
#import "LKQualityHistoryModel.h"
#import "LKLookPictureViewController.h"
#import "LKQualityHistoryVC.h"

@interface LKQualityReportViewController ()
@property (nonatomic, strong) LKScoreBottomView *scoreBottomView;

@property (nonatomic, strong) LKQualityReportViewModel *qualityReportViewModel;

@end

@implementation LKQualityReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavBarTitle:@"抽查报告"];
    [self addRightNavButtonWithTitle:@"抽查明细" action:@selector(rightBtnClick)];
    [self createUI];
    [self bindBottomData];
    self.qualityReportViewModel.requestUrl = LKSpotCheckCountDetail;
    self.qualityReportViewModel.requestTag = 1;
    if (self.historyModel != nil && self.historyModel.recordId ) {
        self.qualityReportViewModel.requestDict = @{@"recordId":self.historyModel.recordId};
    }
    

    @weakify(self);
    [self.qualityReportViewModel.cellClickSubject subscribeNext:^(id x) {
        @strongify(self)
        
        if ([x isKindOfClass:[NSString class]]) {
            NSString * str = x;
            if ([str isEqualToString:@"mainViewRolad"]) {
                [self.mainTableView reloadData];
            }
        }
        
    }];
    

}

-(void)backAction:(id)sender
{
    for (int i=0; i<self.navigationController.viewControllers.count; i++) {
        UIViewController * vc =[self.navigationController.viewControllers objectAtIndex:i];
        if ([vc isKindOfClass:[LKQualityHistoryVC class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
        
    }
}

- (void)createUI {
    [self.view addSubview:self.scoreBottomView];
    [self.scoreBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(50));
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuide);
        } else {
            make.bottom.equalTo(self.view.mas_bottom);
        }
    }];
    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.scoreBottomView.mas_top);
    }];
}
- (void)bindBottomData {
    if (self.historyModel != nil) {
        NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",self.historyModel.scort]];
        [self.scoreBottomView bindDataWithScore:[decNumber stringValue] identify:self.historyModel.identityName name:self.historyModel.realName];
        
    }
}
-(void)rightBtnClick
{
    LKQualityDetailViewController * vc =[[LKQualityDetailViewController alloc]init];
    vc.historyModel = self.historyModel;
    [self.navigationController pushViewController:vc animated:YES];
}

/**  */
-(Class)tableCellClass
{
    return [LKQualityReportViewCell class];
}

- (LKBaseTableViewModel*)createDataSource
{
    return self.qualityReportViewModel;
}

//lazy
-(LKQualityReportViewModel *)qualityReportViewModel{
    if (_qualityReportViewModel == nil) {
        _qualityReportViewModel = [[LKQualityReportViewModel alloc]init];
    }
    return _qualityReportViewModel;
}

-(LKScoreBottomView *)scoreBottomView{
    
    if (_scoreBottomView == nil) {
        _scoreBottomView = [[LKScoreBottomView alloc]init];
        WS(weakSelf)
        _scoreBottomView.pictureLookClick = ^(NSString *status) {
            LKLookPictureViewController * vc =[[LKLookPictureViewController alloc]init];
//            vc.dataArray = weakSelf.qualityReportViewModel.dataArray;
            vc.recordId = weakSelf.historyModel.recordId;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _scoreBottomView;
    
}
@end
