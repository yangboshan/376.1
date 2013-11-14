//
//  XL3761AddressField.m
//  XLDistributionBoxApp
//
//  376.1 Frame address field
//
//  Created by JY on 13-5-21.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761AddressField.h"

@implementation XL3761AddressField

@synthesize A1,A2,A3;

-(id)initWith:(unsigned short*)_a1 :(unsigned short*)_a2 :(Byte *)_a3
{
    if (self = [super init]) {
        self.A1 = _a1;
        self.A2 = _a2;
        self.A3 = _a3;
    }
    return self;
}

@end
