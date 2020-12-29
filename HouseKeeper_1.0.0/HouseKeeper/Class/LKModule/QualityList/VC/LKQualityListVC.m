//
//  LKQualityListVC.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/16.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKQualityListVC.h"
#import "LKQualityListViewModel.h"
#import "LKQualityListVIewCell.h"
#import "LKQualityListNavTitleView.h"
#import "LKSelectListView.h"
#import "LKScoreView.h"
#import "LKQualityHistoryVC.h"
#import "LKPictureViewController.h"
#import "LKQualityScoreDetailViewController.h"
#import "LKQualityListModel.h"
#import "LKQualityInfoModel.h"
#import "LKUrlPictureViewController.h"

@interface LKQualityListVC ()
@property (nonatomic, strong) LKQualityListViewModel *qulaityListViewModel;
@property (nonatomic, strong) LKQualityListNavTitleView *qulaityListHeaderView;

@property (nonatomic, strong) LKSelectListView *selectListView;
@property (nonatomic, strong) LKScoreView *scoreBottomView;

@property (nonatomic, strong) NSNumber * commity;//获取小区ID
@property (nonatomic, strong) NSNumber * userType;//用户类型

@property (nonatomic, assign) CGFloat  scoreAllNumber;//总评分
@property (nonatomic, assign) CGFloat  scoreNumber;//评分
@property (nonatomic, assign) BOOL  isRresh;//是否需要刷新


@end

