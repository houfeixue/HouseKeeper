//
//  LKAlumbsViewController.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKAlumbsViewController.h"
#import "LKAlumbsViewModel.h"
#import "LKAlumbVIewCell.h"
#import "LKPicturesViewController.h"
#import "LKSelectPicturesViewController.h"


@interface LKAlumbsViewController ()
@property (nonatomic, strong) LKAlumbsViewModel *alumbsViewModel;

@end

@implementation LKAlumbsViewController
/**  */
-(Class)tableCellClass
{
    return [LKAlumbVIewCell class];
}

- (LKBaseTableViewModel*)createDataSource
{
    return self.alumbsViewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"LKUser_FirstOpen :%d",[UserDefaultsHelper getBoolForKey:LKUser_FirstOpen]);

    [self setNavBarTitle:@"相册"];
    
    @weakify(self);
    
    [self.alumbsViewModel.cellClickSubject subscribeNext:^(id x) {
        @strongify(self)
        if ([x isKindOfClass:[NSString class]]) {
            NSString * str = x;
            if ([str isEqualToString:@"mainViewRolad"]) {
                [self.mainTableView reloadData];
            }
        }else if ([x isKindOfClass:[NSDictionary class]]){
            NSDictionary * dict = (NSDictionary *)x;
            NSString * type = [dict objectForKey:@"type"];
            if ([type isEqualToString:@"goDetail"]) {
                
                if ([self.type isEqualToString:@"select"]) {
                    LKSelectPicturesViewController * lvc =[[LKSelectPicturesViewController alloc]init];
                    lvc.name = [dict objectForKey:@"name"];
                    lvc.categoryId = [dict objectForKey:@"categoryId"];
                    lvc.alumbModel = [dict objectForKey:@"data"];
                    lvc.selectCount = self.selectCount;
                    lvc.formVC = self.formVC;
                    lvc.delegate = self.formVC;
                    [self.navigationController pushViewController:lvc animated:YES];
                }else{
                    LKPicturesViewController * lvc =[[LKPicturesViewController alloc]init];
                    lvc.name = [dict objectForKey:@"name"];
                    lvc.categoryId = [dict objectForKey:@"categoryId"];
                    lvc.alumbModel = [dict objectForKey:@"data"];
                    [self.navigationController pushViewController:lvc animated:YES];
                }

            }
        }
        
    }];
    
    //通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:LKDeletePhotoSucessNotiation object:nil]subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        //刷新数据
        [self.alumbsViewModel setUp];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:LKMovePhotoSucessNotiation object:nil]subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        //刷新数据
        [self.alumbsViewModel setUp];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//lazy

-(LKAlumbsViewModel *)alumbsViewModel
{
    if (_alumbsViewModel == nil) {
        _alumbsViewModel = [[LKAlumbsViewModel alloc]init];
    }
    return _alumbsViewModel;
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
