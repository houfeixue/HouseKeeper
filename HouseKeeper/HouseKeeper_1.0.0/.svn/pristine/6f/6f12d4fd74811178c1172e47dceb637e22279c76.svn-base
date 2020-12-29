//
//  LKChatDetailVc.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/8/3.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKChatDetailVc.h"
#import "NSString+Emoji.h"

/* 聊天内容模型 */

#import "SDChatMessage.h"
#import "SDChatDetail.h"
#import "SDChatDetailFrame.h"

#import "SDChatDetailTableViewCell.h"
/* 聊天内容View */
#import "SDChatInputView.h" //输入view
#import "SDChatDetailTableView.h" //列表
#import <IQKeyboardManager/IQKeyboardManager.h>

#import "LKChatHistoryVC.h"

#define kInputViewHeight 275
#define kBjViewOriFrame CGRectMake(0, 0,kScreen_Width , kScreen_Height);


@interface LKChatDetailVc ()<UIGestureRecognizerDelegate,SDChatInputViewDelegate,SDChatDetailTableViewLongPress,UIScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray *dataArr; //消息数据源
@property (nonatomic,strong)SDChatDetailTableView *chatTableView;


/**
 背景view
 */
@property (nonatomic,strong)UIView *bjView;

/**
 *  是否正在切换键盘
 */
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;


/**
 聊天弹出的view
 */
@property (nonatomic,strong)SDChatInputView *chatInputView;


#pragma mark -  列表上啦加载更多
/**
 下拉加载更多
 */
@property (nonatomic,assign) BOOL isRefresh;

/**
 菊花
 */
@property (nonatomic,strong) UIActivityIndicatorView * activity;

@property (nonatomic,assign) int  maxID; /// 本地最新的一条数据id,第一次传0
@property (nonatomic,assign) int  minID;
@property (nonatomic,assign) int  firstFlaf; /// 第一次请求  1是 0 不是

@property (strong, nonatomic) NSTimer *timer;
@property(nonatomic,assign) BOOL keyBoardlsVisible;



@end

