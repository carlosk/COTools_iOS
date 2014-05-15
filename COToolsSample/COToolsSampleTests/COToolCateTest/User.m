//
//  User.m
//  COToolsSample
//
//  Created by carlos on 14-1-22.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import "User.h"

@implementation User


+ (NSString *)addressKey{
    return @"aaddress";
}

+(NSDate *)createDateValue:(NSString *)createDate{
    
    return [NSDate date];
}

//+(Class )imageIdsChildClass{
//    return [NSNumber class];
//}

+(Class )identityClass
{
    return [Identity class];
}
@end
