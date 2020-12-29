//
//  LKPictureDBManager.m
//  HouseKeeper
//
//  Created by heshenghui on 2018/7/12.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKPictureDBManager.h"

@implementation LKPictureDBManager
{
    FMDatabase *_dataBase;
    NSLock *_lock;
}
static LKPictureDBManager *manager=nil;

+(LKPictureDBManager *)shareManager{
    @synchronized(self){
        
        if (manager==nil) {
            manager=[[LKPictureDBManager alloc]init];
        }
    }
    return manager;
}
-(id)init
{
    self=[super init];
    if (self) {
        _lock=[[NSLock alloc]init];
        
        LKUserInfoModel * model = [LKCustomMethods readUserInfo];

        
        _dataBase=[[FMDatabase alloc]initWithPath:LKPhotoAlbumoPath];
        DLog(@"LKPhotoAlbumoPath : %@",LKPhotoAlbumoPath);
        BOOL isSuccessed=[_dataBase open];
        if (isSuccessed==NO) {
            NSLog(@"%@",_dataBase.lastErrorMessage);
        }else
        {
            NSArray *alumbSArray = [UserDefaultsHelper getArrayForKey:LKUser_Alumb];
            for (int i=0; i<alumbSArray.count; i++) {
                //
                NSDictionary * dict = [alumbSArray objectAtIndex:i];
                NSString *categoryId = [NSString stringWithFormat:@"lk%@%@",[NSString stringWithFormat:@"%d",model.userId],[dict objectForKey:@"categoryId"]];

                NSString *creatSpl= [NSString stringWithFormat:@"create table if not exists %@(picName text , des text,time text,area text )",categoryId];
                BOOL isCreateSuccessed=[_dataBase executeUpdate:creatSpl];
                if (isCreateSuccessed==NO) {
                    NSLog(@"创建%@",_dataBase.lastErrorMessage);
                }else
                {
                    NSLog(@"创建:YES");
                }
            }
        }
    }
    return self;
}

/*
 插入 相册数据
 */
-(BOOL)insertDataWithAlumbName:(NSString *)alumbId withData:(LKPictureModel *)model
{
    [_lock lock];
    LKUserInfoModel * usermodel = [LKCustomMethods readUserInfo];

    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSString *dateString =  [NSString stringWithFormat:@"%f",[currentDate timeIntervalSince1970]];//
    NSString *insertSql=[NSString stringWithFormat:@"insert into lk%@%@(picName,des,time,area) values(?,?,?,?)",[NSString stringWithFormat:@"%d",usermodel.userId],alumbId];
    
    BOOL isInsertSussessed=[_dataBase executeUpdate:insertSql,[NSString stringWithFormat:@"%@.jpg",dateString],model.des,model.time,model.area];
    if (isInsertSussessed==NO) {
        NSLog(@"插入alumbId ：%@ - %@",alumbId,_dataBase.lastErrorMessage);
    }else{
        DLog(@"插入 alumbId:%@ 成功",alumbId);
        
//        UIImage *image = [UIImage imageNamed:@"message_highlight"];
        [[LKImageFileManager shareManager]saveImageToPicture:model.image withImageName:dateString mergeModel:model];
        
    }
    [_lock unlock];
    return isInsertSussessed;
    
}

/*
 删除
 */
