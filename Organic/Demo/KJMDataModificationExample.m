//
//  KJMDataModificationExample.m
//  Organic
//
//  Created by Kevin Morton on 8/18/16.
//  Copyright © 2016 Mike Amaral. All rights reserved.
//

#import "KJMDataModificationExample.h"

static CGFloat kDefaultOrganicCellHeight = 44;

@interface KJMDataModificationExample ()

@property (strong, nonatomic) OrganicSection *sectionTwo;
@property (strong, nonatomic) NSMutableArray *tableCells;

@end

@implementation KJMDataModificationExample

#pragma mark - Lifecycle -

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewCell)];
    
    [self setupTableView];
}

#pragma mark - Tableview -

- (void)setupTableView
{
    self.tableCells = [self createCells:1];
    
    self.sections = @[self.sectionOne, self.sectionTwo];
}

#pragma mark Organic Sections

- (OrganicSection *)sectionOne
{
    return [OrganicSection sectionWithHeaderTitle:@"Section one" cells:[self createCells:4]];
}

- (OrganicSection *)sectionTwo
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(insertNewCell)];
    
    OrganicSection *section = [OrganicSection sectionWithFooterTitle:@"Tap cells > 1 to delete" cells:self.tableCells];
    [section.headerView addGestureRecognizer:tapGesture];
    
    return section;
}

#pragma mark - Cell modifications -

- (void)insertNewCell
{
    OrganicCell *cell = [OrganicCell cellWithStyle:UITableViewCellStyleSubtitle height:kDefaultOrganicCellHeight actionBlock:^{
        [self removeItemAtIndexPath:[NSIndexPath indexPathForRow:self.sectionTwo.cells.count - 1 inSection:1]];
    }];
    
    cell.textLabel.text       = [self kjm_randomizeString];
    cell.detailTextLabel.text = @"tap to delete me";
    
    [self appendItems:@[cell] toSection:self.numberOfSections];
}

#pragma mark - Utility -

- (NSMutableArray *)createCells:(int)count
{
    NSMutableArray *cellItems = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        OrganicCell *cell = [OrganicCell cellWithStyle:UITableViewCellStyleValue1 height:kDefaultOrganicCellHeight actionBlock:nil];
        cell.textLabel.text = [self kjm_randomizeString];
        
        [cellItems addObject:cell];
    }
    
    return cellItems;
}

- (NSString *)kjm_randomizeString
{
    NSArray *letters  = [@"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z" componentsSeparatedByString:@" "];
    NSString *letterA = letters[(NSUInteger)arc4random_uniform((unsigned int)letters.count)];
    NSString *letterB = letters[(NSUInteger)arc4random_uniform((unsigned int)letters.count)];
    NSString *letterD = letters[(NSUInteger)arc4random_uniform((unsigned int)letters.count)];
    NSString *letterE = letters[(NSUInteger)arc4random_uniform((unsigned int)letters.count)];
    
    return [NSString stringWithFormat:@"%@%@%@%@", letterA, letterB, letterD, letterE];
}

@end
