//
//  Copyright (c) 2018年 shinren.pan@gmail.com All rights reserved.
//

#import "AppDelegate.h"
#import "TVPlayerViewController.h"
#import "TVChannelListController.h"


@interface TVChannelListController ()<UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
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
    
    NSDictionary *channel = (_searching) ? _searchResults[indexPath.row] : _dataSource[indexPath.row];
    mvc.mediaURL = [NSURL URLWithString:channel[@"url"]];
    mvc.title = channel[@"title"];
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
    
    cell.textLabel.text = channel[@"title"];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_dataSource removeObjectAtIndex:indexPath.row];
        [self __updateDataBase];
    }
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

#pragma mark - IBAction
- (IBAction)addItemClicked:(id)sender
{
    NSString *title   = NSLocalizedString(@"Input channel infomation", @"輸入頻道資訊");
    NSString *message = NSLocalizedString(@"Title and URL are required", @"名稱及網址為必填");
    
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = NSLocalizedString(@"Required: Channel title", @"必填: 頻道名稱");
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = NSLocalizedString(@"Required: Channel url", @"必填: 頻道網址");
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    
    title = NSLocalizedString(@"Cancel", @"取消");
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:title
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    
    void (^saveHandle)(UIAlertAction *) = ^(UIAlertAction *action){
        NSString *newChannelTitle = alert.textFields.firstObject.text;
        NSString *newChannelURL   = alert.textFields.lastObject.text;
        
        if(!newChannelTitle.length || !newChannelURL.length)
        {
            return ;
        }
        
        NSDictionary *newChannel = @{@"title" : alert.textFields.firstObject.text,
                                     @"url"   : alert.textFields.lastObject.text};
        
        [_dataSource addObject:newChannel];
        [self __updateDataBase];
    };
    
    title = NSLocalizedString(@"Save", @"儲存");
    UIAlertAction *save = [UIAlertAction actionWithTitle:title
                                                   style:UIAlertActionStyleDefault
                                                 handler:saveHandle];
    
    [alert addAction:cancel];
    [alert addAction:save];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Private
- (void)__setup
{
    self.title = ^{
        NSString *key = @"CFBundleShortVersionString";
        NSString *version = [[NSBundle mainBundle]infoDictionary][key];
        return [NSString stringWithFormat:@"Version: %@", version];
    }();
    
    NSString *path =
    [NSHomeDirectory() stringByAppendingPathComponent:kIPTVDataBasePath];
    
    _dataSource = ^{
        NSArray *temp = [NSArray arrayWithContentsOfFile:path];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
        return [[temp sortedArrayUsingDescriptors:@[sort]]mutableCopy];
    }();
}

- (void)__updateDataBase
{
    [self.tableView reloadData];
    
    NSString *path =
    [NSHomeDirectory() stringByAppendingPathComponent:kIPTVDataBasePath];
    
    [_dataSource writeToFile:path atomically:YES];
}

@end
