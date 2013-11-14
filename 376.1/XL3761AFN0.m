//
//  XL3761AFN0.m
//  XLDistributionBoxApp
//
//  确认／否认
//
//  Created by JY on 13-5-21.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761AFN0.h"

@implementation XL3761AFN0

-(id)init
{
    if (self = [super init]) {
        //...............
    }
    return self;
}

/*－－－－－－－－－－－－－－－－－－－－－－－
 全部确认：对收到报文中的全部数据单元标识进行确认
 
 F1
 －－－－－－－－－－－－－－－－－－－－－－－*/
-(void)F1
{
    NSLog(@"执行:%s",__func__);
    [self setReturnSet:0];
 
}

/*－－－－－－－－－－－－－－－－－－－－－－－
 全部否认：对收到报文中的全部数据单元标识进行否认
 
 F1
 －－－－－－－－－－－－－－－－－－－－－－－*/
-(void)F2
{
    NSLog(@"执行:%s",__func__);
    [self setReturnSet:1];
}

-(void)setReturnSet:(NSInteger)value{
    
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    
    [self.resultSet setValue:[NSNumber numberWithInteger:value] forKey:@"0"];
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:-1]];
}

@end
