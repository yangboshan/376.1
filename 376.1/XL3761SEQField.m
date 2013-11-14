//
//  XL3761SEQField.m
//  XLDistributionBoxApp
//
//  376.1 Frame seq field
//
//  Created by JY on 13-5-21.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761SEQField.h"

@implementation XL3761SEQField

@synthesize TpV,FIR,FIN,CON,PSEQOrRSEQ;

-(id)initWith:(NSInteger)_tpv :(NSInteger)_fir :(NSInteger)_fin :(NSInteger)_con :(NSInteger)_pesqorresq
{
    
    if (self = [super init]) {
        self.TpV = _tpv;
        self.FIR = _fir;
        self.FIN = _fin;
        self.CON = _con;
        self.PSEQOrRSEQ = _pesqorresq;
    }
    return self;
}
@end
