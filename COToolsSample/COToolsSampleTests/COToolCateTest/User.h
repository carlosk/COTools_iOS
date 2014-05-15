//
//  User.h
//  COToolsSample
//
//  Created by carlos on 14-1-22.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import "BaseUser.h"
#import "Identity.h"
@interface User : BaseUser
@property(nonatomic,assign)int age;
@property(nonatomic,strong)NSString  * address;
@property(nonatomic,strong)NSDate  * createDate;
@property(nonatomic,strong)NSArray *imageIds;
@property(nonatomic,strong)Identity  * identity;
@end
