//
//  XLFramingRequest.h
//  XLDistributionBoxApp
//
//  组帧
//
//  Created by JY on 13-8-20.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XL3761PackEntity.h"
#import "XL3761PackItem.h"
#import "XL3761PackUserData.h"

@interface XL3761PackRequest : NSObject
 
-(NSData*)packFrame:(XL3761PackUserData*)userData;

@end
