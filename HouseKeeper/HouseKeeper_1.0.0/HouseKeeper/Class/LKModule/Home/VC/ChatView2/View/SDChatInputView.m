//
//  SDChatInputView.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/15.
//  Copyright © 2017年 SlowDony. All rights reserved.
//
/*
 
 目前实现
 
 基本聊天对话业务,
 聊天对话UI布局,
 表情键盘弹出,
 支持emoji表情.
 待完成
 
 图文混排,
 表情键盘弹出的优化,
 支持png格式表情,
 拍照上传图片.
 未来
 
 完善SDChat
 我的邮箱:devslowdony@gmail.com
 
 项目更新地址 GitHub:https://github.com/SlowDony/SDChat
 
 
 如果有好的建议或者意见 ,欢迎指出 , 您的支持是对我最大的鼓励,谢谢. 求STAR ..😆
 */



#import "SDChatInputView.h"
#import "NSString+Emoji.h"
//#import "SDFaceModel.h"

static CGFloat systemkeyBoardHeight = 0;
static CGFloat inputViewDefaultHeight =50; //输入框默认高度
static CGFloat chatTextInputHeight  =40; //默认输入框的高度

@interface SDChatInputView () <UITextViewDelegate>

//记录系统键盘和自定义键盘高度

@property (nonatomic,strong)UIButton *failBtn; /// 发送按钮
@property (nonatomic,strong)UIView *bottomline;

/**
 输入框容器,(存放输入框,添加表情按钮和添加表情按钮)
 */
@property (nonatomic,strong)UIView *inputViewContainer;



@end

@implementation SDChatInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        SDLog("retain count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(self)));
        DLog(@"self.frame =:%@",NSStringFromCGRect(self.frame));
        [self setUI];
        [self addNotification];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


/**
 添加通知(监听选择表情,删除表情,发送表情)
 */
- (void)addNotification
{
    DLog(@"添加通知");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessage) name:SDFaceDidSendNotification object:nil];
}

-(void)dealloc{
     [self.chatText removeObserver:self forKeyPath:SDInputViewTextContentSize];

}




/**
 系统键盘弹起通知

 */
-(void)systemKeyboardWillShow:(NSNotification *)notification{
    
    //获取键盘的高度
    CGFloat systemKeyBoardHeight =[notification.userInfo[@"UIKeyboardBoundsUserInfoKey"]CGRectValue].size.height;
    //记录系统键盘的高度
    systemkeyBoardHeight =systemKeyBoardHeight;
    
    //当前的chatInputView高度
    CGFloat inputViewHeight =CGRectGetHeight(self.inputViewContainer.frame);
    //将自定义键盘位移
    [self customKeyboardMove:kScreen_Height -systemKeyBoardHeight-inputViewHeight];
    
    if ([self.sd_delegate respondsToSelector:@selector(SDChatInputViewFrameWillChange:)]){
        [self.sd_delegate SDChatInputViewFrameWillChange:self];
    }
}


/**
 键盘降落

 @param notification 通知
 */
-(void)keyboardResignFirstResponder:(NSNotification *)notification{
    [self.chatText resignFirstResponder];
    //按钮初始化刷新
    [self customKeyboardMove:kScreen_Height - inputViewDefaultHeight];
   
}


/**
 输入框容器
 */
-(UIView *)inputViewContainer{
    if (!_inputViewContainer){
        _inputViewContainer =[[UIView alloc]init];
        _inputViewContainer.frame =CGRectMake(0,0,kScreen_Width, inputViewDefaultHeight);
        
        UIView *line = [[UIView alloc] init];
        line.frame = CGRectMake(0, 0, kScreen_Width, 0.5);
        line.backgroundColor = [UIColor lightGrayColor];
        [_inputViewContainer addSubview:line];
        [_inputViewContainer addSubview:self.chatText];
        [_inputViewContainer addSubview:self.failBtn];
        //添加图片
        UIView *bottomline = [[UIView alloc] init];
        bottomline.frame = CGRectMake(0, inputViewDefaultHeight-1, kScreen_Width, 0.5);
        bottomline.backgroundColor = [UIColor lightGrayColor];
        self.bottomline =bottomline;
        [_inputViewContainer addSubview:bottomline];
        
    }
    return _inputViewContainer;
}



