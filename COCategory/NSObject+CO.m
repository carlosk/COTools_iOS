//
//  NSObject+CO.m
//  MyFamework
//
//  Created by carlos on 13-9-7.
//  Copyright (c) 2013年 carlos. All rights reserved.
//

#import "NSObject+CO.h"
#import "NSString+CO.h"
@implementation NSObject (CO)
//是否是空的
- (BOOL)isEmpty{
    return ![self isNotEmpty];
}

//是否是不为空的
- (BOOL)isNotEmpty{
    if ([self isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)self;
        return str && ![[str trim] isEqual:@""];
    }else if ([self isKindOfClass:[NSArray class]]){
        return ((NSArray *)self).count > 0;
    }else if ([self isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = (NSDictionary *)self;
        return dict.count > 0;
    }else{
        return self != nil;
    }
}

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    block = [block copy];
    [self performSelector:@selector(runBlockAfterDelay:) withObject:block afterDelay:delay];
}

- (void)runBlockAfterDelay:(void (^)(void))block
{
	if (block != nil)
		block();
}
@end
