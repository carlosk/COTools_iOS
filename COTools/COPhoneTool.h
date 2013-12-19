//
//  COPhoneTool.h
//  COTools
//
//  Created by carlos on 13-9-20.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COBaseTool.h"

@interface COPhoneTool : COBaseTool
//拨打电话
+(void)callPhone:(NSString *)mPhoneNum;
//是否是iPhone
+(BOOL)isPhone;
@end
