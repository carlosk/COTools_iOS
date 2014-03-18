//
//  FruitCell.m
//  COToolsSample
//
//  Created by carlos on 14-3-4.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import "FruitCell.h"
#import "FruitDomain.h"
#import "MF_Base64Additions.h"
@interface FruitCell()


@end

@implementation FruitCell

//创建的时候被调用
-(void)createViews{
    
}
-(void)createData{
    
}
//点击了某个按钮
-(BOOL)onClick:(UIView *)sender{
    return NO;
}
//Cell的高度 子类必须要实现。Cell的高度要在cell类里调整
+(NSNumber * )getCellHeight:(id)item withIndexPath:(NSIndexPath *)indexPath{
    return @98.f;
}
//section底部的高度
+(NSNumber * )heightForFooterInSection:(id)items withSection:(NSInteger)section{
    return @0.f;
}
//setion的头部的高度
+(NSNumber * )heightForHeaderInSection:(id)items withSection:(NSInteger)section{
    return @0.f;
}
//默认是屏幕的宽度
+(float )getCellWidth{
    return 320.f;
}

- (void)fillData:(FruitDomain *)item withIndexPath:(NSIndexPath *)indexPath{
    CLog(@"fillData");
    self.titleL.text = item.name;
    self.priceL.text = [NSString stringWithFormat:@"%f",item.price];
    //做base64 解密
//    [NSData ]
    
    NSData *imageData = [NSData dataWithBase64String:item.image];
    self.iconIV.image = [UIImage imageWithData:imageData];
}

@end
