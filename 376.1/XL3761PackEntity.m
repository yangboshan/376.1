//
//  XL3761PackEntity.m
//  XLDistributionBoxApp
//
//  Created by JY on 13-8-22.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761PackEntity.h"
#import "XL3761PackItem.h"

@implementation XL3761PackEntity

//-(id)init{
//    if (self = [super init]) {
//    }
//    return self;
//}

-(NSInteger)userDataLength{
    
    __block NSInteger length = 4;
    
    if (self.userData) {
        [self.userData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            XL3761PackItem *item = (XL3761PackItem*)obj;
            length += item.byteslen;
        }];
    }
    
    return length;
}
@end
