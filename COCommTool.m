//
//  COCommTool.m
//  COTools
//
//  Created by carlos on 13-9-20.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COCommTool.h"
@import ObjectiveC.runtime;
@implementation COCommTool
/**
 *  json字典填充一个Object对象
 *
 *  @param object 一般传入的为self
 *  @param json   json的字典
 */
+ (void)fillObject:(id )object withJSONDict:(NSDictionary *)json{
    
    Class mClass1 = [object class];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(mClass1, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithFormat:@"%s",property_getName(property)];
        id value = [json objectForKey:key];
        if (value) {
            [self setValue:value forKey:key];
        }
    }
    free (properties);
}
@end
