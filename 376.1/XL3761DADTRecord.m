//
//  XL3761DADTRecord.m
//  XLDistributionBoxApp
//
//  376.1 Frame dadt record
//
//  Created by JY on 13-5-22.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761DADTRecord.h"

@implementation XL3761DADTRecord
@synthesize pId,fId;

-(id)initWith:(NSInteger)_fId :(NSInteger)_pId
{
    if (self=[super init]) {
        self.pId = _pId;
        self.fId = _fId;
    }
    return self;
}
@end