-(void)deleteDataWithAlumbName:(NSString *)alumbId withData:(LKPictureModel *)model
{
    [_lock lock];
    LKUserInfoModel * userdeletemodel = [LKCustomMethods readUserInfo];

    NSString *deleteSql=[NSString stringWithFormat:@"delete from lk%@%@ where picName=?",[NSString stringWithFormat:@"%d",userdeletemodel.userId],alumbId];
    BOOL isdes=[_dataBase executeUpdate:deleteSql,model.picName];
    if (isdes==NO) {
        NSLog(@" 删除 %@",_dataBase.lastErrorMessage);
    }else{
        DLog(@"删除 alumbId:%@ 成功",alumbId);
        [[LKImageFileManager shareManager]deleteImageToPictureName:model.picName];
        
    }
    [_lock unlock];
    
}
-(BOOL )deleteDataWithAlumbName:(NSString *)alumbId withArray:(NSArray<LKPictureModel *> *)array
{
    [_lock lock];
    BOOL isRollBack = NO;
    LKUserInfoModel * userdelete2model = [LKCustomMethods readUserInfo];

    @try {
        [_dataBase beginTransaction];
        for (int i=0; i<array.count; i++) {
            LKPictureModel * model = [array objectAtIndex:i];
            NSString *deleteSql= [NSString stringWithFormat:@"delete from lk%@%@ where picName=?",[NSString stringWithFormat:@"%d",userdelete2model.userId],alumbId];
            BOOL isDeleteSuccessed=[_dataBase executeUpdate:deleteSql,model.picName];
            if (!isDeleteSuccessed) {
                NSLog(@"Delete Error:%@",_dataBase.lastErrorMessage);
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"error:%@",exception.reason);
        isRollBack=YES;
        [_dataBase rollback];
    } @finally {
        [_dataBase commit];
    }
    [_lock unlock];
    return !isRollBack;
    
}
/*
 转移表数据
 */
-(BOOL )deleteDataWithAlumbName:(NSNumber *)alumbId withData:(NSArray *)array insertToAlumbname:(NSNumber *)newAlumbId
{
    [_lock lock];
    //手动开启事务
    BOOL isRollBack = NO;
    LKUserInfoModel * userdelete2model = [LKCustomMethods readUserInfo];

    @try {
        [_dataBase beginTransaction];
        if ([alumbId isEqualToNumber:newAlumbId]) {
            for (int i=0; i<array.count; i++) {
                LKPictureModel * model = [array objectAtIndex:i];
                NSString *updateString = [NSString stringWithFormat:@"update lk%@%@ set des = ?,time = ?,area = ?  where picName = ?",[NSString stringWithFormat:@"%d",userdelete2model.userId],newAlumbId];
                BOOL isUpdateSuccessed=[_dataBase executeUpdate:updateString,model.des,model.time,model.area,model.picName];
                
                if (!isUpdateSuccessed) {
                    NSLog(@"insert Error:%@",_dataBase.lastErrorMessage);
                }
            }
        }else {
            for (int i=0; i<array.count; i++) {
                LKPictureModel * model = [array objectAtIndex:i];
    //            NSString *insertSql= [NSString stringWithFormat:@"insert into lk%@ (picName) values(?)",newAlumbId];
                NSString *insertSql=[NSString stringWithFormat:@"insert into lk%@%@ (picName,des,time,area) values(?,?,?,?)",[NSString stringWithFormat:@"%d",userdelete2model.userId],newAlumbId];
                NSString *deleteSql= [NSString stringWithFormat:@"delete from lk%@%@ where picName=?",[NSString stringWithFormat:@"%d",userdelete2model.userId],alumbId];
    //            BOOL isInsertSuccessed=[_dataBase executeUpdate:insertSql,model.picName];
                BOOL isInsertSuccessed=[_dataBase executeUpdate:insertSql,model.picName,model.des,model.time,model.area];

                BOOL isDeleteSuccessed=[_dataBase executeUpdate:deleteSql,model.picName];
                if (!isInsertSuccessed) {
                    NSLog(@"insert Error:%@",_dataBase.lastErrorMessage);
                }
                if (!isDeleteSuccessed) {
                    NSLog(@"Delete Error:%@",_dataBase.lastErrorMessage);
                }
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"error:%@",exception.reason);
        isRollBack=YES;
        [_dataBase rollback];
    } @finally {
        [_dataBase commit];
    }
    
    
    
    
    [_lock unlock];
    return !isRollBack;
}

/*
 获取相册全部数据
 */
-(NSArray *)fetchAllAlumbName:(NSString *)alumbName
{
    [_lock lock];
    LKUserInfoModel * userfetchmodel = [LKCustomMethods readUserInfo];

    NSString *select= [NSString stringWithFormat:@"select *from lk%@%@",[NSString stringWithFormat:@"%d",userfetchmodel.userId],alumbName] ;
    FMResultSet *set=[_dataBase executeQuery:select];
    NSMutableArray *array=[[NSMutableArray alloc]init];
    while ([set next]) {
        
        LKPictureModel *model = [[LKPictureModel alloc]init];
        model.picName = [set stringForColumn:@"picName"];
        model.time = [set stringForColumn:@"time"];
        model.area = [set stringForColumn:@"area"];
        model.des = [set stringForColumn:@"des"];
        model.timeStr = [LKCustomMethods timeStrFormTime:[model.time longLongValue] withFormatter:@"YYYY年M月d日"];
        [array addObject:model];
    }
    [_lock unlock];
    
    return array;

}


/*
 删除相册全部数据
 */
-(void)deleteDataWithAlumbName:(NSString *)alumbId
{
    [_lock lock];
    LKUserInfoModel * userdelete3model = [LKCustomMethods readUserInfo];

    NSString *deleteSql= [NSString stringWithFormat:@"delete from lk%@%@",[NSString stringWithFormat:@"%d",userdelete3model.userId],alumbId] ;
    BOOL isdes=[_dataBase executeUpdate:deleteSql];
    if (isdes==NO) {
        NSLog(@"%@",_dataBase.lastErrorMessage);
    }
    [_lock unlock];
}

/*
 更新数据库
 */
-(void)updateDataWithAlumbName:(NSString *)alumbId withData:(LKPictureModel *)model
{
    [_lock lock];
    
    
    
    [_lock unlock];

}

/*
 获取所有相册列表信息
 */
-(NSMutableArray *)fetchAlumbData
{
    [_lock lock];
    LKUserInfoModel * fetchAlumb2model = [LKCustomMethods readUserInfo];

    NSArray *alumbSArray = [UserDefaultsHelper getArrayForKey:LKUser_Alumb];
    NSMutableArray * dataArray = [[NSMutableArray alloc]init];

    for(int i=0;i<alumbSArray.count;i++){
        NSDictionary * dict = [alumbSArray objectAtIndex:i];
        NSString *categoryName = [dict objectForKey:@"categoryName"];
        NSString *categoryId = [dict objectForKey:@"categoryId"];
        NSString *alumbName = [NSString stringWithFormat:@"select count(*) from lk%@%@",[NSString stringWithFormat:@"%d",fetchAlumb2model.userId],categoryId];
        NSUInteger count = [_dataBase intForQuery:alumbName];
        if(count > 0){
           NSString *select= [NSString stringWithFormat:@"select * from lk%@%@ order by time desc LIMIT 1",[NSString stringWithFormat:@"%d",fetchAlumb2model.userId],categoryId] ;

            FMResultSet *set=[_dataBase executeQuery:select];
            while ([set next]) {
                
                LKAlumbModel *model = [[LKAlumbModel alloc]init];
                model.count = @(count);
                model.categoryId = @([categoryId integerValue]);
                model.name = categoryName;
                model.pic = [set stringForColumn:@"picName"];;
                [dataArray addObject:model];
            }
        }else{
            LKAlumbModel *model = [[LKAlumbModel alloc]init];
            model.pic = LKPicture_Default;
            model.count = @(count);
            model.categoryId = @([categoryId integerValue]);
            model.name = categoryName;
            [dataArray addObject:model];
            
        }
    }
    [_lock unlock];

    return dataArray;

}

/*
 获取某个相册个数
 */
-(NSInteger)fetchAlumbCountFromCategory:(NSNumber *)categoryId
{
    [_lock lock];
    LKUserInfoModel * fetchAlumb3model = [LKCustomMethods readUserInfo];

    NSString *alumbName = [NSString stringWithFormat:@"select count(*) from lk%@%@",[NSString stringWithFormat:@"%d",fetchAlumb3model.userId],categoryId];
    NSUInteger count = [_dataBase intForQuery:alumbName];
    [_lock unlock];

    return count;
}

//编辑相册图片
-(BOOL)editDataWithAlumbName:(NSString *)alumbId withPicModel:(LKPictureModel *)model
{
    [_lock lock];
 
    [self deleteDataWithAlumbName:alumbId withData:model];
    BOOL edit = [self insertDataWithAlumbName:alumbId withData:model];
    
    
    [_lock unlock];
    return edit;
}

@end
