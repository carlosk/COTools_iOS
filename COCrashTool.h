//
//  COCrashTool.h
//  COTools
//
//  Created by carlos on 13-9-20.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COBaseTool.h"

@interface COCrashTool : COBaseTool
//这个方法放在main里面
+ (void) handlerCarsh:(NSException *)exception;
@end
