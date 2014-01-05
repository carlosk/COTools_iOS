//
//  UIDevice+CO.m
//  COCategory
//
//  Created by carlos on 13-9-15.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "UIDevice+CO.h"

@implementation UIDevice (CO)
//设备版本号
+ (float) currentVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
@end
