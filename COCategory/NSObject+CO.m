//
//  NSObject+CO.m
//  MyFamework
//
//  Created by carlos on 13-9-7.
//  Copyright (c) 2013年 carlos. All rights reserved.
//

#import "NSObject+CO.h"
#import "NSString+CO.h"
#import <objc/runtime.h>
@implementation NSObject (CO)

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

#pragma mark 加入一个自定义的对象

const char COObjectStoreKey;
-(void)setCoObject:(id)obj{
    //只要不是
    objc_setAssociatedObject(self, &COObjectStoreKey, obj, OBJC_ASSOCIATION_RETAIN);
}
-(id)coObject{
    return objc_getAssociatedObject(self, &COObjectStoreKey);
}



//=======================

const char ZXObjectEventHandlerDictionary;


-(void)handlerDefaultEventWithBlock:(id)block
{
    [self handlerEventWithBlock:block withIdentifier:@"zxDefaultEventHandler"];
}


-(id)blockForDefaultEvent
{
    return [self blockForEventWithIdentifier:@"zxDefaultEventHandler"];
}

-(void)handlerEventWithBlock:(id)block withIdentifier:(NSString *)identifier
{
    NSAssert(identifier != nil, @"identifier can't be nil.");
    NSMutableDictionary *eventHandlerDictionary = objc_getAssociatedObject(self,&ZXObjectEventHandlerDictionary);
    if(eventHandlerDictionary == nil)
    {
        eventHandlerDictionary = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &ZXObjectEventHandlerDictionary, eventHandlerDictionary, OBJC_ASSOCIATION_RETAIN);
    }
    
    [eventHandlerDictionary setObject:block forKey:identifier];
}

-(id)blockForEventWithIdentifier:(NSString *)identifier
{
    NSAssert(identifier != nil, @"identifier can't be nil.");
    NSDictionary *eventHandlerDictionary = objc_getAssociatedObject(self,&ZXObjectEventHandlerDictionary);
    if(eventHandlerDictionary == nil) return nil;
    return [eventHandlerDictionary objectForKey:identifier];
}
//=======================
const char ZXObjectSingleObjectDictionary;

-(void)receiveObject:(void(^)(id object))sendObject
{
    [self receiveObject:sendObject withIdentifier:@"ZXObjectSingleObjectDictionary"];
}
-(void)sendObject:(id)object
{
    [self sendObject:object withIdentifier:@"ZXObjectSingleObjectDictionary"];
}

-(void)receiveObject:(void(^)(id object))sendObject withIdentifier:(NSString *)identifier
{
    NSAssert(identifier != nil, @"identifier can't be nil.");
    NSMutableDictionary *eventHandlerDictionary = objc_getAssociatedObject(self,&ZXObjectSingleObjectDictionary);
    if(eventHandlerDictionary == nil)
    {
        eventHandlerDictionary = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &ZXObjectSingleObjectDictionary, eventHandlerDictionary, OBJC_ASSOCIATION_RETAIN);
    }
    
    [eventHandlerDictionary setObject:sendObject forKey:identifier];
}

-(void)sendObject:(id)object withIdentifier:(NSString *)identifier
{
    NSAssert(identifier != nil, @"identifier can't be nil.");
    
    NSDictionary *eventHandlerDictionary = objc_getAssociatedObject(self,&ZXObjectSingleObjectDictionary);
    if(eventHandlerDictionary == nil)
        return;
    
    void(^block)(id object) =  [eventHandlerDictionary objectForKey:identifier];
    block(object);
}




@end
