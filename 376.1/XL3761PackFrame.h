//
//  XL3761PackFrame.h
//  XLDistributionBoxApp
//
//  Created by JY on 13-8-29.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLExternals.h" 

@interface XL3761PackFrame : NSObject

+(XL3761PackFrame*)sharedXL3761PackFrame;



/*－－－－－－－－－－－－－－
 通用召测
 －－－－－－－－－－－－－－*/
-(void)commonRequestWithAfn:(Byte)afn withFn:(NSString*)fn;



/*－－－－－－－－－－－－－－
 通用召测
 
 数据时标 Tdm  月年
 －－－－－－－－－－－－－－*/
-(void)commonRequestWithAfn:(Byte)afn
                     withFn:(NSArray*)fn
                   withTdm:(NSString*)tdm;

/*－－－－－－－－－－－－－－
 通用召测
 
 数据时标 Tdm  日月年
 －－－－－－－－－－－－－－*/
-(void)commonRequestWithAfn:(Byte)afn
                     withFn:(NSArray*)fn
                    withTdd:(NSString*)tdd;


/*－－－－－－－－－－－－－－
 通用召测
 
 数据时标 Tdc  曲线数据时标
 －－－－－－－－－－－－－－*/
-(void)commonRequestWithAfn:(Byte)afn
                     withFn:(NSArray*)fn
                    withTdc:(NSString*)tdc;

/*－－－－－－－－－－－－－－
 通用召测
 
 F1 重要事件 F2 一般事件
 
 召测事件 pm 起始指针  pn 结束指针
 －－－－－－－－－－－－－－*/
-(void)commonRequestWithAfn:(Byte)afn
                     withFn:(NSString*)fn
                     withPm:(NSInteger)pm
                     withPn:(NSInteger)pn;


/*－－－－－－－－－－－－－－
 对时 
 
 AFN05 F31
 －－－－－－－－－－－－－－*/
-(void)setDeviceClock;



/*－－－－－－－－－－－－－－
 测量点限值参数
 
 AFN04 F26
 －－－－－－－－－－－－－－*/
-(void)setDevicePara;
@end
