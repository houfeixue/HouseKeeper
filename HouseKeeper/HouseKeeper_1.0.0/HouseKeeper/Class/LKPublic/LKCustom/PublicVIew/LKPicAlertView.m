//
//  LKPicAlertView.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/8/10.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPicAlertView.h"

@implementation LKPicAlertView


static LKPicAlertView *manager=nil;

+(LKPicAlertView *)shareManager{
    @synchronized(self){
        
        if (manager==nil) {
            manager=[[LKPicAlertView alloc]init];
        }
    }
    return manager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}
-(void)show
{
    
    
    
}
@end