@implementation LKChatDetailVc


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2
                                                  target:self selector:@selector(requestMessageData) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    if (self.timer) {
        if ([self.timer isValid]) {
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:[NSString stringWithFormat:@"与%@会话",self.chat.fromUserName]];
    [self addRightNavButtonWithTitle:@"历史记录" action:@selector(historyAction)];
    self.minID = 0;
    self.maxID = 0;
    self.firstFlaf = 1;
    
    [self requestMessageData];
    //系统键盘谈起通知
    [[NSNotificationCenter defaultCenter] addObserver:self.chatInputView selector:@selector(systemKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //自定义键盘,系统键盘
    [[NSNotificationCenter defaultCenter] addObserver:self.chatInputView selector:@selector(keyboardResignFirstResponder:) name:SDChatKeyboardResign object:nil];

    // 2.隐藏键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardWillHideNotification object:nil];


    
    [self setUI];
    
   

}

//  键盘弹出触发该方法
- (void)keyboardDidShow
{
    NSLog(@"键盘弹出");
    _keyBoardlsVisible =YES;
}
//  键盘隐藏触发该方法
- (void)keyboardDidHide
{
    NSLog(@"键盘隐藏");
    _keyBoardlsVisible =NO;
}


-(void)historyAction
{
    LKChatHistoryVC *vc = [[LKChatHistoryVC alloc] init];
    vc.chat =self.chat;
    vc.myModel = self.myModel;
    vc.MinID = self.minID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 隐藏键盘就会调用
- (void)keyboardWillHide:(NSNotification *)note
{
    [self.chatInputView.chatText resignFirstResponder];
    [self inputViewScrollToBottom];
}


-(void)requestMessageData{
    
    DLog(@"==============    %d",self.maxID);
    
    LKUserInfoModel *model = [LKCustomMethods readUserInfo];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(model.userId) forKey:@"toUserId"];
    [params setObject:self.chat.fromUserId forKey:@"fromUserId"];
    [params setObject:@(self.maxID) forKey:@"maxMessageId"];
    [params setObject:@(self.firstFlaf) forKey:@"firstFlag"];
    
    DLog(@"*******  %@",params);
    if (self.firstFlaf == 1 ) {
        [LKCustomMethods showMBMBHUBView:self.view];
    }
    [[LKHttpRequest  request] POST:LKgetCharMessage parameters:params tag:0 success:^(LKHttpRequest * _Nonnull request, NSInteger tag, NSString * _Nonnull responseString) {
        
        NSDictionary *requestJson = [LKCustomMethods dictionaryWithJsonString:responseString];
        int successResult  = [[requestJson objectForKey:@"status"] intValue];
        if ( successResult == 1) {
             [LKCustomMethods hideMBMBHUBView:self.view];
            NSMutableArray * array = [NSMutableArray array];
            
            DLog(@"========   %@",[LKEntcry decryptAES:[requestJson objectForKey:@"data"]]);
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
            if (self.firstFlaf == 1) {
                 self.dataArr =[[NSMutableArray alloc]initWithArray:emptyArr];
            }else{
                [self.dataArr addObjectsFromArray:emptyArr];
            }
            self.chatTableView.dataArray =self.dataArr;
            
            if (self.chatTableView.dataArray.count !=0) {
                SDChatDetailFrame *lastChatFrame = self.chatTableView.dataArray[self.chatTableView.dataArray.count -1];
                self.maxID = [lastChatFrame.chat.chatMsg.msgID intValue];
                SDChatDetailFrame *oldChatFrame = self.chatTableView.dataArray[0];
                self.minID = [oldChatFrame.chat.chatMsg.msgID intValue];
            }
           
            if (temp2.count != 0) {
                [self.chatTableView reloadData];
                if (self.firstFlaf == 1) {
                    [self inputViewScrollToBottom];  /// 第一次进入回到底部
                }
                [self sd_scrollToBottomWithAnimated:NO];
                
            }
            
            /// 第一次请求成功需要更新状态
            self.firstFlaf = 0;
            
            
        }else {
             [LKCustomMethods hideMBMBHUBView:self.view];
            [LKCustomMethods showWindowMessage:[requestJson objectForKey:@"msg"]];
        }
        
    } failure:^(LKHttpRequest * _Nonnull request, NSInteger tag, NSError * _Nonnull error) {
        NSLog(@"聊天详情 %@",error.localizedDescription);
        [LKCustomMethods hideMBMBHUBView:self.view];
    }];
    
   
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


-(SDChatDetailTableView *)chatTableView{
    if(!_chatTableView){
        _chatTableView = [[SDChatDetailTableView alloc] initWithFrame:CGRectMake(0,0, kScreen_Width, kScreen_Height-50-64) style:UITableViewStylePlain];
        _chatTableView.sdLongDelegate=self;
        _chatTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _chatTableView.backgroundColor = LKF2Color;
    }
    return _chatTableView;
}
// 输入view
-(SDChatInputView *)chatInputView{
    if (!_chatInputView){
        _chatInputView =[[SDChatInputView alloc]initWithFrame:CGRectMake(0,kScreen_Height-50-mySizeThree(64, 64, 64, 64, 84+34), kScreen_Width, kInputViewHeight)];
        _chatInputView.backgroundColor=[UIColor whiteColor];
        _chatInputView.sd_delegate=self;
    }
    return _chatInputView;
}

-(void)setUI{
    
    [self.view addSubview:self.bjView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.bjView addSubview:self.chatTableView];
    self.chatTableView.dataArray =self.dataArr;
    [self.bjView addSubview:self.chatInputView];
    
    DLog(@"self.view :%@",NSStringFromCGRect(self.bjView.frame));
    DLog(@"chatInputView :%@",NSStringFromCGRect(self.chatInputView.frame));
    DLog(@"chatTableView :%@",NSStringFromCGRect(self.chatTableView.frame));
    
}



#pragma mark - SDChatDetailTableViewDelegate
-(void)SDChatDetailTableView:(id)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.chatInputView.chatText resignFirstResponder];
    [self inputViewScrollToBottom];
}

/**
 键盘消失inputView在屏幕底部
 */
-(void)inputViewScrollToBottom{
    DLog(@"%f    %f",kScreen_Width,kScreen_Height);
    CGFloat chatInputHeight =CGRectGetHeight(self.chatInputView.frame);
    self.chatInputView.frame =CGRectMake(0,kScreen_Height-mySizeThree(64, 64, 64, 64, 84)-(chatInputHeight-keyBoardDefaultHeight)-kSafeAreaBottomHeight, kScreen_Width, chatInputHeight);
     DLog(@"chatInputView---%f",self.chatInputView.height);
    self.chatTableView.frame =CGRectMake(0, 0, kScreen_Width, CGRectGetMinY(self.chatInputView.frame));
     DLog(@"chatTableView---%f",self.chatTableView.height);
    
    [self sd_scrollToBottomWithAnimated:NO];
}


-(void)SDChatDetailTableViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<=0  && self.isRefresh==NO)
    {
        //        [self setChatNetWorkMoreHistoryMsg];
    }
}

