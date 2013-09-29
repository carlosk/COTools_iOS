//
//  UITableView+CO.h
//  COTools
//
//  Created by carlos on 13-9-29.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewDataHandler.h"

@interface UITableView (CO)
@property(nonatomic,strong,readonly)TableViewDataHandler  * handler;
//填充数据到TableVIew,省却delegate
- (void)fillWithSetions:(NSArray *)setions withFillCellBlock:(TableViewDataHandlerFillCellBlock) tableViewDataHandlerFillCellBlock withCOBaseCellClass:(Class )cellClass;

//填充数据到TableView里,默认章节是1
- (void)fillWithItems:(NSArray *)items withFillCellBlock:(TableViewDataHandlerFillCellBlock) tableViewDataHandlerFillCellBlock withCOBaseCellClass:(Class )cellClass;
//添加点击的block
- (void)setOnClickCellBlock:(TableViewDataHandlerClickIndexBlock )block;
/**
 *  没有section的情况下用的
 *
 *  @param items
 */
- (void)reloadItemsData:(NSMutableArray *)items;
@end
