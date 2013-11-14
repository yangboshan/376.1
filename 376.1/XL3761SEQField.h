//
//  XL3761SEQField.h
//  XLDistributionBoxApp
//
//  376.1 Frame seq field
//
//  Created by JY on 13-5-21.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XL3761SEQField : NSObject

@property (nonatomic,assign) NSInteger TpV;       //帧时间标签有效位
@property (nonatomic,assign) NSInteger FIR;       //首帧标志
@property (nonatomic,assign) NSInteger FIN;       //末帧标志
@property (nonatomic,assign) NSInteger CON;       //请求确认标志位
@property (nonatomic,assign) NSInteger PSEQOrRSEQ;//启动帧序号/响应帧序号

-(id)initWith:(NSInteger)_tpv :(NSInteger)_fir :(NSInteger)_fin :(NSInteger)_con :(NSInteger)_pesqorresq;
@end
