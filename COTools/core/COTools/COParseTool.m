//
//  COParseTool.m
//  COToolsSample
//
//  Created by carlos on 14-1-5.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import "COParseTool.h"
#import "COBaseDomain.h"
#import "COLogTool.h"
@implementation COParseTool
+(NSArray *)parserData:(NSString *)jsonContent withClass:(Class)mClass withKey:(NSString *)key
{
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonContent dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    if (json == nil) {
        CLog(@"json parse failed \r\n");
        return nil;
    }
    
    NSArray *arr = [json objectForKey:key];
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *eachItem in arr) {
        //        DLog(@"%@",eachItem);
        COBaseDomain *domain = [[mClass alloc]initWithJson:eachItem];
        [result addObject:domain];
    }
    
    return result;
}

//根据json字符串解析成对象
+(id)parser:(NSString *)jsonContent withClass:(Class)mClass withKey:(NSString *)key{
    
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonContent dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    if (json == nil) {
        CLog(@"json parse failed \r\n");
        return nil;
    }
    
    if (key) {
        json = [json objectForKey:key];
    }
    COBaseDomain *domain = [[mClass alloc]initWithJson:json];
    return domain;
}

//通过key查找value
+(NSString *)parseValueWith:(NSString *)jsonContent withKey:(NSString *)key{
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonContent dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    if (json == nil) {
        CLog(@"json parse failed \r\n");
        return nil;
    }
    return [json objectForKey:key];
    
}

@end
