//
//  UMDropDownContentViewController.m
//  Cilia
//
//  Created by Ramon on 1/9/14.
//  Copyright (c) 2014 Umobi. All rights reserved.
//

#import "UMDropDownContentViewController.h"

@interface UMDropDownContentViewController ()

@end

@implementation UMDropDownContentViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableViewOptions = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, self.view.frame.size.height - 20)];
    _tableViewOptions.delegate = self;
    _tableViewOptions.dataSource = self;
    _tableViewOptions.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.view addSubview:_tableViewOptions];
}

- (void)viewWillAppear:(BOOL)animated
{
    CGSize popoverSize = [_dataSource sizeOfDropDownController:self];
    [_tableViewOptions setFrame:CGRectMake(10, 10, popoverSize.width - 20, popoverSize.height - 20)];
    
    [super viewWillAppear: animated];
}

#pragma mark - TableView Delegate and Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource numberOfRowsForDropDownController:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"TableViewOptionsCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UMDropDownOption *option = [_dataSource dropDownController:self optionForIndex:indexPath.row];
    cell.textLabel.font = _cellFont;
    cell.textLabel.textColor = _cellTextColor;
    cell.textLabel.text = option.text;
    if (option.selected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UMDropDownOption *option = [_dataSource dropDownController:self optionForIndex:indexPath.row];
    if ([_delegate respondsToSelector:@selector(dropDown:willSelectOption:)]) {
        if (![_delegate dropDown:nil willSelectOption:option]) {
            return nil;
        }
    }
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    UMDropDownOption *option = [_dataSource dropDownController:self optionForIndex:indexPath.row];
    [_delegate dropDown:nil didSelectOption:option];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}
@end
