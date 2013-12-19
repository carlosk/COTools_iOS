//
//  COBlockTool.h
//  COTools
//
//  Created by carlos on 13-12-19.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COBaseTool.h"

//通用Block
typedef void(^BaseOnClickIndex)(int index);
typedef void(^BaseOnClickOne)();
typedef void(^BaseOnClickObject)(id object);
@interface COBlockTool : COBaseTool

@end
