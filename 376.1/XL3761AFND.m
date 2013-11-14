//
//  XL3761AFND.m
//  XLDistributionBoxApp
//
//  请求2类数据
//
//  Created by JY on 13-5-21.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761AFND.h"

@implementation XL3761AFND


-(id)init
{
    if (self = [super init]) {
    //...............
    }
    return self;
}

/*－－－－－－－－－－－－－－/
日冻结
 
费率数
正向有功电能示值
正向无功电能示值
一象限无功电能示值 说明:2类数据
四象限无功电能示值 说明:2类数据
/－－－－－－－－－－－－－－*/
-(void)F1
{
    NSLog(@"执行:%s",__func__);

    self.pos += 8;
    [self afnDRetriveCommonData1WithKey1:Msn_Indication_AE_Pos_Z_Day
                           withKey2:Msn_Indication_RE_Pos_Z_Day
                           withKey3:Msn_Indication_RE_Z_Quad_1_Day
                           withKey4:Msn_Indication_RE_Z_Quad_4_Day];
}

/*－－－－－－－－－－－－－－/
日冻结
 
费率数
反向有功电能示值
反向无功电能示值
二象限无功电能示值 说明:2类数据
三象限无功电能示值 说明:2类数据
/－－－－－－－－－－－－－－*/
-(void)F2
{
    NSLog(@"执行:%s",__func__);
    
    self.pos += 8;
    [self afnDRetriveCommonData1WithKey1:Msn_Indication_AE_Neg_Z_Day
                           withKey2:Msn_Indication_RE_Neg_Z_Day
                           withKey3:Msn_Indication_RE_Z_Quad_2_Day
                           withKey4:Msn_Indication_RE_Z_Quad_3_Day];
}


/*－－－－－－－－－－－－－－/
抄表日冻结
 
费率数
正向有功电能示值
正向无功电能示值
一象限无功电能示值 说明:2类数据
四象限无功电能示值 说明:2类数据
/－－－－－－－－－－－－－－*/
-(void)F9
{
    NSLog(@"执行:%s",__func__);
    
    self.pos += 8;
    [self afnDRetriveCommonData1WithKey1:Msn_Indication_AE_Pos_Z_CB_Day
                           withKey2:Msn_Indication_RE_Pos_Z_CB_Day
                           withKey3:Msn_Indication_RE_Z_Quad_1_CB_Day
                           withKey4:Msn_Indication_RE_Z_Quad_4_CB_Day];
}

/*－－－－－－－－－－－－－－/
抄表日冻结
 
费率数
反向有功电能示值
反向无功电能示值
二象限无功电能示值 说明:2类数据
三象限无功电能示值 说明:2类数据
/－－－－－－－－－－－－－－*/
-(void)F10
{
    NSLog(@"执行:%s",__func__);

    self.pos += 8;
    [self afnDRetriveCommonData1WithKey1:Msn_Indication_AE_Neg_Z_CB_Day
                           withKey2:Msn_Indication_RE_Neg_Z_CB_Day
                           withKey3:Msn_Indication_RE_Z_Quad_2_CB_Day
                           withKey4:Msn_Indication_RE_Z_Quad_3_CB_Day];
}

/*－－－－－－－－－－－－－－/
月冻结
 
费率数
正向有功电能示值
正向无功电能示值
一象限无功电能示值 说明:2类数据
四象限无功电能示值 说明:2类数据
/－－－－－－－－－－－－－－*/
-(void)F17
{
    NSLog(@"执行:%s",__func__);
    
    self.pos += 7;
    [self afnDRetriveCommonData1WithKey1:Msn_Indication_AE_Pos_Z_Mon
                           withKey2:Msn_Indication_RE_Pos_Z_Mon
                           withKey3:Msn_RE_Quad_1_Z_Mon
                           withKey4:Msn_RE_Quad_4_Z_Mon];
}

/*－－－－－－－－－－－－－－/
月冻结
 
费率数
反向有功电能示值
反向无功电能示值
二象限无功电能示值 说明:2类数据
三象限无功电能示值 说明:2类数据
/－－－－－－－－－－－－－－*/
-(void)F18
{
    NSLog(@"执行:%s",__func__);

    self.pos += 7;
    [self afnDRetriveCommonData1WithKey1:Msn_Indication_AE_Neg_Z_Mon
                           withKey2:Msn_Indication_RE_Neg_Z_Mon
                           withKey3:Msn_RE_Quad_2_Z_Mon
                           withKey4:Msn_RE_Quad_3_Z_Mon];
}




