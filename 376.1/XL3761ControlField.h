//
//  XL3761ControlField.h
//  XLDistributionBoxApp
//
//  376.1 Frame control field
//
//  Created by JY on 13-5-21.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XL3761ControlField : NSObject

@property (nonatomic,assign) NSInteger DIR;     //传输方向位
@property (nonatomic,assign) NSInteger PRM;     //启动标志位
@property (nonatomic,assign) NSInteger FCBOrACD;//帧计数位OR要求访问位
@property (nonatomic,assign) NSInteger FCV;     //帧计数有效位
@property (nonatomic,assign) NSInteger CID;     //功能码

-(id)initWith:(NSInteger)_dir :(NSInteger)_prm :(NSInteger)_fcboracd :(NSInteger)_fcv :(NSInteger)_cid;

@end
