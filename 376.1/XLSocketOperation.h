//
//  XLSocketOperation.h
//  XLDistributionBoxApp
//
//  Created by JY on 13-5-15.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLSocketOperation : NSOperation


@property(nonatomic,retain) id target;
@property(nonatomic,retain) id object;
@property(nonatomic)       SEL selector;

@end