#pragma mark - chatInputViewDelegate

/**
 添加文件按钮监听
 
 @param sender  添加文件按钮监听
 */
-(void)SDChatInputViewAddFileClicked:(UIButton *)sender{
    DLog(@"添加图片");
    
   
}


/**
 添加表情按钮监听
 
 @param sender 添加表情按钮监听
 */
-(void)SDChatInputViewAddFaceClicked:(UIButton *)sender{
    DLog(@"添加表情");
    DLog(@"self.frame.input:%@",NSStringFromCGRect(self.chatInputView.frame));
}

-(void)SDChatInputView:(SDChatInputView *)chatInputView sendTextMessage:(NSString *)textMessage{

    NSString *dataMessage = [NSString encodeEmoj:textMessage];
    LKUserInfoModel *model = [LKCustomMethods readUserInfo];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.chat.fromUserId forKey:@"toUserId"];
    [params setObject:@(model.userId) forKey:@"fromUserId"];
    [params setObject:dataMessage forKey:@"message"];
    
    [[LKHttpRequest  request] POST:LKSendMessage parameters:params tag:0 success:^(LKHttpRequest * _Nonnull request, NSInteger tag, NSString * _Nonnull responseString) {
        NSDictionary *requestJson = [LKCustomMethods dictionaryWithJsonString:responseString];
        int successResult  = [[requestJson objectForKey:@"status"] intValue];
        if ( successResult == 1) {
        
        }else {
//            [LKCustomMethods showWindowMessage:[requestJson objectForKey:@"msg"]];
        }
        
    } failure:^(LKHttpRequest * _Nonnull request, NSInteger tag, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
        [LKCustomMethods hideMBMBHUBView:self.view];
    }];
    
    [self.chatTableView reloadData];
    [self sd_scrollToBottomWithAnimated:NO];
    
    
}

-(void)sendMessageData{
    
}

-(void)SDChatInputViewFrameWillChange:(SDChatInputView *)chatInputView{
    DLog(@"-----chatInputView.frame:%@",NSStringFromCGRect(chatInputView.frame))
    DLog(@"-----chatTableView1-----:%@",NSStringFromCGRect(self.chatTableView.frame))
    self.chatTableView.frame =CGRectMake(0, 0, kScreen_Width, CGRectGetMinY(chatInputView.frame));
    [self sd_scrollToBottomWithAnimated:NO];
    DLog(@"-----chatTableView2-----:%@",NSStringFromCGRect(self.chatTableView.frame))
}
#pragma mark - textFieldDelegate

-(void)SDChatDetailTableViewLongPress:(UILongPressGestureRecognizer *)longPressGr{
    
}


#pragma mark - 监听键盘弹出方法
- (void)sd_scrollToBottomWithAnimated:(BOOL)animate
{
    if (!self.dataArr.count) return;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow: self.dataArr.count - 1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath: lastIndexPath atScrollPosition:UITableViewScrollPositionTop animated:animate];
    
}

#pragma mark -右按钮


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [self.view endEditing:YES];
    [self inputViewScrollToBottom];
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
