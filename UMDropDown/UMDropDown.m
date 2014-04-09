//
//  UMDropdown.m
//
//  Created by Ramon on 1/9/14.
//  Copyright (c) 2014 Umobi. All rights reserved.
//

#import "UMDropDown.h"

@interface UMDropDown () <UMDropDownDelegate, UMDropDownDataSource>

@end

@implementation UMDropDown

-(void) awakeFromNib
{
    [self setup];
}

-(void) setup
{
    CALayer *labelLayer = [self layer];
    [labelLayer setMasksToBounds:YES];
    [labelLayer setCornerRadius:5.0f];
    [labelLayer setBorderWidth:0.5];
    [labelLayer setBorderColor: self.tintColor.CGColor];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [tapGesture addTarget:self action:@selector(openDropdown:)];
    
    [self addGestureRecognizer:tapGesture];
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 30);
    
    self.defaultText = self.titleLabel.text;
    
    if (_selectedOption != nil)
        [self setTitle:_selectedOption.text forState:UIControlStateNormal];
    
    _dropDownContentViewController = [[UMDropDownContentViewController alloc] init];
    _dropDownContentViewController.delegate = self;
    _dropDownContentViewController.dataSource = self;
    
    _dropDownContentViewController.cellFont = self.titleLabel.font;
    _dropDownContentViewController.cellTextColor = self.titleLabel.textColor;
}

- (void) openDropdown:(UITapGestureRecognizer *)tap {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (_popoverController) {
            [_popoverController dismissPopoverAnimated:YES];
        }
        
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        _popoverController = [[UIPopoverController alloc] initWithContentViewController:_dropDownContentViewController];
        [_popoverController setPopoverContentSize:[self sizeOfDropDownController:_dropDownContentViewController]];
        [_popoverController presentPopoverFromRect:frame inView:self permittedArrowDirections:UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown animated:YES];
    } else {
        [[NSException exceptionWithName:NSGenericException reason:@"UMDropDown only work on iPads devides" userInfo:nil] raise];
    }
}

-(void) setOptions:(NSArray*) options
{
    if (_dropDownContentViewController == nil) {
        [self setup];
    }
    
    NSMutableArray *_tempOptions = [[NSMutableArray alloc] init];
    for (id item in options) {
        if ([item isKindOfClass:[UMDropDownOption class]]) {
            [_tempOptions addObject: item];
        } else if ([item isKindOfClass:[NSString class]]) {
            UMDropDownOption *tempItem = [[UMDropDownOption alloc] init];
            tempItem.value = item;
            tempItem.text = item;
            
            [_tempOptions addObject: tempItem];
        }
    }
    _options = _tempOptions;
    
    [_dropDownContentViewController.tableViewOptions reloadData];
    
    if (_options.count == 1) {
        UMDropDownOption *option = [_options firstObject];
        [self dropDown:self didSelectOption:option];
    }
}

-(void) setSelectedOptionWithValue:(NSString*)value
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"value  ==[c] %@", value];
    
    NSArray *itens = [_options filteredArrayUsingPredicate:predicate];
    
    if (itens.count == 1) {
        self.selectedOption = [itens objectAtIndex:0];
        
        [self performSelectorOnMainThread:@selector(setTitle:) withObject:_selectedOption.text waitUntilDone:YES];
        [self.delegate performSelector:@selector(dropDown:didSelectOption:) withObject:self withObject:_selectedOption];
    }
}

-(void) setSelectedOptionWithOption:(UMDropDownOption *)option
{
    [self setSelectedOptionWithValue:option.value];
}

-(void) deselect
{
    self.selectedOption = nil;
    
    [self setTitle:self.defaultText];
}

-(void) setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}

-(void) clearOptions
{
    _options = [NSArray array];
    [_dropDownContentViewController.tableViewOptions reloadData];
}

