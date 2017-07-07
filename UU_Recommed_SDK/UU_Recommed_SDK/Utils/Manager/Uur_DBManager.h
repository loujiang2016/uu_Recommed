//
//  Uur_DBManager.h
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/7.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Uur_User;
@interface Uur_DBManager : NSObject

+(instancetype)sharedManager;

/**
 * User相关
 */
-(BOOL)updateUser:(Uur_User *)user;

-(Uur_User *)queryUser;
@end
