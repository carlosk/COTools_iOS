//
//  TableViewDataHandler.h
//  MyFamework
//
//  Created by carlos on 13-9-5.
//  Copyright (c) 2013年 carlos. All rights reserved.
//

typedef void(^TableViewDataHandlerFillCellBlock)(id cell,id item,NSIndexPath *indexPath);//创建cell的时候调用
typedef void(^TableViewDataHandlerClickIndexBlock)(NSIndexPath *indexPath,id item);//点击cell的时候调用


@interface TableViewDataHandler : NSObject
@property (nonatomic, copy) TableViewDataHandlerFillCellBlock tableViewDataHandlerFillCellBlock;
@property(nonatomic,copy)TableViewDataHandlerClickIndexBlock tableViewDataHandlerClickIndexBlock;//点击的block

//根据setion初始化
-(TableViewDataHandler *)initWithSetions:(NSArray *)setions withTableView:(UITableView *)tableV withTableViewDataHandlerFillCellBlock:(TableViewDataHandlerFillCellBlock) tableViewDataHandlerFillCellBlock withCOBaseCellClass:(Class )cellClass;
//初始化
-(TableViewDataHandler *)initWithItems:(NSArray *)items withTableView:(UITableView *)tableV withTableViewDataHandlerFillCellBlock:(TableViewDataHandlerFillCellBlock) tableViewDataHandlerFillCellBlock withCOBaseCellClass:(Class )cellClass;
//获取一个item
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
//重新刷新
-(void)reload:(NSArray *)items;
@end