/*－－－－－－－－－－－－－－/
 日冻结
 
 费率数
 正向有功总最大需量
 正向有功总最大需量发生时间
 正向无功总最大需量
 正向无功总最大需量发生时间
 /－－－－－－－－－－－－－－*/
-(void)F3
{
    NSLog(@"执行:%s",__func__);
    
    self.pos += 8;
    
    [self afnDRetriveCommonData2WithKey1:Msn_EV_Max_Z_AE_Pos_Day
                                withKey2:Msn_Time_Max_EV_Z_AE_Pos_Day
                                withKey3:Msn_EV_Max_Z_RE_Pos_Day
                                withKey4:Msn_Time_Max_EV_Z_RE_Pos_Day];
}

/*－－－－－－－－－－－－－－/
 日冻结
 
 费率数
 反向有功总最大需量
 反向有功总最大需量发生时间
 反向无功总最大需量
 反向无功总最大需量发生时间
 /－－－－－－－－－－－－－－*/
-(void)F4
{
    NSLog(@"执行:%s",__func__);
    
    self.pos += 8;
    
    [self afnDRetriveCommonData2WithKey1:Msn_EV_Max_Z_AE_Neg_Day
                                withKey2:Msn_Time_Max_EV_Z_AE_Neg_Day
                                withKey3:Msn_EV_Max_Z_RE_Neg_Day
                                withKey4:Msn_Time_Max_EV_Z_RE_Neg_Day];
}


/*－－－－－－－－－－－－－－/
 抄表日冻结
 
 费率数
 正向有功总最大需量
 正向有功总最大需量发生时间
 正向无功总最大需量
 正向无功总最大需量发生时间
 /－－－－－－－－－－－－－－*/
-(void)F11
{
    NSLog(@"执行:%s",__func__);
    
    self.pos += 8;
    
    [self afnDRetriveCommonData2WithKey1:Msn_EV_Max_Z_AE_Pos_CB_Day
                                withKey2:Msn_Time_Max_EV_Z_AE_Pos_CB_Day
                                withKey3:Msn_EV_Max_Z_RE_Pos_CB_Day
                                withKey4:Msn_Time_Max_EV_Z_RE_Pos_CB_Day];
}

/*－－－－－－－－－－－－－－/
 抄表日冻结
 
 费率数
 反向有功总最大需量
 反向有功总最大需量发生时间
 反向无功总最大需量
 反向无功总最大需量发生时间
 /－－－－－－－－－－－－－－*/
-(void)F12
{
    NSLog(@"执行:%s",__func__);
    
    self.pos += 8;
    
    [self afnDRetriveCommonData2WithKey1:Msn_EV_Max_Z_AE_Neg_CB_Day
                                withKey2:Msn_Time_Max_EV_Z_AE_Neg_CB_Day
                                withKey3:Msn_EV_Max_Z_RE_Neg_CB_Day
                                withKey4:Msn_Time_Max_EV_Z_RE_Neg_CB_Day];
}


/*－－－－－－－－－－－－－－/
 月冻结
 
 费率数
 正向有功总最大需量
 正向有功总最大需量发生时间
 正向无功总最大需量
 正向无功总最大需量发生时间
 /－－－－－－－－－－－－－－*/
-(void)F19
{
    NSLog(@"执行:%s",__func__);
    
    self.pos += 7;
    
    [self afnDRetriveCommonData2WithKey1:Msn_EV_Max_Z_AE_Pos_Mon
                                withKey2:Msn_Time_Max_EV_Z_AE_Pos_Mon
                                withKey3:Msn_EV_Max_Z_RE_Pos_Mon
                                withKey4:Msn_Time_Max_EV_Z_RE_Pos_Mon];
}

/*－－－－－－－－－－－－－－/
 月冻结
 
 费率数
 反向有功总最大需量
 反向有功总最大需量发生时间
 反向无功总最大需量
 反向无功总最大需量发生时间
 /－－－－－－－－－－－－－－*/
-(void)F20
{
    NSLog(@"执行:%s",__func__);
    
    self.pos += 7;
    
    [self afnDRetriveCommonData2WithKey1:Msn_EV_Max_Z_AE_Neg_Mon
                                withKey2:Msn_Time_Max_EV_Z_AE_Neg_Mon
                                withKey3:Msn_EV_Max_Z_RE_Neg_Mon
                                withKey4:Msn_Time_Max_EV_Z_RE_Neg_Mon];
}



