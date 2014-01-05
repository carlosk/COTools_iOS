//
//  TestCell.m
//  COTools
//
//  Created by carlos on 13-9-29.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "TestCell.h"

@interface TestCell()
@property(nonatomic,weak)IBOutlet UILabel *titleL;

@end

@implementation TestCell

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
    return [NSNumber numberWithFloat:44.f];
}
//默认是屏幕的宽度
+(float )getCellWidth{
    return 320.f;
}

- (void)fillData:(id)item withIndexPath:(NSIndexPath *)indexPath{
    self.titleL.text = item;
}


//section底部的高度
+(NSNumber * )heightForFooterInSection:(id)items withSection:(NSInteger)section{
    return @0.f;
}
//setion的头部的高度
+(NSNumber * )heightForHeaderInSection:(id)items withSection:(NSInteger)section{
    return @0.f;
}

@end
