//
//  UITableView+CO.m
//  COTools
//
//  Created by carlos on 13-9-29.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "UITableView+CO.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "COBaseCell.h"
@interface UITableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation UITableView (CO)
static char tableViewDataHandlerKey ;
- (void)setHandler:(TableViewDataHandler *)handler{
    objc_setAssociatedObject (self , & tableViewDataHandlerKey , handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TableViewDataHandler *)handler{
  return  objc_getAssociatedObject(self, &tableViewDataHandlerKey);
}
//填充数据到TableVIew,省却delegate
- (void)fillWithSetions:(NSArray *)setions withFillCellBlock:(TableViewDataHandlerFillCellBlock) tableViewDataHandlerFillCellBlock withCOBaseCellClass:(Class )cellClass{
    TableViewDataHandler * handler = [[TableViewDataHandler alloc]initWithSetions:setions  withTableView:self withTableViewDataHandlerFillCellBlock:tableViewDataHandlerFillCellBlock withCOBaseCellClass:cellClass];
    self.handler = handler;
}

//填充数据到TableView里,默认章节是1
- (void)fillWithItems:(NSArray *)items withFillCellBlock:(TableViewDataHandlerFillCellBlock) tableViewDataHandlerFillCellBlock withCOBaseCellClass:(Class )cellClass{
    
    TableViewDataHandler * handler = [[TableViewDataHandler alloc]initWithItems:items withTableView:self withTableViewDataHandlerFillCellBlock:tableViewDataHandlerFillCellBlock withCOBaseCellClass:cellClass];
    self.handler = handler;
    
}

//添加点击的block
- (void)setOnClickCellBlock:(TableViewDataHandlerClickIndexBlock )block{
    [self.handler setTableViewDataHandlerClickIndexBlock:block];
}

/**
 *  没有section的情况下用的
 *  @param items
 */
- (void)reloadItemsData:(NSMutableArray *)items{
    [self.handler reloadItemsData:items];
}
@end
