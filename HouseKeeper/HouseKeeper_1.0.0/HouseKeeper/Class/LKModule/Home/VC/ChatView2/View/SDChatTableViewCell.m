//
//  SDChatTableViewCell.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/15.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatTableViewCell.h"
#import "SDChat.h"
#import "NSString+Emoji.h"

@implementation SDChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellId = @"SDChatTableViewCellId";
    SDChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell =[[SDChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    //头像
    UIImageView *headImage = [[UIImageView alloc] init];
    self.headImage=headImage;
    headImage.layer.cornerRadius = 25;
    headImage.clipsToBounds = YES;
    headImage.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).inset(LKLeftMargin);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(50);
    }];
    
    /// 时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textColor =LKGrayColor;
    timeLabel.text = @"2017-02-02";
    timeLabel.font = LK_9font;
    timeLabel.textAlignment=NSTextAlignmentRight;
    timeLabel.numberOfLines = 0;
    self.timeLabel=timeLabel;
    [self addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(LKLeftMargin);
        make.top.equalTo(self.mas_top).inset(17);
    }];
    
    //标题昵称
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor =LKGrayColor;
    titleLabel.font = LK_15font;
    titleLabel.numberOfLines = 0;
    self.titleLabel=titleLabel;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImage.mas_right).inset(9);
        make.right.equalTo(timeLabel.mas_left).inset(5);
        make.top.equalTo(headImage.mas_top).inset(5);
        make.height.mas_greaterThanOrEqualTo(20);
        
    }];
    
    /// 未读消息
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.backgroundColor = [UIColor redColor];
    numLabel.textColor =[UIColor whiteColor];
    numLabel.font = LK_9font;
    numLabel.textAlignment=NSTextAlignmentCenter;
    numLabel.numberOfLines = 0;
    numLabel.layer.cornerRadius=9;
    numLabel.layer.masksToBounds=YES;
    self.numLabel=numLabel;
    [self addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(LKLeftMargin);
        make.top.equalTo(timeLabel.mas_bottom).inset(5);
        make.width.height.mas_equalTo(18);
    }];
    
    //// 内容
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.textColor =LK99Color;
    detailLabel.font = LK_13font;
    self.detailLabel=detailLabel;
    [self addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_left);
        make.right.equalTo(numLabel.mas_left).inset(5);
        make.top.equalTo(titleLabel.mas_bottom).inset(5);
    }];
    
    
   
    
    
}

-(void)setValueWithChatModel:(SDChat *)chat{
    if ([chat.portrait containsString:@"group"]) {
        NSString *urltring = [NSString stringWithFormat:@"%@%@",LKIconHost,chat.portrait];
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:urltring] placeholderImage:[UIImage imageNamed:@"homePicDefault"]];
    }else{
        NSString *urltring = [NSString stringWithFormat:@"%@%@",LKPHPIconHost,chat.portrait];
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:urltring] placeholderImage:[UIImage imageNamed:@"homePicDefault"]];
    }
    

    if (chat.isONLine) //在线
    {
        self.headImage.alpha=1;
    }else //离线
    {
        self.headImage.alpha=0.2;
    }
    self.titleLabel.text=chat.fromUserName;
    NSString *contentString = [NSString decodeEmoj:chat.lastMessage];
    self.detailLabel.text=contentString;
    self.timeLabel.text =chat.lastTime;
    if (chat.unReadNumber >0) {
        self.numLabel.hidden = NO;
        self.numLabel.text = [NSString stringWithFormat:@"%ld",(long)chat.unReadNumber] ;
    }else{
        self.numLabel.hidden = YES;
    }
    
}
@end
