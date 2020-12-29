//
//  LKCheckSearchCommunityViewModel.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/22.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKCheckSearchCommunityViewModel.h"
#import "LKSearchCommunityListModel.h"


@implementation LKCheckSearchCommunityViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    _selectCommunityArray = [NSMutableArray array];
    _selectCommunitySubject = [RACSubject subject];
}

-(void)bindDataWithSelectArray:(NSMutableArray *)selectCommunityModelArray{
    self.selectCommunityArray = selectCommunityModelArray;
    LKTableSectionObject * sectionObject = [[LKTableSectionObject alloc] init];

    for (NSInteger i = 0; i < selectCommunityModelArray.count; i++) {
        LKSearchCommunityModel *model = [selectCommunityModelArray objectAtIndex:i];
        [sectionObject.itemArray addObject:model];
    }
    [self.dataArray addObject:sectionObject];
    [self.cellClickSubject sendNext:@"reload"];
    
}

#pragma mark table -delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:section];
    return sectionObject.itemArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LKCheckSearchCommunityCell *cell = [LKCheckSearchCommunityCell cellForTableView:tableView reuseIdentifier:@"LKCheckSearchCommunityCell"];
    LKTableSectionObject * sectionObject = [self.dataArray objectAtIndex:indexPath.section];
    [cell conFigCellwithData:sectionObject.itemArray[indexPath.row] atIndex:indexPath];
    @weakify(self);
    cell.deleteBtnClick = ^(LKSearchCommunityModel *deleteCommunityModel) {

        @strongify(self);
        [sectionObject.itemArray removeObject:deleteCommunityModel];
        [self.dataArray replaceObjectAtIndex:indexPath.section withObject:sectionObject];
        self.selectCommunityArray = sectionObject.itemArray;
        [self.selectCommunitySubject sendNext:self.selectCommunityArray];
    };
    return cell;
    
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    LKTableSectionObject * section = [self.dataArray objectAtIndex:indexPath.section];
//    id model = [section.itemArray objectAtIndex:indexPath.row];
//    
//    //    [self.cellClickSubject sendNext:model];
//    
//    [self.cellClickSubject sendNext:@"reload"];
//    
//}
@end
