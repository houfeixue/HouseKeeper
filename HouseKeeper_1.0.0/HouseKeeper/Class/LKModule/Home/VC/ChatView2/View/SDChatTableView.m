//
//  SDChatTableView.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/15.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatTableView.h"
#import "SDChatTableViewCell.h"

#import "SDChat.h"
@implementation SDChatTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self =[super initWithFrame:frame style:style];
    if (self) {
        self.dataSource=self;
        self.delegate=self;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.backgroundColor =  LKF2Color;
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
}
#pragma mark ----------UITabelViewDataSource----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.dataArray count];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return  [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     return  [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    SDChatTableViewCell *cell =[SDChatTableViewCell cellWithTableView:self];
    cell.backgroundColor = [UIColor whiteColor];
    SDChat * chatModel =self.dataArray[indexPath.row];
    [cell setValueWithChatModel:chatModel];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.sd_delegate respondsToSelector:@selector(SDChatTableView:didSelectRowAtIndexPath:)]) {
        [self.sd_delegate SDChatTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark ----------UITabelViewDelegate----------


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
@end
