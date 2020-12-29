//
//  SDChatHistoryTableView.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/8/9.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "SDChatHistoryTableView.h"
#import "SDChatDetailTableViewCell.h"
#import "SDChatDetailFrame.h"
#import "SDChatDetail.h"
#import "SDChatMessage.h"

@interface SDChatHistoryTableView()

@end
@implementation SDChatHistoryTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self =[super initWithFrame:frame style:style];
    if (self) {
        self.dataSource=self;
        self.delegate=self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = LKF2Color;
    }
    return self;
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDChatDetailTableViewCell *cell =[SDChatDetailTableViewCell cellWithTableView:self];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    SDChatDetailFrame *chatFrame =self.dataArray[indexPath.row];
    cell.chatFrame=chatFrame;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)statusChanged:(SDChatDetailFrame *)detailFrame
{
    [self.dataArray removeObject:detailFrame];
    [self beginUpdates];
    [self endUpdates];
}

-(BOOL)canBecomeFirstResponder{
    return YES;
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    UIMenuController * menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];
}

-(void)SDChatDetailTableViewCellContentClick{
    DLog(@"点击按钮");
    UIMenuController * menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];
    
}
#pragma mark ----------UITabelViewDelegate----------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray[indexPath.row] cellH];
}




@end
