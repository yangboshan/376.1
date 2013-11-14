//
//  XL3761ControlField.m
//  XLDistributionBoxApp
//
//  376.1 Frame control field
//
//  Created by JY on 13-5-21.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761ControlField.h"

@implementation XL3761ControlField

@synthesize DIR,PRM,FCBOrACD,FCV,CID;

-(id)initWith:(NSInteger)_dir :(NSInteger)_prm :(NSInteger)_fcboracd :(NSInteger)_fcv :(NSInteger)_cid
{
    if (self = [super init]) {
        self.DIR = _dir;
        self.PRM = _prm;
        self.FCBOrACD = _fcboracd;
        self.FCV = _fcv;
        self.CID = _cid;
    }
    return self;
}

@end