@implementation LKQualityListVC
/**  */
-(Class)tableCellClass
{
    return [LKQualityListVIewCell class];
}
//- (Class)dataSourceClass
//{
//    return [LKHomeListViewModel class];
//}
- (LKBaseTableViewModel*)createDataSource
{
    return self.qulaityListViewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航title
    //
    self.scoreNumber = 0;
    [self conFIgUI];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    
    @weakify(self);
    [self.qulaityListViewModel.cellClickSubject subscribeNext:^(id x) {
        @strongify(self)
        if ([x isKindOfClass:[NSString class]]) {
            NSString * str = x;
            if ([str isEqualToString:@"mainViewRolad"]) {
                [self.mainTableView reloadData];
            }else if([str isEqualToString:@"UpLoadImage"]){
                //上传图片成功刷新页面
                [self requestData];
            }else if ([str isEqualToString:@"GiveScoreOK"]){
                //评分成功刷新页面
                self.scoreAllNumber = self.scoreAllNumber + self.scoreNumber;
                NSString *doubleString = [NSString stringWithFormat:@"%.1f", self.scoreAllNumber];
                NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
                [self.scoreBottomView conFigScoreCount:[decNumber stringValue]];

            }else if ([str isEqualToString:@"submitSucess"]){
                //提交成功请求接口刷新页面
                [self requestData];
            }
                
        }else if ([x isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * dict = (NSDictionary *)x;
            NSString * key = [dict stringForKey:@"key"];
            
            if ([key isEqualToString:@"score"]) {
                //一键评分
                LKQualityInfoModel * model = [dict objectForKey:@"data"];
                NSInteger  scoreNum = [model.fullMark integerValue];
                WS(weakSelf)
                NSString *scoreString = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",model.scort]] stringValue];
                if ([model.endFlag isEqualToNumber:@(0)]) {
                    scoreString = @"";
                }
                
                [Dialog showScoreAlertViewWithMessage:[NSString stringWithFormat:@" 检查标准：%@",model.standardInfo] inputText:scoreString placeholderString:[NSString stringWithFormat:@"参考分%@分",model.fullMark] score:scoreNum dismissHandler:^(NSString * score, NSInteger index, LKInputAlertView *view) {
                    
                    if (index == 1) {
                        if (score.length == 0) {
                            [LKCustomMethods showWindowMessage:@"请输入检查得分"];
                            return ;
                        }
                        LKScoreInputJudge input = [score judgeInputLegal];
                        if (input == LKScoreInputJudgeWrongFormat) {
                            [LKCustomMethods showWindowMessage:@"检查得分格式错误，请重新输入"];
                            return ;
                        }
                        if (input == LKScoreInputJudgeNegativeumber) {
                            [LKCustomMethods showWindowMessage:@"分数不得为负数，请重新输入"];
                            return ;
                        }
                        
                        if ([model.fullMark floatValue] < [score floatValue]) {
                            [LKCustomMethods showWindowMessage:@"分数不得超出参考分数，请重新输入"];
                            return ;
                        }
                        
                        weakSelf.qulaityListViewModel.requestUrl = LKSpotCheckSubmit;
                        
                        if (![model.endFlag isEqualToNumber:@(0)]) {
                            weakSelf.scoreNumber = [score floatValue] - model.scort;

                        }else{
                            weakSelf.scoreNumber = [score floatValue];

                        }
//                        weakSelf.scoreNumber = [score floatValue];
                        
                        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                        [dict setObject:model.detailId forKey:@"detailId"];
                        [dict setObject:model.checkRecordId forKey:@"checkRecordId"];
                        [dict setObject:score forKey:@"scort"];
                        [dict setObject:model.parentId forKey:@"parentId"];
                        
                        weakSelf.qulaityListViewModel.requestTag = 2;
                        weakSelf.qulaityListViewModel.requestDict = dict;
                        
                        [view close];
                        
                    }else{
                        [view close];
                        DLog(@"取消评分");
                    }
                    
                }];
                
            }else if ([key isEqualToString:@"detail"]){
                //详情页
                LKQualityScoreDetailViewController * vc =[[LKQualityScoreDetailViewController alloc]init];
                LKQualityListModel * model = [dict objectForKey:@"data"];
                NSNumber * index = [dict objectForKey:@"index"];

                vc.listModel = model;
                vc.index = [index integerValue];
                WS(weakSelf)
                vc.qualityScorerClick = ^(NSString *status) {
                   weakSelf.isRresh = YES ;
                };
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if([key isEqualToString:@"look"]){
                //look
                LKQualityListModel * model = [dict objectForKey:@"data"];
                LKUrlPictureViewController * vc =[[LKUrlPictureViewController alloc]init];
                vc.type = @"look";
                vc.name = model.ruleInfo;
                vc.detailId = @([[model.detailId stringValue] intValue]);
                
                WS(weakSelf)
                vc.urlPictureDeleteClick = ^(NSString *status) {
                    weakSelf.isRresh = YES;
                };
                
                [self.navigationController pushViewController:vc animated:YES];
                
                
            }else if([key isEqualToString:@"upload"]){
                //upload
                LKQualityListModel * model = [dict objectForKey:@"data"];
                LKPictureViewController * vc =[[LKPictureViewController alloc]init];
                vc.type = @"upload";
                vc.name = model.ruleInfo;
                vc.qualityModel = model;
                vc.commityId = self.commity;
                vc.categoryId = model.ruleId;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if([key isEqualToString:@"scoreCount"]){
                //scoreCount
                NSString *scoreCount = [dict objectForKey:@"data"];
                NSNumber *dataCount = [dict objectForKey:@"dataCount"];
                BOOL hasNOData = [dataCount integerValue] == 0 ? YES  : NO ;
                self.scoreBottomView.hidden = hasNOData;
                [self.view configBlankPage:EaseBlankPageTypeNoButton_noData hasData:!hasNOData hasError:NO reloadButtonBlock:^(id sender) {
                    
                }];
                self.scoreAllNumber = [scoreCount floatValue];
                NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:scoreCount];
                [self.scoreBottomView conFigScoreCount:[decNumber stringValue]];
                
                if(hasNOData){
                    self.view.backgroundColor = [UIColor whiteColor];
                }else{
                    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];

                }
                
                
            }
            
        }
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.isRresh) {
        self.isRresh = NO;
        [self requestData];
    }
    
    [self.mainTableView reloadData];
}

//load
-(void)requestData
{
    LKUserInfoModel *model = [LKCustomMethods readUserInfo];
    self.qulaityListViewModel.requestUrl = LKGetCheckByBrunchId;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@(model.userId) forKey:@"managerId"];
    [dict setObject:self.commity forKey:@"applyRresidenceiIds"];
    [dict setObject:self.userType forKey:@"applyrRoleIds"];

    self.qulaityListViewModel.requestTag = 1;
    self.qulaityListViewModel.requestDict = dict;
}

-(void)conFIgUI{
    //导航栏
    
    [self addTitleViewWithTitle:self.qulaityListHeaderView];
    [self.qulaityListHeaderView setTitleViewText:@"小区名称" withClick:NO];
    [self addRightNavButtonWithImage:[UIImage imageNamed:@"check_icon_note"] action:@selector(qulityHistoryList)];
    
    self.selectListView;
    
    //页面控件
    [self.view addSubview:self.scoreBottomView];
    [self.scoreBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).inset(kSafeAreaBottomHeight);
        make.height.equalTo(@(50));
        
    }];
    
    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.scoreBottomView.mas_top);
    }];
}


