//
//  LKAlumbsViewModel.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/25.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKAlumbsViewModel.h"
#import "LKAlumbVIewCell.h"
@implementation LKAlumbsViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    __weak __typeof(self) weakself= self;
    dispatch_async(dispatch_queue_create(0, 0), ^{
        [weakself.dataArray removeAllObjects];
        NSArray *alumbArray = [[LKPictureDBManager shareManager]fetchAlumbData];
        LKTableSectionObject * section = [[LKTableSectionObject alloc]init];
        
        for (int i=0; i<alumbArray.count; i++) {
            section.itemArray = [NSMutableArray arrayWithArray:[[LKPictureDBManager shareManager]fetchAlumbData]] ;
        }
        [weakself.dataArray addObject:section];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 通知主线程刷新 
            [self.cellClickSubject sendNext:@"mainViewRolad"];
            
        });
    });

}

#pragma mark table -delegate


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* cellIdentifier = [NSString stringWithFormat:@"%@", @"LKAlumbVIewCell"];
    LKAlumbVIewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
        [cell conFigCellwithData:[sectionObject.itemArray objectAtIndex:indexPath.row] atIndex:indexPath];
    cell.separatorView.hidden = NO;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    LKAlumbModel * model = [sectionObject.itemArray objectAtIndex:indexPath.row];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"goDetail" forKey:@"type"];
    [dict setObject:model.name forKey:@"name"];
    [dict setObject:model.categoryId forKey:@"categoryId"];
    [dict setObject:model forKey:@"data"];

    [self.cellClickSubject sendNext:dict];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
