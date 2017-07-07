//
//  Uur_UserManager.h
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/7.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Uur_User;
@interface Uur_UserManager : NSObject

+(instancetype)sharedManager;


-(Uur_User *)currentUser;

-(void)updateUser:(Uur_User *)user;

-(BOOL) logout;



@end
