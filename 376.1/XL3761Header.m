//
//  XL3761Header.m
//  XLDistributionBoxApp
//
//  376.1 Frame header field
//
//  Created by JY on 13-5-21.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761Header.h"

@implementation XL3761Header

@synthesize start1,start2,lengthL1,lengthL2,cs,end;

-(id)initWith:(Byte*)_start1 :(unsigned short*)_lengthL1 :(unsigned short*) _lengthL2 :(Byte*)_start2 :(Byte*)_cs :(Byte*)_end
{
    if (self = [super init]) {
        self.start1 = _start1;
        self.start2 = _start2;
        self.lengthL1 = _lengthL1;
        self.lengthL2 = _lengthL2;
        self.cs = _cs;
        self.end = _end;
    }
    return  self;
}
@end
