//
//  UMViewController.m
//  UMDropDownTest
//
//  Created by Ramon on 4/9/14.
//  Copyright (c) 2014 Umobi. All rights reserved.
//

#import "UMViewController.h"

@implementation UMViewController
{
    NSArray *options;
    NSArray *optionStrings;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    options = [NSArray arrayWithObjects:
                        [UMDropDownOption optionWithText:@"Option 1" value:@"1"],
                        [UMDropDownOption optionWithText:@"Option 2" value:@"2"],
                        [UMDropDownOption optionWithText:@"Option 3" value:@"3"],
                        [UMDropDownOption optionWithText:@"Option 4" value:@"4"],
                        [UMDropDownOption optionWithText:@"Option 5" value:@"5"],
                        [UMDropDownOption optionWithText:@"Option 6" value:@"6"],
                        [UMDropDownOption optionWithText:@"Option 7" value:@"7"], nil];
    
    optionStrings = [NSArray arrayWithObjects:
                              @"Option 1",
                              @"Option 2",
                              @"Option 3",
                              @"Option 4",
                              @"Option 5",
                              @"Option 6",
                              @"Option 7", nil];
    
    //Setting delegate to Dropdowns
    self.dropDownEmptyOptions.delegate = self;
    self.dropDownWithOptions.delegate = self;
    self.dropDownWithOptionsString.delegate = self;
    self.dropDownSelectedValue.delegate = self;
    self.dropDownRemoteSelected.delegate = self;
    
    
    //Setting options for Dropdowns
    self.dropDownEmptyOptions.options = @[];
    self.dropDownWithOptions.options = options;
    self.dropDownWithOptionsString.options = optionStrings;
    self.dropDownSelectedValue.options = options;
    self.dropDownRemoteSelected.options = options;
    
    
    //Need a valid value in array options to work
    [self.dropDownSelectedValue setSelectedOptionWithValue:@"3"];
}

- (IBAction)selectValue:(UIButton *)sender {
    int selectedIndex = arc4random_uniform((int)options.count);
    
    UMDropDownOption *selectedOption = [options objectAtIndex:selectedIndex];
    [self.dropDownRemoteSelected setSelectedOptionWithOption:selectedOption];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UMDropDown Delegate Methods

- (void)dropDown:(UMDropDown *)dropDown didSelectOption:(UMDropDownOption *)option
{
    NSLog(@"The %@ changed option", dropDown);
    
    self.labelSelectedValue.text = [NSString stringWithFormat:@"Text: '%@' - Value: '%@'", option.text, option.value];
}
@end
