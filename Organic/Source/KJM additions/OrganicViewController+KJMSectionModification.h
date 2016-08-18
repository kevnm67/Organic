//
//  OrganicViewController+KJMSectionModification.h
//  Organic
//
//  Created by Kevin Morton on 8/17/16.
//  Copyright © 2016 Mike Amaral. All rights reserved.
//

#import "OrganicViewController.h"

@interface OrganicViewController (KJMSectionModification)

- (void)appendItems:(NSArray *)items toSection:(NSInteger)section;
- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Sections -

- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfItemsInSection:(NSInteger)section;

- (OrganicSection *)sectionAtIndex:(NSInteger)index;

@end
