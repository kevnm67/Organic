//
//  OrganicViewController+KJMSectionModification.m
//  Organic
//
//  Created by Kevin Morton on 8/17/16.
//  Copyright © 2016 Mike Amaral. All rights reserved.
//

#import "OrganicViewController+KJMSectionModification.h"

@implementation OrganicViewController (KJMSectionModification)

- (void)appendItems:(NSArray *)items toSection:(NSInteger)section
{
    NSUInteger sectionCount = [self numberOfItemsInSection:section];
    [[self sectionAtIndex:section].cells addObjectsFromArray:items];
    [self insertCellsAtIndexPaths:[self.class indexPathArrayWithRange:NSMakeRange(sectionCount, [items count]) inSection:section]];
}

#pragma mark - UITableView Operations

- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self removeItemsAtIndexes:[NSIndexSet indexSetWithIndex:(NSUInteger)indexPath.row] inSection:indexPath.section];
}

- (void)removeItemsAtIndexes:(NSIndexSet *)indexes inSection:(NSInteger)section
{
    [[self sectionAtIndex:section].cells removeObjectsAtIndexes:indexes];
    
    [self deleteCellsAtIndexPaths:[self.class indexPathArrayWithIndexSet:indexes inSection:section]];
}

#pragma mark - Cell modification -

- (void)insertCellsAtIndexPaths:(NSArray *)indexPaths
{
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)deleteCellsAtIndexPaths:(NSArray *)indexPaths;
{
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSUInteger)numberOfSections
{
    return self.sections.count - 1;
}

#pragma mark - Section access -

- (NSUInteger)numberOfItemsInSection:(NSInteger)section
{
    return [self sectionAtIndex:section].cells.count;
}

- (OrganicSection *)sectionAtIndex:(NSInteger)index
{
    return (OrganicSection *)self.sections[(NSUInteger)index];
}

#pragma mark - NSIndexPath helpers

+ (NSArray *)indexPathArrayWithIndexSet:(NSIndexSet *)indexes inSection:(NSInteger)section
{
    NSMutableArray *indexPathArray = [NSMutableArray array];
    
    [indexes enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {
        [indexPathArray addObject:[NSIndexPath indexPathForRow:(NSInteger)index inSection:section]];
    }];
    
    return indexPathArray;
}

+ (NSArray *)indexPathArrayWithRange:(NSRange)range inSection:(NSInteger)section
{
    return [self indexPathArrayWithIndexSet:[NSIndexSet indexSetWithIndexesInRange:range] inSection:section];
}

@end