//聊天输入框
-(UITextView *)chatText{
    if (!_chatText) {
        _chatText =[[UITextView alloc]init];
        _chatText.frame =CGRectMake(10,(inputViewDefaultHeight-chatTextInputHeight)/2, kScreen_Width-80,chatTextInputHeight);
        _chatText.delegate=self;
        _chatText.backgroundColor = [UIColor whiteColor];
        _chatText.textColor = LKBlackColor;
        _chatText.returnKeyType=UIReturnKeySend;
        _chatText.enablesReturnKeyAutomatically = YES;
        
        _chatText.textAlignment = NSTextAlignmentLeft;
        _chatText.font = [UIFont systemFontOfSize:17];
        
        _chatText.layer.cornerRadius=4;
        _chatText.layer.borderColor=[UIColor lightGrayColor].CGColor;
        _chatText.layer.borderWidth=0.8;
        _chatText.layer.masksToBounds=YES;
        //观察输入框的高度变化(contentSize)
       [_chatText addObserver:self forKeyPath:SDInputViewTextContentSize options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        

    }
    return _chatText;
}



/**
 添加图片.等文件
 */
-(UIButton *)failBtn{
    if (!_failBtn){
        _failBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _failBtn.frame = CGRectMake(kScreen_Width-40-10,(inputViewDefaultHeight-30)/2,40, 30);
        [_failBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_failBtn setTitleColor:LKCrownColor forState:UIControlStateNormal];
        [_failBtn.titleLabel setFont:LK_16font];
        
        _failBtn.tag=1002;
        [_failBtn  addTarget:self action:@selector(failBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _failBtn;
}
-(void)setUI{
   
    self.backgroundColor=LKBlackColor;
//  输入框
    [self addSubview:self.inputViewContainer];
    
}


/**
 观察输入框的高度变化
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    CGFloat oldHeight =[change[@"old"]CGSizeValue].height;
    CGFloat newheight =[change[@"new"]CGSizeValue].height;
    
    if (oldHeight<=0||newheight<=0) return;
    
    if (newheight!=oldHeight) {

        if (newheight>100){
            newheight=100;
        }
        
        CGFloat inputHeight = newheight>chatTextInputHeight ? newheight:chatTextInputHeight;
        DLog(@"inputHeight:%f",inputHeight);
        
        [self chatTextViewHeightFit:inputHeight];
    }
}

-(void)chatTextViewHeightFit:(CGFloat ) height{
    
    [UIView animateWithDuration:0.3 animations:^{
        
       
        DLog(@" self.frame:%@",NSStringFromCGRect(self.frame));
        
        CGFloat inputH =height+inputViewDefaultHeight-chatTextInputHeight;
        
        self.inputViewContainer.frame =CGRectMake(0, 0, kScreen_Width,inputH);
        
        
        self.chatText.frame =CGRectMake(10,(inputH-height)/2, kScreen_Width-80,height);
        self.bottomline.frame =CGRectMake(0, inputH-1, kScreen_Width, 0.5);
        self.failBtn.frame = CGRectMake(kScreen_Width-40-10,(inputH-30-10),40, 30);
        DLog(@" self.inputViewContainer.frame:%@",NSStringFromCGRect(self.inputViewContainer.frame));
        self.frame =CGRectMake(0,kScreen_Height-mySizeThree(64, 64, 64, 64, 84)-systemkeyBoardHeight-inputH , kScreen_Width,inputH+keyBoardDefaultHeight);
        
        if ([self.sd_delegate respondsToSelector:@selector(SDChatInputViewFrameWillChange:)]){
            [self.sd_delegate SDChatInputViewFrameWillChange:self];
        }
        
    }];
}


/**
 图片按钮点击

 @param failBtn 添加图片按钮
 */
-(void)failBtnClicked:(UIButton *)failBtn{
    if(self.chatText.text.length != 0){
       [self   sendMessage];
       
        
    }   
}




#pragma mark - 自定义键盘位移变化
- (void)customKeyboardMove:(CGFloat)customKbY
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, customKbY -mySizeThree(64, 64, 64, 64, 84) , kScreen_Width, CGRectGetHeight(self.frame));
        DLog(@"self.frame:%@",NSStringFromCGRect(self.frame));
    }];
}

#pragma mark - textView代理
- (void) textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 1000) { // 限制5000字内
        textView.text = [textView.text substringToIndex:1000];
    }
   
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
   
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    
    if ([text isEqualToString:@"\n"]){
        [self sendMessage];
        return NO;
    }
    return YES;
}


/**
 发送消息
 */
-(void)sendMessage{
    if (self.chatText.text.length > 0) {     // send Text
        if ([self.sd_delegate respondsToSelector:@selector(SDChatInputView:sendTextMessage:)]){
            [self.sd_delegate SDChatInputView:self sendTextMessage:self.chatText.text];
        }
    }
    [self.chatText setText:@""];
}
@end
