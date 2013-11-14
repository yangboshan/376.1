//
//  XL3761Header.h
//  XLDistributionBoxApp
//
//  376.1 Frame header field
//
//  Created by JY on 13-5-21.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XL3761Header : NSObject

@property (nonatomic,assign) Byte *start1;
@property (nonatomic,assign) unsigned short *lengthL1;
@property (nonatomic,assign) unsigned short *lengthL2;
@property (nonatomic,assign) Byte *start2;
@property (nonatomic,assign) Byte *cs;
@property (nonatomic,assign) Byte *end;

-(id)initWith:(Byte*)_start1 :(unsigned short*)_lengthL1 :(unsigned short*) _lengthL2 :(Byte*)_start2 :(Byte*)_cs :(Byte*)_end;
@end
