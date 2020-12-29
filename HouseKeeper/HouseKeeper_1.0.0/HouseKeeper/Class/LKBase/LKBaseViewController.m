



//
//  LKBaseViewController.m
//  Project
//
//  Created by heshenghui on 2018/7/1.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKBaseViewController.h"

@interface LKBaseViewController ()

@end

@implementation LKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    LKRequestViewModel *dataSource = [self createDataSource];
    dataSource.vcView = self.view;
    [self setIsExtendLayout:NO];
    [self setNavigationTop];
    [self addCustomBackButton];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.navigationController.viewControllers count] == 1){
        [self hideTabBar:NO animated:NO];
    }
}
- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}
- (void)initializeSelfVCSetting {
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}


#pragma mark - private
#pragma mark- 导航栏设置
-(void)setNavigationTop
{
    //背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Rectangle 81"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //title
    CGFloat font = 19.0f;
    if (LK_IS_IPHONE4) {
        font = 18.0f;
    }
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    
    
}
-(void)setNavBarTitle:(NSString *)navBarTitle
{
    _navBarTitle = navBarTitle;
    self.title = _navBarTitle;
    self.navigationItem.title = _navBarTitle;
}
- (void)addCustomBackButton
{
    if ([self.navigationController.viewControllers count] > 1)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self getBackButton:@"app_icon_back_white"]];
        [self hideTabBar:YES animated:YES];
    }
}
- (UIButton*)getBackButton:(NSString *)backImageName
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0, 20.0f, 44.0f);
    [button setImage:[UIImage imageNamed:backImageName]
            forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(backAction:)
     forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)addBlackBackButton {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self getBackButton:@"app_icon_back_black"]];
    [self hideTabBar:YES animated:YES];
}

-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)hideNavigationBar:(BOOL)isHide
                animated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden=isHide;
        }];
    }
    else{
        self.navigationController.navigationBarHidden=isHide;
    }
}

-(void)hideTabBar:(BOOL)isHide
         animated:(BOOL)animated
{
    /*
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.rDVtabBarController setTabBarHidden:isHide animated:animated];
     */
}

- (UIButton*)addRightNavButtonWithTitle:(NSString*)title
                                 action:(SEL)action
{
    
    UIButton * _rightBtn = [ViewFactory buttonWithFrame:CGRectMake(0, 0, 40, 40) title:title bgImageKey:nil fontSize:14 titleColor:[UIColor whiteColor] target:self action:action];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    return _rightBtn;
}

/**
 * 功能：添加RightNavButton
 * 参数：
 */
- (UIButton*)addRightNavButtonWithImage:(UIImage*)image
                                 action:(SEL)action
{
    UIButton * _rightBtn = [ViewFactory buttonWithFrame:CGRectMake(0, 0, 40, 40) title:@"" bgImageKey:nil fontSize:14 titleColor:[UIColor whiteColor] target:self action:action];
    [_rightBtn setImage:image forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    return _rightBtn;
    
}

- (UIButton*)addLeftNavButtonWithTitle:(NSString*)title
                                action:(SEL)action
{
    UIButton * _leftBtn = [ViewFactory buttonWithFrame:CGRectMake(0, 0, 40, 40) title:title bgImageKey:nil fontSize:14 titleColor:[UIColor whiteColor] target:self action:action];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
    return _leftBtn;
}
- (UILabel*)addLeftNavLabelWithTitle:(NSString*)title
{
    UILabel * _leftLabel = [ViewFactory labelWithTitle:title font:[UIFont boldSystemFontOfSize:15] frame:CGRectMake(0, 0, 80, 40) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftLabel];
    return _leftLabel;
}
- (UIImageView*)addLeftNavImageWithTitle:(NSString*)image
{
    UIImageView * _leftImage = [ViewFactory imageViewWithImage:[UIImage imageNamed:image] frame:CGRectMake(0, 0, 100, 25) round:NO];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftImage];
    return _leftImage;
}

/**
 * 功能：添加RightNavButton
 ：自定义titleView
 * 参数：
 */
- (void)addTitleViewWithTitle:(UIView*)titleView
{
    self.navigationItem.titleView = titleView;
}

//设置为淡白色色背景
- (void)setNavigationBarWhiteBackground {
    UIImage *img=[UIImage imageNamed:@"whiteNav"];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    //title
    CGFloat font = 19.0f;
    if (LK_IS_IPHONE4) {
        font = 18.0f;
    }
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:LKGrayColor,NSFontAttributeName:[UIFont systemFontOfSize:font]}];

}

- (LKRequestViewModel *)createDataSource {
    return [[LKRequestViewModel alloc] init];
}
- (void)dealloc {
    NSLog(@"dealloc -- %@",NSStringFromClass([self class]));
    
}
@end
