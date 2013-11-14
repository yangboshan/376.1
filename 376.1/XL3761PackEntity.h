//
//  XL3761PackEntity.h
//  XLDistributionBoxApp
//
//  Created by JY on 13-8-22.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XL3761PackEntity : NSObject

//@property (nonatomic,assign) Byte afn;
@property (nonatomic,copy)   NSString *fn;
@property (nonatomic,assign) NSInteger userDataLength;
@property (nonatomic,strong) NSArray *userData;
@property (nonatomic,assign) BOOL useP0;
@end
