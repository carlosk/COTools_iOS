//
//  COBaseCell.h
//  PocketWenzhou3
//
//  Created by carlos on 13-5-9.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COBaseCell : UITableViewCell

//点击事件
-(IBAction)onClickWithXib:(UIView *)sender;
//点击了某个按钮
-(BOOL)onClick:(UIView *)sender;
//Cell的高度 子类必须要实现。Cell的高度要在cell类里调整
+(NSNumber * )getCellHeight:(id)item withIndexPath:(NSIndexPath *)indexPath;
//section底部的高度
+(NSNumber * )heightForFooterInSection:(id)items withSection:(NSInteger)section;
//setion的头部的高度
+(NSNumber * )heightForHeaderInSection:(id)items withSection:(NSInteger)section;

+(id)initCellWithTable:(UITableView *)tableView;
//为TableView注册nib
+(void)registerCellNib:(UITableView *)mTableV;

//创建View
-(void)createViews;
//创建Data数据
-(void)createData;

//填充数据，这个是给子类实现的
-(void)fillData:(id)item withIndexPath:(NSIndexPath *)indexPath;
@end