/*－－－－－－－－－－－－－－/
 日冻结
 
 总及分相最大有功功率及发生时间
 /－－－－－－－－－－－－－－*/
-(void)F25{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCommonData4WithKey:Msn_AP_Max_Z_3P_Day
                               withKey2:Msn_Time_Max_AP_Z_3P_Day
                               withKey3:Msn_Time_AP_Zero_Z_3P_Day];
    
}


/*－－－－－－－－－－－－－－/
 日冻结
 
 总及分相最大需量及发生时间
 /－－－－－－－－－－－－－－*/
-(void)F26{
    
    NSLog(@"执行:%s",__func__);
    
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    
    
    self.pos += 1;
    [self performGenericWithKey:Msn_EV_Max_Z_AE_Day
                       withKey2:Msn_Time_Max_EV_Z_AE_Day
                     withLength:3
                  withLoopTimes:4
                      withDigit:4];
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
    
}

/*－－－－－－－－－－－－－－/
 日冻结
 
 日不平衡度越限累计时间
 /－－－－－－－－－－－－－－*/
-(void)F28{
    NSLog(@"执行:%s",__func__);
    
    
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    
    self.pos += 3;
    
    
    NSInteger time = *(unsigned short*)(self.userData + self.pos);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:time]
                      forKey:[self getKeyString:Msn_Time_Acc_Cur_Non_Balance]];
    self.pos += 14;
    
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
    
}

/*－－－－－－－－－－－－－－/
 日冻结
 
 终端日供电时间 日复位累计次数
 /－－－－－－－－－－－－－－*/
-(void)F49{
    NSLog(@"执行:%s",__func__);
    
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    
    self.pos += 3;
    
    NSInteger time = *(unsigned short*)(self.userData + self.pos);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:time]
                      forKey:[self getKeyString:Tmn_Time_Acc_Run_Day]];
    self.pos += 2;
    
    NSInteger times = *(unsigned short*)(self.userData + self.pos);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:times]
                      forKey:[self getKeyString:Tmn_Times_Acc_Reset_Day]];
    self.pos += 2;
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
    
    
}



/*－－－－－－－－－－－－－－/
 月冻结
 
 月总及分相最大有功功率发生时间
 
 有功功率为零时间
 /－－－－－－－－－－－－－－*/
-(void)F33{
    
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCommonData3WithKey:Msn_AP_Max_Z_3P_Mon
                               withKey2:Msn_Time_Max_AP_Z_3P_Mon
                               withKey3:Msn_Time_AP_Zero_Z_3P_Mon];
    
}

/*－－－－－－－－－－－－－－/
 月冻结
 
 月总及分相最大需量及发生时间
 /－－－－－－－－－－－－－－*/
-(void)F34{
    
    NSLog(@"执行:%s",__func__);
    
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    
    [self performGenericWithKey:Msn_EV_Max_Z_AE_Mon
                       withKey2:Msn_Time_Max_EV_Z_AE_Mon
                     withLength:3
                  withLoopTimes:4
                      withDigit:4];
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
    
}

/*－－－－－－－－－－－－－－/
 月冻结
 
 月不平衡度越限累计时间
 /－－－－－－－－－－－－－－*/
-(void)F36{
    NSLog(@"执行:%s",__func__);
    
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    
    self.pos += 2;
    
    
    NSInteger time = *(unsigned short*)(self.userData + self.pos);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:time]
                      forKey:[self getKeyString:Msn_Time_Acc_Cur_Non_Balance_Mon]];
    self.pos += 16;
    
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
    
}
/*－－－－－－－－－－－－－－/
 月冻结
 
 终端月供电时间 月复位累计次数
 /－－－－－－－－－－－－－－*/
-(void)F51{
    
    NSLog(@"执行:%s",__func__);
    
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    
    self.pos += 2;
    
    NSInteger time = *(unsigned short*)(self.userData + self.pos);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:time]
                      forKey:[self getKeyString:Tmn_Time_Acc_Run_Mon]];
    self.pos += 2;
    
    NSInteger times = *(unsigned short*)(self.userData + self.pos);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:times]
                      forKey:[self getKeyString:Tmn_Times_Acc_Reset_Mon]];
    self.pos += 2;
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
}


