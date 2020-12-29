//
//  LKMessageCell.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/8/2.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKMessageCell.h"

@interface LKMessageCell()

// 定义cell内的子控件，用于保存控件，然后进行数据和位置尺寸的计算
/** 发送时间 */
@property(nonatomic, weak) UILabel *timeLabel;

/** 头像 */
@property(nonatomic, weak) UIImageView *iconView;

/** 信息 */
@property(nonatomic, weak) UIButton *textView;

@end

@implementation LKMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - 构造方法
// 自定义构造方法
+ (instancetype) cellWithTableView:(UITableView *) tableView {
    static NSString *ID = @"LKMessageCell";
    
    // 使用缓存池
    LKMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 创建一个新的cell
    if (nil == cell) {
        cell = [[LKMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

// 重写构造方法，创建cell中的各个子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    // 设置cell的背景色
    self.backgroundColor = BACKGROUD_COLOR;
    
    // 1.发送时间
    UILabel *timeLabel = [[UILabel alloc] init];
    [timeLabel setTextAlignment:NSTextAlignmentCenter];
    [timeLabel setFont:LK_10font];
    [timeLabel setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 2.头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    // 3.信息
    UIButton *textView = [[UIButton alloc] init];
    [textView setTitle:@"text" forState:UIControlStateNormal];
    [textView.titleLabel setFont:LK_14font];
    
    // 3.1 如果是浅色背景，记得设置字体颜色，因为按钮的字体颜色默认是白色
    [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [textView.titleLabel setNumberOfLines:0]; // 设置自动换行
    
    // 3.2 调整文字的内边距
    textView.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [self.contentView addSubview:textView];
    self.textView = textView;
    
    return self;
}

#pragma mark - 加载数据
// 加载frame，初始化cell中子控件的数据、位置尺寸
- (void)setMessageFrame:(LKMessageFrame *) messageFrame {
    _messageFrame = messageFrame;
    
    // 1.发送时间
    self.timeLabel.text = messageFrame.message.time;
    self.timeLabel.frame = messageFrame.timeFrame;
    
    // 2.头像
    NSString *icon = (messageFrame.message.type == MessageTypeMe)? @"homePicDefault":@"other";
    self.iconView.image = [UIImage imageNamed:icon];
    self.iconView.frame = messageFrame.iconFrame;
    
    // 3.信息
    [self.textView setTitle:messageFrame.message.text forState:UIControlStateNormal];
    self.textView.frame = messageFrame.textFrame;
    
    // 3.1 设置聊天框
    NSString *chatImageNormalName;
    NSString *chatImageHighlightedName;
    if (MessageTypeMe == messageFrame.message.type) {
        chatImageNormalName = @"chat_send_nor";
        chatImageHighlightedName = @"chat_send_press_pic";
    } else {
        chatImageNormalName = @"chat_recive_nor";
        chatImageHighlightedName = @"chat_receive_press_pic";
    }
    
    UIImage *chatImageNormal = [UIImage resizebleImageNamed:chatImageNormalName];
    UIImage *chatImageHighlighted = [UIImage resizebleImageNamed:chatImageHighlightedName];
    [self.textView setBackgroundImage:chatImageNormal forState:UIControlStateNormal];
    [self.textView setBackgroundImage:chatImageHighlighted forState:UIControlStateHighlighted];
}


@end
