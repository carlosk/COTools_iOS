//
//  TableViewDataHandler.m
//  MyFamework
//
//  Created by carlos on 13-9-5.
//  Copyright (c) 2013年 carlos. All rights reserved.
//封装了TableView的内容

#import "TableViewDataHandler.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "COBaseCell.h"
@interface TableViewDataHandler()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *items;
@property(nonatomic,strong)NSMutableArray *sections;//章节,里面是array
@property(nonatomic,copy)Class cellClass;
@property(nonatomic,weak)UITableView  *mTableV;;

@end

@implementation TableViewDataHandler

//根据setion初始化
-(TableViewDataHandler *)initWithSetions:(NSMutableArray *)setions withTableView:(UITableView *)tableV withTableViewDataHandlerFillCellBlock:(TableViewDataHandlerFillCellBlock) tableViewDataHandlerFillCellBlock withCOBaseCellClass:(Class )cellClass{
    self = [super init];
    if (self) {
        self.sections = setions;
        self.tableViewDataHandlerFillCellBlock = tableViewDataHandlerFillCellBlock;
        self.mTableV = tableV;
        tableV.delegate = self;
        tableV.dataSource= self;
        self.cellClass = cellClass;
        if ([cellClass isSubclassOfClass:[COBaseCell class]]) {
            objc_msgSend(cellClass, @selector(registerCellNib:),tableV);
        }
        
        //        objc_msgSend(_cellClass, @selector(getCellHeight:),nil);
        
    }
    return self;
    
}
//初始化
-(TableViewDataHandler *)initWithItems:(NSMutableArray *)items withTableView:(UITableView *)tableV withTableViewDataHandlerFillCellBlock:(TableViewDataHandlerFillCellBlock) tableViewDataHandlerFillCellBlock withCOBaseCellClass:(Class )cellClass{
    self = [super init];
    if (self) {
        self.items = items;
        self.tableViewDataHandlerFillCellBlock = tableViewDataHandlerFillCellBlock;
        self.mTableV = tableV;
        tableV.delegate = self;
        tableV.dataSource= self;
        self.cellClass = cellClass;
        if ([cellClass isSubclassOfClass:[COBaseCell class]]) {
            objc_msgSend(cellClass, @selector(registerCellNib:),tableV);
        }
        
//        objc_msgSend(_cellClass, @selector(getCellHeight:),nil);

    }
    return self;
}


- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.sections) {
        NSArray *items = self.sections[indexPath.section];
        return items[(NSUInteger) indexPath.row];
    }

    return self.items[(NSUInteger) indexPath.row];
}

//重新刷新
-(void)reloadItemsData:(NSMutableArray *)items{
    self.items = items;
    [self.mTableV reloadData];
}
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.sections) {
        NSArray *items = self.sections[section];
        return items.count;
    }
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = objc_msgSend(self.cellClass, @selector(initCellWithTable:),tableView);
    cell.tag = indexPath.row;
    id item = self.items[indexPath.row];
    if (self.sections) {
        NSArray *items = self.sections[indexPath.section];
        item = items[indexPath.row];
    }
    if (self.tableViewDataHandlerFillCellBlock) {
        self.tableViewDataHandlerFillCellBlock(cell,item,indexPath);
    }
    objc_msgSend(cell, @selector(fillData:withIndexPath:),item,indexPath);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
        id item = self.items[indexPath.row];
    if (self.tableViewDataHandlerClickIndexBlock) {
        self.tableViewDataHandlerClickIndexBlock(indexPath,item);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 44.0f;
    if ([self.cellClass isSubclassOfClass:[COBaseCell class]]) {
        id item = self.items[indexPath.row];
        if (self.sections) {
            NSArray *items = self.sections[indexPath.section];
            item = items[indexPath.row];
        }
        
        NSNumber *height1 = objc_msgSend(_cellClass, @selector(getCellHeight:withIndexPath:),item,indexPath);
        height = [height1 floatValue];
    }
    return height;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.sections) {
        return self.sections.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0.0f;
    if (self.sections && [self.cellClass isSubclassOfClass:[COBaseCell class]]) {
        NSArray *items = self.sections[section];
        NSNumber *height1 = objc_msgSend(_cellClass, @selector(heightForHeaderInSection:withSection:),items,section);
        height = [height1 floatValue];
    }
    return height;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = 0.0f;
    if (self.sections && [self.cellClass isSubclassOfClass:[COBaseCell class]]) {
        NSArray *items = self.sections[section];
        NSNumber *height1 = objc_msgSend(_cellClass, @selector(heightForFooterInSection:withSection:),items,section);
        height = [height1 floatValue];
    }
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}// custom view for header. will be adjusted to default or specified header height
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
@end