//click

-(void)qulityHistoryList
{
    LKQualityHistoryVC * lvc = [[LKQualityHistoryVC alloc]init];
    lvc.regionId = self.commity;
    [self.navigationController pushViewController:lvc animated:YES];
}

//lazy
-(LKQualityListViewModel *)qulaityListViewModel{
    if (_qulaityListViewModel == nil) {
        _qulaityListViewModel = [[LKQualityListViewModel alloc]init];
        
    }
    return _qulaityListViewModel;
}
-(LKQualityListNavTitleView *)qulaityListHeaderView
{
    if (_qulaityListHeaderView == nil) {
        _qulaityListHeaderView = [[LKQualityListNavTitleView alloc]init];
        WS(weakSelf)
        _qulaityListHeaderView.qualityNavTitleClick = ^(NSString *status) {
            weakSelf.selectListView.selectCommityId = weakSelf.commity;
            [weakSelf.view addSubview:weakSelf.selectListView];
            [weakSelf.selectListView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(weakSelf.view);
            }];
            
        };
    }
    return _qulaityListHeaderView;
}
-(LKSelectListView *)selectListView
{
    if (_selectListView == nil) {
        
        LKUserInfoModel *model = [LKCustomMethods readUserInfo];

        _selectListView = [[LKSelectListView alloc]init];
        
        
        _selectListView.selectViewModel.requestUrl = LKGetCommunity;
        _selectListView.selectViewModel.requestDict = @{@"customerId":@(model.userId)};
        WS(weakSelf)
        _selectListView.selectListClick = ^(LKCommityModel *model ,NSInteger count) {
            [weakSelf.qulaityListHeaderView setTitleViewText:model.name withClick:count>1?YES:NO];
            weakSelf.commity = model.Id;
            weakSelf.userType = model.type;
            
            [weakSelf requestData];
            [weakSelf.selectListView removeFromSuperview];
        };
        
        
    }
    return _selectListView;
}
-(LKScoreView *)scoreBottomView
{
    if (_scoreBottomView == nil) {
        _scoreBottomView = [[LKScoreView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
        [_scoreBottomView borderForColor:LKF7Color borderWidth:1 borderType:UIBorderSideTypeTop];
        WS(weakSelf);
        _scoreBottomView.scoreViewClick = ^(NSString *status) {
            
            
            weakSelf.qulaityListViewModel.sumbit = @"sumbit";
            
            
//            [Dialog showCustomAlertViewWithTitle:@"提示" message:@"提交后不可修改" firstButtonName:@"确定" firstButtonColor:LKLightGrayColor secondButtonName:@"取消" secondButtonColor:LKLightGrayColor  dismissHandler:^(NSInteger index) {
//                if (index ==  0) {
//                    weakSelf.qulaityListViewModel.requestUrl = LKSubmitEnd;
//                    weakSelf.qulaityListViewModel.requestTag = 3;
//                    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
//                    if (weakSelf.qulaityListViewModel.dataArray.count>0) {
//                        LKQualityListModel * model =[weakSelf.qulaityListViewModel.dataArray objectAtIndex:0];
//                        [dict setObject:@"1" forKey:@"endFlag"];
//                        [dict setObject:@"0" forKey:@"submitType"];
//                        [dict setObject:model.checkRecordId forKey:@"checkRecordId"];
//
//                    }
//
//                    weakSelf.qulaityListViewModel.requestDict = dict;
//                }
//            }];
        };
        
    }
    return _scoreBottomView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
