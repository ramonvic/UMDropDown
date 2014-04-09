//
//  UMDropDownOption.m
//  Cilia
//
//  Created by Ramon on 1/9/14.
//  Copyright (c) 2014 Umobi. All rights reserved.
//

#import "UMDropDownOption.h"

@implementation UMDropDownOption

+(id) optionWithText: (NSString *) text value:(NSString *) value
{
    return [[self alloc] initWithText:text value:value];
}

-(id) initWithText: (NSString *) text value:(NSString *) value
{
    self = [super init];
    if (self) {
        _text = text;
        _value = value;
    }
    
    return self;
}

-(BOOL) isEqual:(UMDropDownOption*)other
{
    return [self.value isEqualToString:other.value];
}

-(NSString *) description
{
    return [NSString stringWithFormat:@"%@ - %@", self.value, self.text];
}

@end
