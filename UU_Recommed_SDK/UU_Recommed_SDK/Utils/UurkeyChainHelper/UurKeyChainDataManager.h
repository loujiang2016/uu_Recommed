//
//  UurKeyChainDataManager.h
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/7.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UurKeyChainDataManager : NSObject

/**
 *存储UUID
 *
 */
+(void)saveUUID:(NSString *)UUID;


/**
 读取UUID*
 */
+(NSString *)readUUID;

/**
 * 删除数据
 */
+(void)deleteUUID;
@end
