//
//  XL3761AFNC.m
//  XLDistributionBoxApp
//
//  请求1类数据
//
//  Created by JY on 13-5-21.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761AFNC.h"

@implementation XL3761AFNC

-(id)init
{
    if (self = [super init]) {
        //...............
    }
    return self;
}

/*－－－－－－－－－－－－－－－－－
 召测终端日历时钟
 F2
 －－－－－－－－－－－－－－－－－*/
-(void)F2{
    
    NSLog(@"执行:%s",__func__);
 
    [self afnRetriveF2];
}


/*－－－－－－－－－－－－－－－－－
 当前三相及总有/无功功率，
 功率因数，
 三相电压，
 电流，
 零序电流，
 视在功率
 F25
 －－－－－－－－－－－－－－－－－*/
-(void)F25
{
    NSLog(@"执行:%s",__func__);
    
    [self afnCRetriveData4F25];
}


/*－－－－－－－－－－－－－－－－－
 A、B、C三相断相统计数据
 及最近一次断相记录
 F26
 －－－－－－－－－－－－－－－－－*/
-(void)F26
{
    
}

/*－－－－－－－－－－－－－－－－－
 当前正向有功电能示值
 F129
 －－－－－－－－－－－－－－－－－*/
-(void)F129
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_AE_Z_Pos_Current
                           withBytelen:5
                             withDigit:4];
}


/*－－－－－－－－－－－－－－－－－
 当前正向无功（组合无功1）电能示值
 F130
 －－－－－－－－－－－－－－－－－*/
-(void)F130
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_RE_Z_Pos_Current
                           withBytelen:4
                             withDigit:2];
}

/*－－－－－－－－－－－－－－－－－
 当前反向有功电能示值
 F131
 －－－－－－－－－－－－－－－－－*/
-(void)F131
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_AE_Z_Neg_Current
                           withBytelen:5
                             withDigit:4];
}


/*－－－－－－－－－－－－－－－－－
 当前反向无功（组合无功1）电能示值
 F132
 －－－－－－－－－－－－－－－－－*/
-(void)F132
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_RE_Z_Neg_Current
                           withBytelen:4
                             withDigit:2];
}


/*－－－－－－－－－－－－－－－－－
 当前一象限无功电能示值
 F133
 －－－－－－－－－－－－－－－－－*/
-(void)F133
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_Indication_RE_Z_Quad_1_Cur
                           withBytelen:4
                             withDigit:2];
}

/*－－－－－－－－－－－－－－－－－
 当前二象限无功电能示值
 F134
 －－－－－－－－－－－－－－－－－*/
-(void)F134
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_Indication_RE_Z_Quad_2_Cur
                           withBytelen:4
                             withDigit:2];
}

/*－－－－－－－－－－－－－－－－－
 当前三象限无功电能示值
 F135
 －－－－－－－－－－－－－－－－－*/
-(void)F135
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_Indication_RE_Z_Quad_3_Cur
                           withBytelen:4
                             withDigit:2];
}

/*－－－－－－－－－－－－－－－－－
 当前四象限无功电能示值
 F136
 －－－－－－－－－－－－－－－－－*/
-(void)F136
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_Indication_RE_Z_Quad_4_Cur
                           withBytelen:4
                             withDigit:2];
}


/*－－－－－－－－－－－－－－－－－
 上月（上一结算日）正向有功电能示值
 F137
 －－－－－－－－－－－－－－－－－*/
-(void)F137
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_Indication_AE_Pos_Z_JS_Mon
                           withBytelen:5
                             withDigit:4];
}

/*－－－－－－－－－－－－－－－－－
 上月（上一结算日）正向无功电能示值
 F138
 －－－－－－－－－－－－－－－－－*/
-(void)F138
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_Indication_RE_Pos_Z_JS_Mon
                           withBytelen:5
                             withDigit:4];
}


/*－－－－－－－－－－－－－－－－－
 上月（上一结算日）
 反向有功（组合无功1）电能示值
 F139
 －－－－－－－－－－－－－－－－－*/
-(void)F139
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_Indication_AE_Z_Neg_JS_Mon
                           withBytelen:5
                             withDigit:4];
}

/*－－－－－－－－－－－－－－－－－
 上月（上一结算日）
 反向无功（组合无功1）电能示值
 F140
 －－－－－－－－－－－－－－－－－*/
-(void)F140
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_Indication_RE_Neg_Z_JS_Mon
                           withBytelen:5
                             withDigit:4];
}


/*－－－－－－－－－－－－－－－－－
 上月（上一结算日）一象限无功电能示值
 F141
 －－－－－－－－－－－－－－－－－*/
-(void)F141
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_Indication_RE_Z_Quad_1_JS_Mon
                           withBytelen:4
                             withDigit:2];
}


