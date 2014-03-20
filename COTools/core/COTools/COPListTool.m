//
//  COPListTool.m
//  COToolsSample
//
//  Created by carlos on 19/03/2014.
//  Copyright (c) 2014 carlosk. All rights reserved.
//

#import "COPListTool.h"

@implementation COPListTool

+(id)valueByPListName:(NSString *)pListName withKey:(NSString *)key{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:pListName ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return [data objectForKey:key];
}

//根据plist文件名 存入数据
+(void)setByFileName:(NSString *)fileName WithKey:(NSString *)key withValue:(id)value{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    data[key] = value;
}

+(id)valueByDefaultWithKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

+(void)setByDefaulWithKey:(NSString *)key withValue:(id)value{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
