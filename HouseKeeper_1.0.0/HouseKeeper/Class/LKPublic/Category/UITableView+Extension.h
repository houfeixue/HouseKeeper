//
//  UITableView+Extension.h
//  rqbao
//
//  Created by sunny on 2018/1/16.
//  Copyright © 2018年 sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Extension)
+ (UITableView *)createPlainTableView ;
- (void)fitSystem ;
- (void)hiddenHeaderView ;
- (void)hiddenFooterView ;
- (void)hiddenHeaderFooterView;
@end