/*－－－－－－－－－－－－－－－－－
 上月（上一结算日）二象限无功电能示值
 F142
 －－－－－－－－－－－－－－－－－*/
-(void)F142
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_Indication_RE_Z_Quad_2_JS_Mon
                           withBytelen:4
                             withDigit:2];
}

/*－－－－－－－－－－－－－－－－－
 上月（上一结算日）三象限无功电能示值
 F143
 －－－－－－－－－－－－－－－－－*/
-(void)F143
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_Indication_RE_Z_Quad_3_JS_Mon
                           withBytelen:4
                             withDigit:2];
}


/*－－－－－－－－－－－－－－－－－
 上月（上一结算日）四象限无功电能示值
 F144
 －－－－－－－－－－－－－－－－－*/
-(void)F144
{
    NSLog(@"执行:%s",__func__);
    
    
    [self afnCRetriveCommonDataWithKey:Msn_Indication_RE_Z_Quad_4_JS_Mon
                           withBytelen:4
                             withDigit:2];
}

/*－－－－－－－－－－－－－－－－－
 当月正向有功最大需量及发生时间
（总，费率1～M）
 F145
 －－－－－－－－－－－－－－－－－*/
-(void)F145
{
    NSLog(@"执行:%s",__func__);
    [self afnCRetriveCommonDataWithKey:Msn_EV_Max_Z_AE_Pos
                               withKey:Msn_Time_Max_EV_Z_AE_Pos
                           withBytelen:3
                          withBytelen2:4
                             withDigit:4];
}

/*－－－－－－－－－－－－－－－－－
 当月正向无功最大需量及发生时间
（总，费率1～M）
 F146
 －－－－－－－－－－－－－－－－－*/
-(void)F146
{
    NSLog(@"执行:%s",__func__);
    [self afnCRetriveCommonDataWithKey:Msn_EV_Max_Z_RE_Pos
                               withKey:Msn_Time_Max_EV_Z_RE_Pos
                           withBytelen:3
                          withBytelen2:4
                             withDigit:4];
}


/*－－－－－－－－－－－－－－－－－
 当月反向有功最大需量及发生时间
（总，费率1～M）
 F147
 －－－－－－－－－－－－－－－－－*/
-(void)F147
{
    NSLog(@"执行:%s",__func__);
    [self afnCRetriveCommonDataWithKey:Msn_EV_Max_Z_AE_Neg
                               withKey:Msn_Time_Max_EV_Z_AE_Neg
                           withBytelen:3
                          withBytelen2:4
                             withDigit:4];
}

/*－－－－－－－－－－－－－－－－－
 当月反向无功最大需量及发生时间
（总，费率1～M）
 F148
 －－－－－－－－－－－－－－－－－*/
-(void)F148
{
    NSLog(@"执行:%s",__func__);
    [self afnCRetriveCommonDataWithKey:Msn_EV_Max_Z_RE_Neg
                               withKey:Msn_Time_Max_EV_Z_RE_Neg
                           withBytelen:3
                          withBytelen2:4
                             withDigit:4];
}


/*－－－－－－－－－－－－－－－－－
 上月（上一结算日）正向有功最大需量
 及发生时间（总，费率1～M）
 F149
 －－－－－－－－－－－－－－－－－*/
-(void)F149
{
    NSLog(@"执行:%s",__func__);
    [self afnCRetriveCommonDataWithKey:Msn_EV_Max_Z_AE_Pos_JS_Mon
                               withKey:Msn_Time_Max_EV_Z_AE_Pos_JS_Mon
                           withBytelen:3
                          withBytelen2:4
                             withDigit:4];
}


/*－－－－－－－－－－－－－－－－－
 上月（上一结算日）正向无功最大需量
 及发生时间（总，费率1～M）
 F150
 －－－－－－－－－－－－－－－－－*/
-(void)F150
{
    NSLog(@"执行:%s",__func__);
    [self afnCRetriveCommonDataWithKey:Msn_EV_Max_Z_RE_Pos_JS_Mon
                               withKey:Msn_Time_Max_EV_Z_RE_Pos_JS_Mon
                           withBytelen:3
                          withBytelen2:4
                             withDigit:4];
}


/*－－－－－－－－－－－－－－－－－
 上月（上一结算日）反向有功最大需量
 及发生时间（总，费率1～M）
 F151
 －－－－－－－－－－－－－－－－－*/
-(void)F151
{
    NSLog(@"执行:%s",__func__);
    [self afnCRetriveCommonDataWithKey:Msn_EV_Max_Z_AE_Neg_JS_Mon
                               withKey:Msn_Time_Max_EV_Z_AE_Neg_JS_Mon
                           withBytelen:3
                          withBytelen2:4
                             withDigit:4];
}


