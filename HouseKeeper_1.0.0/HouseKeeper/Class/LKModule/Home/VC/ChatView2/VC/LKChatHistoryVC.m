//
//  LKChatHistoryVC.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/8/9.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKChatHistoryVC.h"
/* 聊天内容模型 */

#import "SDChatMessage.h"
#import "SDChatDetail.h"
#import "SDChatDetailFrame.h"

#import "SDChatHistoryTableView.h"
/* 聊天内容View */

#import "SDChatDetailTableView.h" //列表
#import <IQKeyboardManager/IQKeyboardManager.h>

#define kInputViewHeight 275
#define kBjViewOriFrame CGRectMake(0, 0,kScreen_Width , kScreen_Height);

@interface LKChatHistoryVC ()
@property (nonatomic,strong)NSMutableArray *dataArr; //消息数据源
@property (nonatomic,strong)SDChatHistoryTableView *chatTableView;
/**
 背景view
 */
@property (nonatomic,strong)UIView *bjView;

@property (nonatomic,assign)BOOL isFirstRequest;

@end

@implementation LKChatHistoryVC


- (void)viewDidLoad {
    [super viewDidLoad];
     [self setTitle:@"历史记录"];
     [self setUI];
     self.isFirstRequest = YES;
     [self requestMessageData];
}

-(void)setUI{
    
    [self.view addSubview:self.bjView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.bjView addSubview:self.chatTableView];
    self.chatTableView.dataArray =self.dataArr;
   
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestMessageData{

    LKUserInfoModel *model = [LKCustomMethods readUserInfo];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(model.userId) forKey:@"toUserId"];
    [params setObject:self.chat.fromUserId forKey:@"fromUserId"];
    [params setObject:@(self.MinID) forKey:@"maxMessageId"];
    [params setObject:@(30) forKey:@"pageSize"];
    
    if (self.isFirstRequest ) {
        [LKCustomMethods showMBMBHUBView:self.view];
    }
    [[LKHttpRequest  request] POST:LKgetHistoryMessage parameters:params tag:0 success:^(LKHttpRequest * _Nonnull request, NSInteger tag, NSString * _Nonnull responseString) {
        NSDictionary *requestJson = [LKCustomMethods dictionaryWithJsonString:responseString];
        int successResult  = [[requestJson objectForKey:@"status"] intValue];
        if ( successResult == 1) {
            [LKCustomMethods hideMBMBHUBView:self.view];
            NSMutableArray * array = [NSMutableArray array];
            NSArray * temp2 =  [LKCustomMethods arrayWithJsonString:[LKEntcry decryptAES:[requestJson objectForKey:@"data"]]];
            for (int i = 0; i<temp2.count; i++) {
                NSMutableDictionary *dict = temp2[i];
                [dict setValue:@"0" forKey:@"msgType"];
                [dict setValue:self.chat.fromUserName forKey:@"staffName"];
                [dict setValue:self.chat.fromUserId forKey:@"staffID"];
                if ([[NSString stringWithFormat:@"%ld",self.myModel.customerId] isEqualToString:[dict objectForKey:@"fromUserId"]] ) {
                    [dict setValue:@"1" forKey:@"sender"];
                    [dict setValue:self.myModel.NAME forKey:@"personName"];
                    [dict setValue:self.myModel.portrait forKey:@"personPic"];
                }else{
                    [dict setValue:@"0" forKey:@"sender"];
                    [dict setValue:self.chat.fromUserName forKey:@"personName"];
                    [dict setValue:self.chat.portrait forKey:@"personPic"];
                }

                [array addObject:dict];
            }



            NSMutableArray * emptyArr = [NSMutableArray array];
            for (NSDictionary *dic in array){
                SDChatMessage *msg =[SDChatMessage chatMessageWithDic:dic];
                SDChatDetail *chat =[SDChatDetail sd_chatWith:msg];
                SDChatDetailFrame *chatFrame =[[SDChatDetailFrame alloc]init];
                chatFrame.chat=chat;

                [emptyArr addObject:chatFrame];
            }
            
            if (self.isFirstRequest == YES) {
               self.dataArr =[[NSMutableArray alloc]initWithArray:emptyArr];
                
            }else{
                [self.dataArr addObjectsFromArray:emptyArr];
            }
            if (emptyArr.count == 0) {
                [LKCustomMethods showWindowMessage:@"数据已全部加载完"];
            }
            
            self.chatTableView.dataArray =self.dataArr;
            if (self.chatTableView.dataArray.count !=0) {
                SDChatDetailFrame *oldChatFrame = self.chatTableView.dataArray[self.chatTableView.dataArray.count - 1];
                self.MinID = [oldChatFrame.chat.chatMsg.msgID intValue];
            }
            
            [self.chatTableView.mj_footer endRefreshing];
            [self.chatTableView reloadData];
            
            self.isFirstRequest = NO;

        }else{
            [LKCustomMethods hideMBMBHUBView:self.view];
             [self.chatTableView.mj_footer endRefreshing];
            [LKCustomMethods showWindowMessage:[requestJson objectForKey:@"msg"]];
        }

    } failure:^(LKHttpRequest * _Nonnull request, NSInteger tag, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
        [LKCustomMethods hideMBMBHUBView:self.view];
         [self.chatTableView.mj_footer endRefreshing];
    }];


}


-(void)footerRereshing
{
    [self requestMessageData];
}

-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(UIView *)bjView{
    if(!_bjView){
        _bjView =[[UIView alloc]init];
        _bjView.frame =kBjViewOriFrame;
        _bjView.backgroundColor=[UIColor clearColor];
    }
    return _bjView;
}


-(SDChatHistoryTableView *)chatTableView{
    if(!_chatTableView){
        _chatTableView = [[SDChatHistoryTableView alloc] initWithFrame:CGRectMake(0,0, kScreen_Width, kScreen_Height-mySizeThree(64, 64, 64, 64, 122)) style:UITableViewStylePlain];
        _chatTableView.backgroundColor = LKF2Color;
        // 上拉刷新
        _chatTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self footerRereshing];
        }];
    }
    return _chatTableView;
}

@end
