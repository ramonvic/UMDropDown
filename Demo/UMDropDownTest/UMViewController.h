//
//  UMViewController.h
//  UMDropDownTest
//
//  Created by Ramon on 4/9/14.
//  Copyright (c) 2014 Umobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMDropDown.h"

@interface UMViewController : UIViewController <UMDropDownDelegate>

@property (strong, nonatomic) IBOutlet UMDropDown *dropDownEmptyOptions;
@property (strong, nonatomic) IBOutlet UMDropDown *dropDownWithOptions;
@property (strong, nonatomic) IBOutlet UMDropDown *dropDownWithOptionsString;
@property (strong, nonatomic) IBOutlet UMDropDown *dropDownSelectedValue;
@property (strong, nonatomic) IBOutlet UMDropDown *dropDownRemoteSelected;

@property (strong, nonatomic) IBOutlet UILabel *labelSelectedValue;

- (IBAction)selectValue:(UIButton *)sender;
@end
