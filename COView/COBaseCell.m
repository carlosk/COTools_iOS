//
//  COBaseCell.m
//  PocketWenzhou3
//
//  Created by carlos on 13-5-9.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COBaseCell.h"

@implementation COBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
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
//Cell的高度 子类必须要实现。Cell的高度要在cell类里调整
+(NSNumber * )getCellHeight:(id)item withIndexPath:(NSIndexPath *)indexPath{
    return [NSNumber numberWithFloat:10.0f];
}
//section底部的高度
+(NSNumber * )heightForFooterInSection:(id)items withSection:(NSInteger)section{
    return @0.f;
}
//setion的头部的高度
+(NSNumber * )heightForHeaderInSection:(id)items withSection:(NSInteger)section{
    return @0.f;
}
+(id)initCellWithTable:(UITableView *)tableView withCellClass:(Class )mClass{
    
    id cell = [tableView dequeueReusableCellWithIdentifier:[mClass description]];
    if (nil == cell) {
        cell = [[mClass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[mClass description]];
    }
    return cell;
}

+(id)initCellWithTable:(UITableView *)tableView{
    
    
    return [self initCellWithTable:tableView withCellClass:[self class]];
}

+(void)registerCellNib:(UITableView *)mTableV{
    UINib *nib = [UINib nibWithNibName:[[self class] description] bundle:nil];
    if (nib) {
        [mTableV registerNib:nib forCellReuseIdentifier:[[self class] description]];
    }
    
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self createViews];
    [self createData];
}

//创建View
-(void)createViews{
    
}
//创建Data数据
-(void)createData{
    
}
//填充数据，这个是给子类实现的
-(void)fillData:(id)item withIndexPath:(NSIndexPath *)indexPath{
    
}
@end