/*－－－－－－－－－－－－－－－－－
 上月（上一结算日）反向无功最大需量
 及发生时间（总，费率1～M）
 F152
 －－－－－－－－－－－－－－－－－*/
-(void)F152
{
    NSLog(@"执行:%s",__func__);
    [self afnCRetriveCommonDataWithKey:Msn_EV_Max_Z_RE_Neg_JS_Mon
                               withKey:Msn_Time_Max_EV_Z_RE_Neg_JS_Mon
                           withBytelen:3
                          withBytelen2:4
                             withDigit:4];
}


//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－


/*－－－－－－－－－－－－－－－－－
 总电能示值
 费率1电能示值
 .....
 费率M电能示值
 －－－－－－－－－－－－－－－－－*/
-(void)afnCRetriveCommonDataWithKey:(NSInteger)key
                        withBytelen:(NSInteger)len
                          withDigit:(NSInteger)digit
{
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    self.pos += 5;
    
    NSInteger rate = *(Byte*)(self.userData + self.pos);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:rate]
                      forKey:[self getKeyString:Tmn_Para_Tariff_Num]];
    self.pos += 1;
    
    [self performGenericWithKey:key
                     withLength:len
                       withRate:rate
                      withDigit:digit];

    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    self.keyCount += 1;
}



/*－－－－－－－－－－－－－－－－－
 最大需量
 最大需量发生时间
 费率1最大需量
 费率1最大需量发生时间
 .....
 费率M最大需量
 费率M最大需量发生时间
 －－－－－－－－－－－－－－－－－*/
-(void)afnCRetriveCommonDataWithKey:(NSInteger)key
                            withKey:(NSInteger)key2
                        withBytelen:(NSInteger)len
                       withBytelen2:(NSInteger)len2
                          withDigit:(NSInteger)digit
{
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    self.pos += 5;
    
    NSInteger rate = *(Byte*)(self.userData + self.pos);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:rate]
                      forKey:[self getKeyString:Tmn_Para_Tariff_Num]];
    self.pos += 1;
    
    [self performGenericWithKey:key
                       withKey2:key2
                    withLength1:len
                    withLength2:len2
                       withRate:rate
                      withDigit:digit];
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    self.keyCount += 1;
}

-(void)afnCRetriveData4F25
{
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    self.pos += 5;
    
    //当前总有功功率 A B C相
    //当前总无功功率 A B C相
    [self performGenericWithKey:Msn_AP_Z
                     withLength:3
                       withRate:8
                      withDigit:4
                       isSigned:YES
                        signPos:Left];
    
    //当前总功率因数 A B C相
    [self performGenericWithKey:Msn_PF_Z
                     withLength:2
                       withRate:4
                      withDigit:1
                       isSigned:YES
                        signPos:Left];
    
    
    //当前 A B C相 电压
    [self performGenericWithKey:Msn_Vol_A
                     withLength:2
                       withRate:3
                      withDigit:1
                       isSigned:NO
                        signPos:-1];

    
    //当前 A B C相 电流 当前零序电流
    [self performGenericWithKey:Msn_Cur_A
                     withLength:3
                       withRate:4
                      withDigit:3
                       isSigned:YES
                        signPos:Left];

    
    //当前 视在功率 总 A B C
    [self performGenericWithKey:Msn_SP_A
                     withLength:3
                       withRate:4
                      withDigit:4
                       isSigned:YES
                        signPos:Left];
    
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    self.keyCount += 1;
}


/*－－－－－－－－－－－－－－－－－
 召测时钟
 时钟示例：--> 2013年10月5日12:10:30 星期3
 －－－－－－－－－－－－－－－－－*/
-(void)afnRetriveF2{
    
    //时 分 秒
    NSString *time = [self bcdToTimeWithBytes:(self.userData + self.pos) withblen:3 withType:0];
    self.pos += 3;
    
    //日
    NSString *day = [NSString stringWithFormat:@"%d%d",(*(self.userData + self.pos))>>4 & 0x0f,
                     *(self.userData + self.pos) & 0x0f];
    self.pos += 1;
    
    //星期
    NSInteger week = (*(self.userData + self.pos)>>5) & 0x07;
    
    //月
    NSInteger month = ((*(self.userData + self.pos)>>4) & 0x01)*10 +
                        *(self.userData + self.pos) & 0x0f;
    self.pos += 1;
    
    //年
    NSString *year = [NSString stringWithFormat:@"20%d%d",(*(self.userData + self.pos))>>4 & 0x0f,
                                                           *(self.userData + self.pos) & 0x0f];
    self.pos += 1;
    
    NSString *date = [NSString stringWithFormat:@"%@年%d月%@日%@ 星期%d",
                      year,
                      month,
                      day,
                      time,
                      week];
    
    [self.resultSet setValue:date forKey:@"clock"];
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    self.keyCount += 1;
}
@end
