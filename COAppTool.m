//
//  COAppTool.m
//  COTools
//
//  Created by carlos on 13-9-20.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COAppTool.h"

@implementation COAppTool
//获取应用名
+(NSString *)appName
{
    NSBundle*bundle =[NSBundle mainBundle];
    NSDictionary*info =[bundle infoDictionary];
    NSString*prodName =[info objectForKey:@"CFBundleDisplayName"];
    return prodName;
}
//获取版本号
+(NSString *)appVersionName
{
    NSBundle*bundle =[NSBundle mainBundle];
    NSDictionary*info =[bundle infoDictionary];
    //    CLog(@"info = %@",info);
    NSString*prodName =[info objectForKey:@"CFBundleVersion"];
    return prodName;
}

//获取系统Version
+ (float )mSystemVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

//评论url
+ (NSString *)commonUrl:(NSString *)appId{
    return [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",appId];
}
//appurl
+ (NSString *)appUrl:(NSString *)appId{

    return [NSString stringWithFormat:@"https://itunes.apple.com/us/app/zhang-shang-wen-zhou/id%@?ls=1&mt=8",appId];
}

@end
