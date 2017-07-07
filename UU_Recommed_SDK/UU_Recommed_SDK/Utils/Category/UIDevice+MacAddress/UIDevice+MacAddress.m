//
//  UIDevice+MacAddress.m
//
//  Created by Amar Kulo on 2012-02-11.
//  Copyright (c) 2012 iRget Solutions. All rights reserved.
//

#import "UIDevice+MacAddress.h"
#include <net/if_dl.h>
#include <netinet/in.h>
#include <ifaddrs.h>
#import <CommonCrypto/CommonDigest.h>

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#import "sys/utsname.h"
#include <mach/mach.h>
#include <mach/mach_time.h>

@implementation UIDevice (MacAddress)

- (NSString *)macAddress
{
    int mgmtInfoBase[6];
    char *msgBuffer = NULL;
    NSString *errorFlag = NULL;
    size_t length;
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET; // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE; // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK; // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST; // Request all configured interfaces
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    // Get the size of the data available (store in len)
    else if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
        errorFlag = @"sysctl mgmtInfoBase failure";
    // Alloc memory based on above call
    else if ((msgBuffer = malloc(length)) == NULL)
        errorFlag = @"buffer allocation failure";
    // Get system information, store in buffer
    else if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
    {
        free(msgBuffer);
        errorFlag = @"sysctl msgBuffer failure";
    }
    else
    {
        // Map msgbuffer to interface message structure
        struct if_msghdr *interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
        // Map to link-level socket structure
        struct sockaddr_dl *socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
        // Copy link layer address data in socket structure to an array
        unsigned char macAddress[6];
        memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
        // Read from char array into a string object, into traditional Mac address format
        NSString *macAddressString = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X",
                                      macAddress[0], macAddress[1], macAddress[2], macAddress[3], macAddress[4], macAddress[5]];
        NSLog(@"Mac Address: %@", macAddressString);
        // Release the buffer memory
        free(msgBuffer);
        return macAddressString;
    }
    // Error...
    NSLog(@"Error: %@", errorFlag);
    return @"";
}

- (NSString *) macAddress:(NSString *)delimiter {
    
    int	result;
	struct ifaddrs	*ifbase, *ifiterator;
	
	result = getifaddrs(&ifbase);
	ifiterator = ifbase;
    NSString *macAddress = nil;
    
    while (!result && (ifiterator != NULL))
	{
        NSString* interface_name = [NSString stringWithFormat:@"%s", ifiterator->ifa_name];

        if ([interface_name isEqualToString:@"en0"] && ifiterator->ifa_addr->sa_family == AF_LINK)
        {
            struct sockaddr_dl* dlAddr;
			dlAddr = (struct sockaddr_dl *)(ifiterator->ifa_addr);
            unsigned char mac_address[6];
            memcpy(mac_address, &dlAddr->sdl_data[dlAddr->sdl_nlen], 6);
            
            macAddress = 
            [NSString stringWithFormat:@"%02X%@%02X%@%02X%@%02X%@%02X%@%02X"
             , mac_address[0], delimiter, mac_address[1], delimiter, mac_address[2], delimiter
             , mac_address[3], delimiter, mac_address[4], delimiter, mac_address[5]];
            
            break;
            
        }

        ifiterator = ifiterator->ifa_next;
    }
    
    return macAddress;
}

- (NSString *)uniqueDeviceIdentifier {
    
    // Create pointer to the string as UTF8
    const char *ptr = [[self macAddress:@""] UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char hashedChars[CC_SHA256_DIGEST_LENGTH];

    // Hash pointer to hashedChars array
    CC_SHA256(ptr, CC_SHA256_DIGEST_LENGTH, hashedChars);
    
    // Convert SHA256 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString string];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        
        [output appendFormat:@"%02x",hashedChars[i]];
        
    } 
    
    // add dashes
    [output insertString:@"-" atIndex:8];
    [output insertString:@"-" atIndex:13];
    [output insertString:@"-" atIndex:18];
    [output insertString:@"-" atIndex:23];
    [output insertString:@"-" atIndex:36];
    [output insertString:@"-" atIndex:49];
    [output insertString:@"-" atIndex:54];
    [output insertString:@"-" atIndex:59];
    [output insertString:@"-" atIndex:64];
    return [output uppercaseString];
}


- (NSString *)getDeviceVersion
{
    struct utsname systemInfo;
    uname(&systemInfo);
    //get the device model and the system version
    NSString *platform =[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad mini 2G (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad mini 2G (Cellular)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return (platform ? platform : @"iOS Device");
    
}


uint64_t getTickCount(void)
{
    static mach_timebase_info_data_t sTimebaseInfo;
    //    mach_absolute_time is a CPU/Bus dependent function that returns a value based on the number of "ticks" since the system started up.
    uint64_t machTime = mach_absolute_time();
    
    // Convert to nanoseconds - if this is the first time we've run, get the timebase.
    if (sTimebaseInfo.denom == 0 )
    {
        (void) mach_timebase_info(&sTimebaseInfo);
    }
    
    // Convert the mach time to milliseconds
    uint64_t millis = ((machTime / 1000000) * sTimebaseInfo.numer) / sTimebaseInfo.denom;
    return millis;
}


+ (NSString *)getUmengOid
{
    /*
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = @"";
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    return deviceID;
    */
    return @"";
}
@end
