//
//  XL3761PackUserData.m
//  XLDistributionBoxApp
//
//  Created by JY on 13-9-12.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761PackUserData.h"

@implementation XL3761PackUserData


-(NSInteger)userDataLength{
    
    __block NSInteger length = 8;
    
    if (self.userData) {
        
        [self.userData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            XL3761PackEntity* entity = (XL3761PackEntity*)obj;
            length += entity.userDataLength;
        }];
    }
    return length;
}

@end