/*－－－－－－－－－－－－－－/
 日冻结
 
 电压统计数据
 /－－－－－－－－－－－－－－*/
-(void)F27{
    
    NSLog(@"执行:%s",__func__);
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    
    
    self.pos += 3;
    NSInteger key = 0;
    for(int i =0;i <  3; i++){
        
        self.pos += 4;
        
        NSInteger time1 = *(unsigned short*)(self.userData + self.pos);
        [self.resultSet setValue:[NSNumber numberWithUnsignedChar:time1]
                          forKey:[self getKeyString:key++]];
        self.pos += 2;
        
        NSInteger time2 = *(unsigned short*)(self.userData + self.pos);
        [self.resultSet setValue:[NSNumber numberWithUnsignedChar:time2]
                          forKey:[self getKeyString:key++]];
        self.pos += 2;
        
        NSInteger time3 = *(unsigned short*)(self.userData + self.pos);
        [self.resultSet setValue:[NSNumber numberWithUnsignedChar:time3]
                          forKey:[self getKeyString:key++]];
        self.pos += 2;
    }
    
    self.pos += 36;
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
    
}

/*－－－－－－－－－－－－－－/
 月冻结
 
 电压统计数据
 /－－－－－－－－－－－－－－*/
-(void)F35{
    
    NSLog(@"执行:%s",__func__);
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    
    
    self.pos += 2;
    
    for(int i =0;i <  15; i++){
        NSInteger time = *(unsigned short*)(self.userData + self.pos);
        [self.resultSet setValue:[NSNumber numberWithUnsignedChar:time]
                          forKey:[self getKeyString:i]];
        self.pos += 2;
    }
    
    self.pos += 36;
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
    
}

/*－－－－－－－－－－－－－－/
 月冻结
 
 月功率因数区段累计时间
 /－－－－－－－－－－－－－－*/
-(void)F44{
    NSLog(@"执行:%s",__func__);
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    
    
    self.pos += 2;
    
    for(int i =0;i < 3; i++){
        NSInteger time = *(unsigned short*)(self.userData + self.pos);
        [self.resultSet setValue:[NSNumber numberWithUnsignedChar:time]
                          forKey:[self getKeyString:i]];
        self.pos += 2;
    }
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
}


/*－－－－－－－－－－－－－－/
 有功功率曲线
/－－－－－－－－－－－－－－*/
-(void)F81{
    
    NSLog(@"执行:%s",__func__);
    
   [self afnDRetriveCurveData1WithKey:Msn_Curve_AP
                           withLength:3
                            withDigit:4];
}


/*－－－－－－－－－－－－－－/
 A相有功功率曲线
 /－－－－－－－－－－－－－－*/
-(void)F82{
    
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Msn_Curve_AP_A
                            withLength:3
                             withDigit:4];
}


/*－－－－－－－－－－－－－－/
 B相有功功率曲线
 /－－－－－－－－－－－－－－*/
-(void)F83{
    
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Msn_Curve_AP_B
                            withLength:3
                             withDigit:4];
}


/*－－－－－－－－－－－－－－/
 C相有功功率曲线
 /－－－－－－－－－－－－－－*/
-(void)F84{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Msn_Curve_AP_C
                            withLength:3
                             withDigit:4];
    
}

/*－－－－－－－－－－－－－－/
 无功功率曲线
 /－－－－－－－－－－－－－－*/
-(void)F85{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Msn_Curve_RP
                            withLength:3
                             withDigit:4];
}


/*－－－－－－－－－－－－－－/
 A相无功功率曲线
 /－－－－－－－－－－－－－－*/
-(void)F86{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Msn_Curve_RP_A
                            withLength:3
                             withDigit:4];
}


/*－－－－－－－－－－－－－－/
 B相无功功率曲线
 /－－－－－－－－－－－－－－*/
-(void)F87{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Msn_Curve_RP_B
                            withLength:3
                             withDigit:4];
}


/*－－－－－－－－－－－－－－/
 C相无功功率曲线
 /－－－－－－－－－－－－－－*/
-(void)F88{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Msn_Curve_RP_C
                            withLength:3
                             withDigit:4];
}


/*－－－－－－－－－－－－－－/
 A相电压曲线
 /－－－－－－－－－－－－－－*/
