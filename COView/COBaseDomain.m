//
//  COBaseDomain.m
//  COTools
//
//  Created by carlos on 13-12-19.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COBaseDomain.h"
#import "COCommTool.h"
@implementation COBaseDomain
-(id)initWithJson:(NSDictionary *)json{
    self = [super init];
    if (!self) {
        return self;
    }
    
    [COCommTool fillObject:self withJSONDict:json];
    
    return self;
}
@end
