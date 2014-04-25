//
//  COLogTool.h
//  COTools
//
//  Created by carlos on 13-9-20.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COBaseTool.h"


#ifdef DEBUG
#   define CLog(s,...) NSLog(@"%@",[NSString stringWithFormat:(s), ##__VA_ARGS__])
#   define ISDEBUG ISTest
#else
#   define ISDEBUG YES
#   define CLog(...)
#endif
#define ALog(...) NSLog(__VA_ARGS__)

@interface COLogTool : COBaseTool

@end
