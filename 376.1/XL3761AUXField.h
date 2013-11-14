//
//  XL3761AUXField.h
//  XLDistributionBoxApp
//
//  376.1 Frame aux field
//
//  Created by JY on 13-5-24.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XL3761AUXField : NSObject

@property (nonatomic,assign) Byte *PW;
@property (nonatomic,assign) unsigned short *EC;
@property (nonatomic,assign) Byte *Tp;

@property (nonatomic,assign) BOOL hasPW;
@property (nonatomic,assign) BOOL hasEC;
@property (nonatomic,assign) BOOL hasTp;

@end
