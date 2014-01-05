//
//  COCommTool.m
//  COTools
//
//  Created by carlos on 13-9-20.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COCommTool.h"
#import <objc/runtime.h>
@implementation COCommTool
/**
 *  json字典填充一个Object对象
 *
 *  @param object 一般传入的为self
 *  @param json   json的字典
 */
+ (void)fillObject:(id )object withJSONDict:(NSDictionary *)json{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (!object || ![json isKindOfClass:[NSDictionary class]]) {
        return;
    }
    Class mClass1 = [object class];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(mClass1, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithFormat:@"%s",property_getName(property)];
        id value = [json objectForKey:key];
        //如果value是array类型的，则解析成domain数组
        if ([value isKindOfClass:[NSArray class]] || [[[value class] description] isEqualToString:@"__NSCFArray"]) {
            if ([value count]) {
                if ([value[0] isKindOfClass:[NSDictionary class]] || [[[value[0] class] description] isEqualToString:@"__NSCFDictionary"] ) {
                    NSMutableArray *objectArr = [[NSMutableArray alloc] init];
                    //根据key的名字构造sel，sel必须以[key]ChildClass为名字，且返回class类型
                    SEL classSel = NSSelectorFromString([NSString stringWithFormat:@"%@ChildClass",key]);
                    if ([[object class] respondsToSelector:classSel]) {
                        Class arrClass = [[object class] performSelector:classSel];
                        for (NSDictionary *dicValue in value) {
                            id arrayObj = [[arrClass alloc] init];
                            [COCommTool fillObject:arrayObj withJSONDict:dicValue];
                            [objectArr addObject:arrayObj];
                        }
                        if (objectArr.count) {
                            [object setValue:objectArr forKey:key];
                        }
                    }
                }
            }
        }else
            //如果value是dictionary类型的，则解析成domain
            if ([value isKindOfClass:[NSDictionary class]] || [[[value class] description] isEqualToString:@"__NSCFDictionary"]) {
                //根据key的名字构造sel，sel必须以[key]Class为名字，且返回class类型
                SEL classSel = NSSelectorFromString([NSString stringWithFormat:@"%@Class",key]);
                if ([[object class] respondsToSelector:classSel]) {
                    Class domainClass = [[object class] performSelector:classSel];
                    id domainObj = [[domainClass alloc] init];
                    [COCommTool fillObject:domainObj withJSONDict:value];
                    [object setValue:domainObj forKey:key];
                }
            }
        if (value && ![object valueForKey:key]) {
            [object setValue:value forKey:key];
        }
    }
    free (properties);
#pragma clang diagnostic pop

    
    
//    if (!object || ![json isKindOfClass:[NSDictionary class]]) {
//        return;
//    }
//    Class mClass1 = [object class];
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList(mClass1, &outCount);
//    for (i = 0; i < outCount; i++) {
//        objc_property_t property = properties[i];
//        NSString *key = [NSString stringWithFormat:@"%s",property_getName(property)];
//        id value = [json objectForKey:key];
//        if (value) {
//            [object setValue:value forKey:key];
//        }
//    }
//    free (properties);
}
@end