-(void)F89{
    
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData2WithKey:Msn_Curve_Vol_A
                            withLength:2
                             withDigit:1];
}


/*－－－－－－－－－－－－－－/
 B相电压曲线
 /－－－－－－－－－－－－－－*/
-(void)F90{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData2WithKey:Msn_Curve_Vol_B
                            withLength:2
                             withDigit:1];
}


/*－－－－－－－－－－－－－－/
 C相电压曲线
 /－－－－－－－－－－－－－－*/
-(void)F91{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData2WithKey:Msn_Curve_Vol_C
                            withLength:2
                             withDigit:1];
}


/*－－－－－－－－－－－－－－/
 A相电流曲线
 /－－－－－－－－－－－－－－*/
-(void)F92{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Msn_Curve_Cur_A
                            withLength:3
                             withDigit:3];
}


/*－－－－－－－－－－－－－－/
 B相电流曲线
 /－－－－－－－－－－－－－－*/
-(void)F93{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Msn_Curve_Cur_B
                            withLength:3
                             withDigit:3];
}


/*－－－－－－－－－－－－－－/
 C相电压流曲线
 /－－－－－－－－－－－－－－*/
-(void)F94{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Msn_Curve_Cur_C
                            withLength:3
                             withDigit:3];
}


/*－－－－－－－－－－－－－－/
 总功率因数
 /－－－－－－－－－－－－－－*/
-(void)F105{
    
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Msn_Currve_Cur_PF
                            withLength:2
                             withDigit:1];
    
}

/*－－－－－－－－－－－－－－/
 A相总功率因数
 /－－－－－－－－－－－－－－*/
-(void)F106{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Msn_Currve_Cur_PF_A
                            withLength:2
                             withDigit:1];
}

/*－－－－－－－－－－－－－－/
 B相总功率因数
 /－－－－－－－－－－－－－－*/
-(void)F107{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Msn_Currve_Cur_PF_B
                            withLength:2
                             withDigit:1];
}

/*－－－－－－－－－－－－－－/
 C相总功率因数
 /－－－－－－－－－－－－－－*/
-(void)F108{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Msn_Currve_Cur_PF_C
                            withLength:2
                             withDigit:1];
}


/*－－－－－－－－－－－－－－/
 油温曲线
 /－－－－－－－－－－－－－－*/
-(void)F223{
    NSLog(@"执行:%s",__func__);
    
    [self afnDRetriveCurveData1WithKey:Tmn_Temperature
                            withLength:2
                             withDigit:1];
}

/*－－－－－－－－－－－－－－/
 A相绕组温度曲线
 /－－－－－－－－－－－－－－*/
-(void)F224{
    [self afnDRetriveCurveData1WithKey:Tmn_Temperature
                            withLength:2
                             withDigit:1];
}

/*－－－－－－－－－－－－－－/
 B相绕组温度曲线
 /－－－－－－－－－－－－－－*/
-(void)F225{
    [self afnDRetriveCurveData1WithKey:Tmn_Temperature
                            withLength:2
                             withDigit:1];
}

/*－－－－－－－－－－－－－－/
 C相绕组温度曲线
 /－－－－－－－－－－－－－－*/
-(void)F226{
    [self afnDRetriveCurveData1WithKey:Tmn_Temperature
                            withLength:2
                             withDigit:1];
}


//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－


/*－－－－－－－－－－－－－－/
 总,费率1～M;
 总,费率1～M;
 总,费率1～M;
 总,费率1～M
 
 F1 F2 F9 F10 F17 F18
/－－－－－－－－－－－－－－*/
-(void)afnDRetriveCommonData1WithKey1:(NSInteger)key1
                             withKey2:(NSInteger)key2
                             withKey3:(NSInteger)key3
                             withKey4:(NSInteger)key4
{
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    
    NSInteger rate = *(Byte*)(self.userData + self.pos);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:rate]
                      forKey:[self getKeyString:Tmn_Para_Tariff_Num]];
    self.pos += 1;

    [self performGenericWithKey:key1
                     withLength:5
                       withRate:rate
                      withDigit:4];
    
    [self performGenericWithKey:key2
                     withLength:4
                       withRate:rate
                      withDigit:2];
    
    [self performGenericWithKey:key3
                     withLength:4
                       withRate:rate
                      withDigit:2];
    
    [self performGenericWithKey:key4
                     withLength:4
                       withRate:rate
                      withDigit:2];
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    self.keyCount += 1;
}

