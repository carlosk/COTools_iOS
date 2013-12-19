//
//  COPhoneTool.m
//  COTools
//
//  Created by carlos on 13-9-20.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COPhoneTool.h"

@implementation COPhoneTool
//是否是iPhone
+(BOOL)isPhone{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

//拨打电话
+(void)callPhone:(NSString *)mPhoneNum
{
    //去掉-
    mPhoneNum = [mPhoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //去掉空格
    mPhoneNum = [mPhoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    CLog(@"phonenum = %@",mPhoneNum);
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",mPhoneNum]];
    
    [[UIApplication sharedApplication] openURL:phoneURL];
    
}
@end
