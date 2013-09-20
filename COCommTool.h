//
//  COCommTool.h
//  COTools
//
//  Created by carlos on 13-9-20.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COBaseTool.h"

@interface COCommTool : COBaseTool
/**
 *  json字典填充一个Object对象
 *
 *  @param object 一般传入的为self
 *  @param json   json的字典
 */
+ (void)fillObject:(id )object withJSONDict:(NSDictionary *)json;
@end
