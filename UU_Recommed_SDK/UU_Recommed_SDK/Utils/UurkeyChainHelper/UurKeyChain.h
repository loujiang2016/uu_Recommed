//
//  UurKeyChain.h
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/7.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UurKeyChain : NSObject
+(NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+(void)save:(NSString *)service  data:(id)data;

+(id)load:(NSString *)service;

+(void)delete:(NSString *)service;
@end
