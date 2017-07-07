//
//  UIDevice+Util.m
//  Monkey
//
//  Created by devduwan on 4/29/16.
//  Copyright © 2016 Monkey. All rights reserved.
//

#import "UIDevice+Util.h"

@implementation UIDevice (Util)

+ (void) turnScreenOpen:(BOOL)open
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:open];
}

@end
