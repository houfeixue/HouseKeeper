//
//  LKMyCommunityViewModel.m
//  HouseKeeper
//
//  Created by Lin Hu on 2018/7/31.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKMyCommunityViewModel.h"
#import "LKCommunityCell.h"

@implementation LKMyCommunityViewModel


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"LKCommunityCell";
    LKCommunityCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LKCommunityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.line.hidden = NO;
    cell.titleLable.text = @"测试数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数数";
    cell.rightLable.text = @"测试数";
    cell.tipImage.image = [UIImage imageNamed:@"personalcenter_icon_details"];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row !=2) {
        self.CommunityCellBlock(indexPath);
//    }
}
@end
