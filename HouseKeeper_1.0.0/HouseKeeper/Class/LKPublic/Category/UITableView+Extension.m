//
//  UITableView+Extension.m
//  rqbao
//
//  Created by sunny on 2018/1/16.
//  Copyright © 2018年 sunny. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)


+ (UITableView *)createPlainTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [tableView fitSystem];
    return tableView;
}

- (void)fitSystem {
    
//#ifdef __IPHONE_11_0
//    if (RQB_IS_IOS_11) {
//        if (@available(iOS 11.0, *)) {
//            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        } else {
//            // Fallback on earlier versions
//        }
//        self.estimatedSectionHeaderHeight = 0;
//        self.estimatedSectionFooterHeight = 0;
//    }
//#endif
}
- (void)hiddenHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableHeaderView = headerView;
}
- (void)hiddenFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableFooterView = footerView;
}
- (void)hiddenHeaderFooterView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableHeaderView = headerView;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableFooterView = footerView;
}
@end
