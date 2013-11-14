//
//  XL3761PackUserData.h
//  XLDistributionBoxApp
//
//  Created by JY on 13-9-12.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XL3761PackEntity.h"

@interface XL3761PackUserData : NSObject

@property (nonatomic,assign) Byte afn;
@property (nonatomic,assign) NSInteger userDataLength;
@property (nonatomic,strong) NSArray *userData;

@end