/*－－－－－－－－－－－－－－/
 F3 F4 F11 F12 F19 F20
 /－－－－－－－－－－－－－－*/
-(void)afnDRetriveCommonData2WithKey1:(NSInteger)key1
                             withKey2:(NSInteger)key2
                             withKey3:(NSInteger)key3
                             withKey4:(NSInteger)key4
{
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    
    NSInteger rate = *(Byte*)(self.userData + self.pos);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:rate]
                      forKey:[self getKeyString:Tmn_Para_Tariff_Num]];
    self.pos += 1;
    
    [self performGenericWithKey:key1
                     withLength:3
                       withRate:rate
                      withDigit:2];
    
    [self performGenericWithKey:key2
                     withLength:4
                       withRate:rate];
    
    [self performGenericWithKey:key3
                     withLength:3
                       withRate:rate
                      withDigit:2];
    
    [self performGenericWithKey:key4
                     withLength:4
                       withRate:rate];
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
}

-(void)afnDRetriveCommonData3WithKey:(NSInteger)key
                            withKey2:(NSInteger)key2
                            withKey3:(NSInteger)key3{
    
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];

    [self performGenericWithKey:key
                        withKey2:key2
                      withLength:3
                   withLoopTimes:4
                       withDigit:4];
 
    for( int i = 0; i < 4; i ++){
        NSInteger time = *(unsigned short*)(self.userData + self.pos);
        [self.resultSet setValue:[NSNumber numberWithUnsignedChar:time]
                          forKey:[self getKeyString:key3 + i]];
        self.pos += 2;
    }
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
}

-(void)afnDRetriveCommonData4WithKey:(NSInteger)key
                            withKey2:(NSInteger)key2
                            withKey3:(NSInteger)key3{
    
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    self.pos += 1;
    [self performGenericWithKey:key
                       withKey2:key2
                     withLength:3
                  withLoopTimes:4
                      withDigit:4];
    
    for( int i = 0; i < 4; i ++){
        NSInteger time = *(unsigned short*)(self.userData + self.pos);
        [self.resultSet setValue:[NSNumber numberWithUnsignedChar:time]
                          forKey:[self getKeyString:key3 + i]];
        self.pos += 2;
    }
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
}

/*－－－－－－－－－－－－－－/
 曲线数据1
/－－－－－－－－－－－－－－*/
-(void)afnDRetriveCurveData1WithKey:(NSInteger)key
                         withLength:(NSInteger)blen
                          withDigit:(NSInteger)dlen{
    
    self.pos += 5;
    
    NSInteger dense = *(Byte*)(self.userData + self.pos);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:dense]
                      forKey:[self getKeyString:Tmn_Td_C_Dense]];
    self.pos++;
    
    NSInteger count = *(Byte*)(self.userData + self.pos);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:count]
                      forKey:[self getKeyString:Tmn_Td_C_Count]];
    self.pos++;
    
    for(int i = 0;i<count;i++){

            [self.resultSet setValue:[NSNumber numberWithDouble:[self bcdToSignedDoubleWithBytes:self.userData + self.pos
                                                                                        withblen:blen
                                                                                        withdlen:dlen
                                                                                     withSignPos:Left]]
                              forKey:[self getKeyString:0 + i]];

        self.pos+=blen;
    }
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
}


/*－－－－－－－－－－－－－－/
 曲线数据2
 /－－－－－－－－－－－－－－*/
-(void)afnDRetriveCurveData2WithKey:(NSInteger)key
                         withLength:(NSInteger)blen
                          withDigit:(NSInteger)dlen{
    
    self.pos += 5;
    
    NSInteger dense = *(Byte*)(self.userData + self.pos);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:dense]
                      forKey:[self getKeyString:Tmn_Td_C_Dense]];
    self.pos++;
    
    NSInteger count = *(Byte*)(self.userData + self.pos);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:count]
                      forKey:[self getKeyString:Tmn_Td_C_Count]];
    self.pos++;
    
    for(int i = 0;i<count;i++){
            [self.resultSet setValue:[NSNumber numberWithDouble:[self bcdToDoubleWithBytes:self.userData + self.pos
                                                                                  withblen:blen
                                                                                  withdlen:dlen]]
             
                              forKey:[self getKeyString:0 + i]];

        self.pos+=blen;
    }
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
}

@end
