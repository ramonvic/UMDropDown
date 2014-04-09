//
//  UMDropDownOption.h
//  Cilia
//
//  Created by Ramon on 1/9/14.
//  Copyright (c) 2014 Umobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMDropDownOption : NSObject

@property(nonatomic, strong) NSString *value;
@property(nonatomic, strong) NSString *text;
@property(nonatomic) BOOL selected;

+(id) optionWithText: (NSString *) text value:(NSString *) value;
-(id) initWithText: (NSString *) text value:(NSString *) value;
@end