
//
//  Uur_UserManager.m
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/7.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import "Uur_UserManager.h"
#import "Uur_User.h"
#import "Uur_DBManager.h"

@interface Uur_UserManager ()

@property(nonatomic,strong)Uur_User *user;

@end
@implementation Uur_UserManager


+(instancetype)sharedManager
{
    static Uur_UserManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[Uur_UserManager alloc] init];
    });
    return  manager;
}

-(Uur_User *)currentUser
{
    if (!self.user) {
        self.user=[[Uur_DBManager   sharedManager] queryUser];
    }
    return  self.user;
    
    return nil;
    
}


-(void)updateUser:(Uur_User *)user{
    [[Uur_DBManager sharedManager]updateUser:user];
    self.user=[[Uur_DBManager   sharedManager] queryUser];
}
-(BOOL)logout{
    self.user.loginstatus =  Uur_UserLoginoutStatus;
    BOOL success =   [[Uur_DBManager sharedManager]updateUser:self.user];
    if (success) {
        self.user = nil;
    }else{
        self.user.loginstatus = Uur_UserLoginStatus;
    }
    return success;
}

@end
