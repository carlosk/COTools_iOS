//
//  NSObject+CO.h
//  MyFamework
//
//  Created by carlos on 13-9-7.
//  Copyright (c) 2013年 carlos. All rights reserved.
//haha

#import <Foundation/Foundation.h>

@interface NSObject (CO)

//延迟调用block
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

//只支持retain,如果是基本类型则写成NSNumber
-(void)setCoObject:(id)obj;
-(id)coObject;

//存入一个block
-(void)handlerDefaultEventWithBlock:(id)block;
//获取一个block
-(id)blockForDefaultEvent;
-(void)handlerEventWithBlock:(id)block withIdentifier:(NSString *)identifier;
-(id)blockForEventWithIdentifier:(NSString *)identifier;


//=======================
//跟上面的不同在于,这个的block可以接受多个形参
//从一个block里接收到数据
-(void)receiveObject:(void(^)(id object))sendObject;
//发送数据到某个block
-(void)sendObject:(id)object;
-(void)receiveObject:(void(^)(id object))sendObject withIdentifier:(NSString *)identifier;
-(void)sendObject:(id)object withIdentifier:(NSString *)identifier;


//数据存储
+ (BOOL)saveArchiverOne:(id)domain;

+ (id)getArchiverOne:(Class )mClass;

//存储一组对象
+ (BOOL)saveArchiverArray:(NSArray *)domains withClass:(Class )mClass;
//获取一组对象
+ (id)getArchiverArray:(Class )mClass;
@end
