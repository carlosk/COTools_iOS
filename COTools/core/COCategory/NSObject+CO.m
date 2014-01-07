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


#pragma mark 数据存储
//保存到Archiver中
#define kOneArchiverKey(class) [NSString stringWithFormat:@"%s_oneArchiverKey",class_getName(class)]
#define kNSArrayArchiverKey(class) [NSString stringWithFormat:@"%s_nsarrayArchiverKey",class_getName(class)]
#define kArchiverFILENAME [NSString stringWithFormat:@"%s_ArchiverFILENAMEKey",class_getName([self class])]

//存储一个对象
+ (BOOL)saveArchiverOne:(id)domain{
    return [self saveArchiverData:domain withKey:kOneArchiverKey([domain class])];
}

//存储一组对象
+ (BOOL)saveArchiverArray:(NSArray *)domains withClass:(Class )class{
    
//    NSMutableData *data2 =[[NSMutableData alloc] init];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data2];
//    NSString *key = kNSArrayArchiverKey(class) ;
//    [archiver encodeObject:domains forKey: key];
//    [archiver finishEncoding];
//    BOOL success = [data2 writeToFile:[self archiverPath] atomically:YES];
//    return success;
    
    return [self saveArchiverData:domains withKey:kNSArrayArchiverKey(class)];


}
//获取获取一组对象
+ (id)getArchiverArray:(Class )mClass{
    return [self getArchiverData:mClass withKey:kNSArrayArchiverKey(mClass)];
}

+ (BOOL)saveArchiverData:(id)data withKey:(NSString *)key{
    NSMutableData *data2 =[[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data2];
    [archiver encodeObject:data forKey: key];
    [archiver finishEncoding];
    BOOL success = [data2 writeToFile:[self archiverPath] atomically:YES];
    return success;
}
//获取一组对象
+ (id)getArchiverData:(Class )mClass withKey:(NSString *)key{
    NSData*data1=[[NSData alloc]initWithContentsOfFile:[self archiverPath]];
    
    NSKeyedUnarchiver*unArchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:data1];
    return [unArchiver decodeObjectOfClass:mClass forKey:key];
}

//获取一个对象,根据key
+ (id)getArchiverOne:(Class )mClass{
    return [self getArchiverData:mClass withKey:kOneArchiverKey(mClass)];
}
//获取路径
- (NSString *)archiverPath{
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString*documentsDirectory=[paths objectAtIndex: 0 ];
    
    NSString*filePath=[documentsDirectory stringByAppendingPathComponent:kArchiverFILENAME];
    return filePath;
}


@end
