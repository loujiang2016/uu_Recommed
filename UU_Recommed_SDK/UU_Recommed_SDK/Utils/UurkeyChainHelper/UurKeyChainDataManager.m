//
//  UurKeyChainDataManager.m
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/7.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import "UurKeyChainDataManager.h"
#import "UurKeyChain.h"


static NSString * const KEY_IN_KEYCHAIN_UUID=@"UuRecommed_KEY_UUID";
static NSString * const KEY_UUID=@"UuRecommed_key_uuid";
@implementation UurKeyChainDataManager



+(void)saveUUID:(NSString *)UUID{
    
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:UUID forKey:KEY_UUID];
    
    [UurKeyChain save:KEY_IN_KEYCHAIN_UUID data:usernamepasswordKVPairs];
}

+(NSString *)readUUID{
    
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[UurKeyChain load:KEY_IN_KEYCHAIN_UUID];
    
    return [usernamepasswordKVPair objectForKey:KEY_UUID];
    
}

+(void)deleteUUID{
    
    [UurKeyChain delete:KEY_IN_KEYCHAIN_UUID];
    
}
@end
