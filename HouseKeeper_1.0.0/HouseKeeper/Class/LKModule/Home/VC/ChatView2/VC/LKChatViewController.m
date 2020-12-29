//
//  LKChatViewController.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/8/3.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKChatViewController.h"
#import "LKChatDetailVc.h"
#import "SDChatTableView.h"
#import "SDChat.h" //聊天对话模型

@interface LKChatViewController ()<SDChatTableViewDelegate>

/**
 总数据源
 */
@property (nonatomic,strong)NSMutableArray *dataArr; //消息数据源

@property (nonatomic,strong)SDChatTableView *chatTableView;

@end

@implementation LKChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.navBarTitle = @"消息中心";
    [self setUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestPersonsList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestPersonsList{
    LKUserInfoModel *model = [LKCustomMethods readUserInfo];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(model.userId) forKey:@"customerId"];
    
    [[LKHttpRequest  request] POST:LKGetPersonList parameters:params tag:0 success:^(LKHttpRequest * _Nonnull request, NSInteger tag, NSString * _Nonnull responseString) {
         [self.chatTableView.mj_header endRefreshing];
        NSDictionary *requestJson = [LKCustomMethods dictionaryWithJsonString:responseString];
        int successResult  = [[requestJson objectForKey:@"status"] intValue];
        if ( successResult == 1) {
            
            NSArray * temp2 =  [LKCustomMethods arrayWithJsonString:[LKEntcry decryptAES:[requestJson objectForKey:@"data"]]];
            
            NSMutableArray *emptyArr =[[NSMutableArray alloc]init];
            for (NSDictionary *dict in temp2){
                SDChat *chat =[SDChat chatWithDic:dict];
                chat.isONLine =YES;
                [emptyArr addObject:chat];
                
            }
            self.dataArr = emptyArr;
            BOOL hasData;
            if (self.dataArr.count >0) {
                hasData = YES;
            }else{
                hasData = NO;
                self.chatTableView.backgroundColor = [UIColor whiteColor];
            }
           
            [self.view configBlankPage:EaseBlankPageTypeNoButton_messageCenter hasData:hasData hasError:NO reloadButtonBlock:^(id sender) {
            }];
        
            self.chatTableView.dataArray = self.dataArr;
        
            [self.chatTableView reloadData];
            
        }else {
            
            [LKCustomMethods showWindowMessage:[requestJson objectForKey:@"msg"]];
        }
        
    } failure:^(LKHttpRequest * _Nonnull request, NSInteger tag, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
         [self.chatTableView.mj_header endRefreshing];
        [LKCustomMethods hideMBMBHUBView:self.view];
    }];
}


-(void)storeChatLogWithFile
{
    NSFileManager *fileM = [NSFileManager defaultManager];
    //    判断文件是否存在，不存在则直接创建，存在则直接取出文件中的内容
    if (![fileM fileExistsAtPath:LKPersonMessagePath]) {
        [fileM createFileAtPath:LKPersonMessagePath contents:nil attributes:nil];
    }
    //    存
    [NSKeyedArchiver archiveRootObject:self.dataArr toFile:LKPersonMessagePath];
    //    取
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:LKPersonMessagePath];
    DLog(@"array:%@",array);
    
}



/**
 总数据源
 
 @return 总数据
 */
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr =[[NSMutableArray alloc]init];
    }
    return _dataArr;
}




-(SDChatTableView *)chatTableView{
    if(!_chatTableView){
        _chatTableView = [[SDChatTableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64) style:UITableViewStylePlain];
        _chatTableView.tableFooterView =[UIView new];
        // 下拉刷新
        __unsafe_unretained typeof(self) weakSelf = self;
        _chatTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requestPersonsList];
        }];
        _chatTableView.sd_delegate=self;
    }
    return _chatTableView;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


-(void)setUI{
    
    [self.view addSubview:self.chatTableView];
    
}

-(void)SDChatTableView:(id)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LKChatDetailVc *v =[[LKChatDetailVc alloc]init];
    SDChat  *chat =self.dataArr[indexPath.row];
    v.chat =chat;
    v.myModel = self.myModel;
    [self.navigationController pushViewController:v animated:YES];
}


@end
