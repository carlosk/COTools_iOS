//
//  COCrashTool.m
//  COTools
//
//  Created by carlos on 13-9-20.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COCrashTool.h"
#import "COLogTool.h"
@implementation COCrashTool
//这个方法放在main里面
+ (void) handlerCarsh:(NSException *)exception{
    NSMutableDictionary *crash = [NSMutableDictionary dictionary];
    
    if ([exception name]) {
        [crash setValue:[exception name] forKey:@"name"];
    }
    if ([exception reason]) {
        [crash setValue:[exception reason] forKey:@"reason"];
    }
    if ([exception userInfo]) {
        [crash setValue:[exception userInfo] forKey:@"userInfo"];
    }
    NSString *detail;
    if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_4_0) {
        detail = [[exception callStackSymbols] componentsJoinedByString:@"\n"];
    }else {
        detail = [[exception callStackReturnAddresses] componentsJoinedByString:@"\n"];
    }
    CLog(@"crash = %@,detail = %@",crash,detail);

}
@end
