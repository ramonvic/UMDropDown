//
//  UMDropdown.h
//  Cilia
//
//  Created by Ramon on 1/9/14.
//  Copyright (c) 2014 Umobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMDropDownOption.h"
#import "UMDropDownContentViewController.h"

@protocol UMDropDownDelegate;
@class UMDropDownContentViewController;

@interface UMDropDown : UIButton

@property (nonatomic, strong) NSString *defaultText;

@property (nonatomic, weak) id<UMDropDownDelegate> delegate;
@property (nonatomic, strong) UIViewController *viewControllerContainer;
@property (nonatomic, strong) UMDropDownContentViewController *dropDownContentViewController;
@property (nonatomic, strong) UIPopoverController *popoverController;

@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) UMDropDownOption *selectedOption;
@property (nonatomic, strong) NSArray *selectedOptions;

-(void) setSelectedOptionWithValue:(NSString*)value;
-(void) setSelectedOptionWithOption:(UMDropDownOption*)option;
-(void) deselect;
-(void) clearOptions;
@end



@protocol UMDropDownDelegate <NSObject>

@required
- (void)dropDown:(UMDropDown *)dropDown didSelectOption:(UMDropDownOption *)option;

@optional
- (BOOL)dropDown:(UMDropDown *)dropDown willSelectOption:(UMDropDownOption *)option;
- (BOOL)dropDown:(UMDropDown *)dropDown willSelectOptions:(NSArray *)options;
- (void)dropDown:(UMDropDown *)dropDown didSelectOptions:(NSArray *)options;

@end



@protocol UMDropDownDataSource<NSObject>

@required
- (NSInteger)numberOfRowsForDropDownController:(UMDropDownContentViewController *)dropDownController;
- (UMDropDownOption *)dropDownController:(UMDropDownContentViewController *)dropDownController optionForIndex:(NSInteger)index;
- (UMDropDownOption *)selectedDropDownOption;

@optional
- (CGSize) sizeOfDropDownController:(UMDropDownContentViewController *)dropDownController;
@end