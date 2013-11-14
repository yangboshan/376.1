//
//  XL3761AddressField.h
//  XLDistributionBoxApp
//
//  376.1 Frame address field
//
//  Created by JY on 13-5-21.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XL3761AddressField : NSObject

@property (nonatomic,assign) unsigned short *A1; //行政地址域
@property (nonatomic,assign) unsigned short *A2; //终端地址
@property (nonatomic,assign) Byte  *A3; //主站地址和组地址标志

-(id)initWith:(unsigned short*)_a1 :(unsigned short*)_a2 :(Byte *)_a3;
@end
