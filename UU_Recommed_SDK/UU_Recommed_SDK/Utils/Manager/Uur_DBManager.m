//
//  Uur_DBManager.m
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/7.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import "Uur_DBManager.h"
#import "Uur_User.h"
#import <FMDB/FMDB.h>
#import <MJExtension/MJExtension.h>
@interface Uur_DBManager ()
@property(nonatomic,strong)FMDatabase *db;
@property(nonatomic,strong)FMDatabaseQueue *dbQueue;
@end
@implementation Uur_DBManager

+(instancetype)sharedManager
{
    static Uur_DBManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[Uur_DBManager alloc] init];
    });
    return manager;
}

-(instancetype) init
{
    if (self=[super init]) {
        [self openDB];
        [self initDB];
    }
    return self;
}

-(void)openDB
{
    
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"UUr_iOS.sqlite"];
    NSLog(@"%@", dbPath);
    self.db = [FMDatabase databaseWithPath:dbPath];
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    if (![self.db open]){
        NSLog(@"Could not open db.");
        return ;
    }
}
-(void)initDB
{
    if (![self.db tableExists:@"UUr_User"]) {
        
        [self.db executeUpdate:@"CREATE TABLE UUr_User (Id integer PRIMARY KEY AUTOINCREMENT,userId integer NOT NULL,loginAccount text,loginPwd text,nickName text,accessType boolean,accountStatus boolean,firstLogin boolean,accessToken text,refreshToken text,accessTokenTime text,refreshTokenTime text,realName text,cardNo text,birthday text,gender integer,cardType integer,userHeader text,loginstatus integer,verify_status integer )"];
    }
    if (![self.db tableExists:@"LPayRecord"]) {
        [self.db executeUpdate:@"CREATE TABLE LPayRecord (id integer PRIMARY KEY DEFAULT 0, orderid text, certificate blob, status integer)"];
    }
    
}

-(BOOL)updateUser:(Uur_User *)user
{
    
    FMResultSet *result=  [self.db executeQuery:@"Select * From UUr_User where userId==?",@(user.userId)];
    BOOL success;
    BOOL hasNext = result.next;
    [result close];
    
    if(hasNext)
    {
        
        success=[self.db executeUpdate:@"Update UUr_User set  loginAccount=?,loginPwd=?,nickName=?,accessType=?,accountStatus=?,firstLogin=?,accessToken=?,refreshToken=?,accessTokenTime=?,accessTokenTime=?,birthday=?,gender=?,cardNo=?,cardType=?,userHeader=?,loginstatus=?,realName=?, verify_status=? where userId=?",
                 user.loginAccount,
                 user.loginPwd,
                 user.nickName,
                 @(user.accessType),
                 @(user.accountStatus),
                 @(user.firstLogin),
                 user.accessToken?:@"",
                 user.refreshToken?:@"",
                 user.accessTokenTime?:@"",
                 user.refreshTokenTime?:@"",
                 user.birthday?:@"",
                 @(user.gender),
                 user.cardNo?:@"",
                 @(user.cardType),
                 user.userHeader?:@"",
                 @(user.loginstatus),
                 user.realName?:@"",
                 @(user.verifyStatus),
                 @(user.userId)];
    }
    else{
        success=[self.db executeUpdate:@"INSERT INTO Uur_User (userId,loginAccount,loginPwd,nickName,accessType,accountStatus,firstLogin,accessToken,refreshToken,accessTokenTime,accessTokenTime,birthday,gender,cardNo,cardType,userHeader,loginstatus,realName,verify_status)  values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ",
                 @(user.userId),
                 user.loginAccount,
                 user.loginPwd,
                 user.nickName,
                 @(user.accessType),
                 @(user.accountStatus),
                 @(user.firstLogin),
                 user.accessToken?:@"",
                 user.refreshToken?:@"",
                 user.accessTokenTime?:@"",
                 user.refreshTokenTime?:@"",
                 user.birthday?:@"",
                 @(user.gender),
                 user.cardNo?:@"",
                 @(user.cardType),
                 user.userHeader?:@"",
                 @(1),
                 user.realName?:@""
                 ,
                 @(user.verifyStatus)];
    }
    return success;
}
-(Uur_User *)queryUser
{
    
    FMResultSet *result = [self.db executeQuery:@"SELECT * FROM LUser WHERE loginstatus = ?",@(Uur_UserLoginStatus)];
    Uur_User *user=nil;
    while ([result next]) {
        
        NSDictionary *userDic = @{@"userId":@([result intForColumn:@"userId"]),
                                  @"loginAccount"      : [result stringForColumn:@"loginAccount"],
                                  @"loginPwd"       :@([result intForColumn:@"loginPwd"]),
                                  @"nickName"     :[result stringForColumn:@"nickName"],
                                  @"accessType"       :@([result boolForColumn:@"accessType"]),
                                  @"accountStatus"       :@([result boolForColumn:@"accountStatus"]),
                                  @"firstLogin"         :@([result boolForColumn:@"firstLogin"]),
                                  @"accessToken"         :[result stringForColumn:@"accessToken"],
                                  @"refreshToken"          : [result stringForColumn:@"refreshToken"],
                                  @"accessTokenTime"     :[result stringForColumn:@"accessTokenTime"],
                                  @"refreshTokenTime"   :[result stringForColumn:@"refreshTokenTime"],
                                  @"realName"       :[result stringForColumn:@"realName"],
                                  @"cardNo"     :[result stringForColumn:@"cardNo"],
                                  @"birthday"     :[result stringForColumn:@"birthday"],
                                  @"gender" :@([result intForColumn:@"gender"]),
                                  @"cardType"   :@([result intForColumn:@"cardType"]),
                                  @"userHeader"       :[result stringForColumn:@"userHeader"],
                                  @"verifyStatus":@([result intForColumn:@"verify_status"]),
                                  };
        user = [Uur_User mj_objectWithKeyValues:userDic];
    }
    return user;
}


@end
