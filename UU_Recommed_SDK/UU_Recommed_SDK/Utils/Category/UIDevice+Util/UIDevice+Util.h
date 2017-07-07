//
//  UIDevice+Util.h
//  Monkey
//
//  Created by devduwan on 4/29/16.
//  Copyright © 2016 Monkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Util)

/**
 *  保持屏幕常亮
 *
 *  @param open YES 常亮
 */
+ (void) turnScreenOpen:(BOOL)open;

@end
