// TVChannelListController.m
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/12/01.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "TVPlayerViewController.h"
#import "TVChannelListController.h"

@interface TVChannelListController ()<UISearchBarDelegate>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, assign) BOOL searching;

@end


@implementation TVChannelListController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self __setup];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TVPlayerViewController *mvc = segue.destinationViewController;
    UITableViewCell *cell       = sender;
    NSIndexPath *indexPath      = [self.tableView indexPathForCell:cell];
    
    NSDictionary *channel =
    _searching ? _searchResults[indexPath.row] : _dataSource[indexPath.row];
    
    mvc.urlString = channel[@"url"];
    mvc.title     = channel[@"title"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_searching)
    {
        return _searchResults.count;
    }
    
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSDictionary *channel =
    _searching ? _searchResults[indexPath.row] : _dataSource[indexPath.row];
    
    cell.textLabel.text   = channel[@"title"];
    
    return cell;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _searching = YES;
    searchBar.showsCancelButton = YES;
    
    [self.tableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSPredicate *filter = [NSPredicate predicateWithFormat: @"title CONTAINS[cd] %@", searchText];
    _searchResults      = [_dataSource filteredArrayUsingPredicate:filter];
    
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _searching = NO;
    searchBar.text = nil;
    
    [self.view endEditing:YES];
}

#pragma mark - Private
- (void)__setup
{
    NSString *path =
    [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ChannelList.json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    
    id json = [NSJSONSerialization JSONObjectWithData:jsonData
                                              options:NSJSONReadingAllowFragments
                                                error:nil];
    
    if(![json isKindOfClass:[NSArray class]])
    {
        return;
    }
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    _dataSource            = [[json sortedArrayUsingDescriptors:@[sort]]copy];
}


@end