-(CGSize) calculateSizeFromOptions
{
    CGFloat width = 0;
    CGFloat height = 0;
    for (UMDropDownOption *item in _options) {
        NSString *titleitem;
        if ([item isKindOfClass:[NSString class]]) {
            titleitem = (NSString*)item;
        } else {
            titleitem = item.text;
        }
        width = MAX(width, ([titleitem sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font, NSFontAttributeName, nil]].width));
    }
    width = width + 50;
    width = MIN(width, 500);
    width = MAX(width, self.frame.size.width);
    
    height = MIN(_options.count * 44, 300);
    height = height + 20;
    
    return CGSizeMake(width, height);
}

- (void)drawRect:(CGRect)rect
{
    [self drawArrow:CGSizeMake(16, 7)];
    [super drawRect:rect];
}

- (void) drawArrow: (CGSize)size
{
    CGFloat y = (self.frame.size.height/2) - (size.height/2);
    CGFloat x = self.frame.size.width - 26;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(x, y)];
    [bezierPath addLineToPoint: CGPointMake(x + (size.width/2), y + size.height)];
    [bezierPath addLineToPoint: CGPointMake(x + size.width, y)];
    [self.titleLabel.textColor setStroke];
    bezierPath.lineWidth = 2;
    [bezierPath stroke];
}

#pragma mark - Delegate and DataSource
- (BOOL)dropDown:(UMDropDown *)dropDown willSelectOption:(UMDropDownOption *)option
{
    if ([self.delegate respondsToSelector:@selector(dropDown:willSelectOption:)]) {
        return [self.delegate dropDown:self willSelectOption:option];
    }
    return YES;
}

- (void)dropDown:(UMDropDown *)dropDown didSelectOption:(UMDropDownOption *)option
{
    if (![_selectedOption isEqual:option]) {
        self.selectedOption = option;
        [self setTitle:_selectedOption.text];
        if ([self.delegate respondsToSelector:@selector(dropDown:didSelectOption:)]) {
            [self.delegate dropDown:self didSelectOption:option];
        }
    }
    
    [_popoverController dismissPopoverAnimated:YES];
}
- (BOOL)dropDown:(UMDropDown *)dropDown willSelectOptions:(NSArray *)options
{
    if ([self.delegate respondsToSelector:@selector(dropDown:willSelectOptions:)]) {
        return [self.delegate dropDown:self willSelectOptions:options];
    }
    return YES;
}

- (void)dropDown:(UMDropDown *)dropDown didSelectOptions:(NSArray *)options
{
    if (![_selectedOptions isEqual:options]) {
        self.selectedOptions = options;
        
        [self setTitle:@"Vários itens selecionados"];
        if ([self.delegate respondsToSelector:@selector(dropDown:didSelectOptions:)]) {
            [self.delegate dropDown:self didSelectOptions:options];
        }
    }
    
    [_popoverController dismissPopoverAnimated:YES];
}

- (NSInteger)numberOfRowsForDropDownController:(UMDropDownContentViewController *)dropDownController
{
    return [_options count];
}

- (CGSize) sizeOfDropDownController:(UMDropDownContentViewController *)dropDownController
{
    return [self calculateSizeFromOptions];
}

- (UMDropDownOption *)dropDownController:(UMDropDownContentViewController *)dropDownController optionForIndex:(NSInteger)index
{
    UMDropDownOption *option = (UMDropDownOption*)[_options objectAtIndex:index];
    if ([option isEqual:_selectedOption]) {
        option.selected = YES;
    } else {
        option.selected = NO;
    }
    return option;
}

- (UMDropDownOption *) selectedDropDownOption
{
    return _selectedOption;
}

-(void) setSelectedOption:(UMDropDownOption *)selectedOption
{
    _selectedOption = selectedOption;
    [_dropDownContentViewController.tableViewOptions reloadData];
}

-(void) setSelectedOptions:(NSArray *)selectedOptions
{
    _selectedOptions = selectedOptions;
    [_dropDownContentViewController.tableViewOptions reloadData];
}

-(NSString *) description
{
    return [NSString stringWithFormat:@"<%@: %p>", self.class, self];
}

@end
