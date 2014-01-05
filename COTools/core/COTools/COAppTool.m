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
+ (float )osVersion{
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

static const char * __jb_app = NULL;

+ (BOOL)isJailBroken
{
	static const char * __jb_apps[] =
	{
		"/Application/Cydia.app",
		"/Application/limera1n.app",
		"/Application/greenpois0n.app",
		"/Application/blackra1n.app",
		"/Application/blacksn0w.app",
		"/Application/redsn0w.app",
		NULL
	};
    
	__jb_app = NULL;
    
	// method 1
    for ( int i = 0; __jb_apps[i]; ++i )
    {
        if ( [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:__jb_apps[i]]] )
        {
			__jb_app = __jb_apps[i];
			return YES;
        }
    }
	
    // method 2
	if ( [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"] )
	{
		return YES;
	}
	
	// method 3
	if ( 0 == system("ls") )
	{
		return YES;
	}
	
    return NO;
}


@end
