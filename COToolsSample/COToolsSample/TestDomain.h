//
//  TestDomain.h
//  COTools
//
//  Created by carlos on 14-1-5.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import "COBaseDomain.h"

@interface TestDomain : COBaseDomain<NSCoding>
@property(nonatomic,strong)NSString  * name;
@property(nonatomic,assign)float age;
@property(nonatomic,strong)NSString  * address;
@property(nonatomic,strong)TestDomain  * childDomain;
@property(nonatomic,strong)NSArray  * tests;



@end
