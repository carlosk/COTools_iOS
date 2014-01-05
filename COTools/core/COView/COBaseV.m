//
//  COBaseView.m
//  COTools
//
//  Created by carlos on 13-10-15.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COBaseV.h"
#import "UIView+CO.h"

@implementation COBaseV
-(void)awakeFromNib{
    //统一设置字体
//    [ViewUtils customFontsForView:self];
}

#pragma mark View初始化
-(void)createViews{
    
    
}


#pragma mark 数据
- (void)createData
{
    
}

-(IBAction)onClickWithXib:(UIView *)sender{
    
    if (![self onClick:sender]) {
        // 如果为NO，则自行处理
        
    }
}

//点击了某个按钮
-(BOOL)onClick:(UIView *)sender{
    return NO;
}

//用静态创建
+(id )createVWithXib{
    id mView = [self createWithXib];
    if (mView) {
        [mView createViews];
        [mView createData];
    }
    return mView;
}
@end
