//
//  LKCareTitleView.h
//      
//
//  Created by heshenghui on 2018/3/12.
//

#import <UIKit/UIKit.h>
typedef void(^CareLeftClick)(NSString * status);
typedef void(^CareRightClick)(NSString * status);


@interface LKUpdateVersion : UIView

{
    NSString * _titleStr;
    NSString * _contentStr;
    NSString *  _update;


}

@property (nonatomic,strong)UIView * whiteView;
@property(nonatomic,strong)UIImageView * picImageView;
@property(nonatomic,strong)UILabel * titleLabel;//版本

@property(nonatomic,strong)UILabel * care1Label;//版本提示


@property(nonatomic,strong)UIScrollView * scrollView;//更新内容容器
@property(nonatomic,strong)UILabel * care2Label;//版本提示
@property(nonatomic,strong)UILabel * nameLabel;//更新内容



@property(nonatomic,strong)UIButton * leftBtn;
@property(nonatomic,strong)UIButton * rightBtn;
@property(nonatomic,copy)CareLeftClick careLeftClick;
@property(nonatomic,copy)CareRightClick careRightClick;


- (instancetype)initWithTitle:(NSString *)titleStr withContent:(NSString *)content withUpdate:(NSString *)update;
-(void)show;
-(void)dismiss;
@end
