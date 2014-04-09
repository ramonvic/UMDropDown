//
//  UMDropDownContentViewController.h
//  Cilia
//
//  Created by Ramon on 1/9/14.
//  Copyright (c) 2014 Umobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMDropDown.h"

@protocol UMDropDownDelegate;
@protocol UMDropDownDataSource;

@interface UMDropDownContentViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViewOptions;
@property (nonatomic, strong) id<UMDropDownDelegate>delegate;
@property (nonatomic, strong) id<UMDropDownDataSource>dataSource;

@property (nonatomic, strong) UIColor *cellTextColor;
@property (nonatomic, strong) UIFont *cellFont;

@end

