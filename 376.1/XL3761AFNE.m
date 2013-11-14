//
//  XL3761AFNE.m
//  XLDistributionBoxApp
//
//  召测事件
//
//  Created by JY on 13-8-21.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761AFNE.h"


@interface XL3761AFNE()


@property(nonatomic,assign) NSInteger _index;

@end

@implementation XL3761AFNE



/*－－－－－－－－－－－－－－/
 请求重要事件
/－－－－－－－－－－－－－－*/
-(void)F1{
    NSLog(@"执行:%s",__func__);
    [self parseEvents];
}


/*－－－－－－－－－－－－－－/
 请求一般事件
/－－－－－－－－－－－－－－*/
-(void)F2{
    NSLog(@"执行:%s",__func__);
    [self parseEvents];
}


-(void)parseEvents{
    /*重要事件计数器*/
    NSInteger ec1 = *(Byte*)(self.userData + self.pos++);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:ec1]
                      forKey:[self getKeyString:Tmn_Count_Event_Importent]];
    
    /*一般事件计数器*/
    NSInteger ec2 = *(Byte*)(self.userData + self.pos++);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:ec2]
                      forKey:[self getKeyString:Tmn_Count_Event_Normal]];
    
    /*起始指针*/
    NSInteger pm = *(Byte*)(self.userData + self.pos++);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:pm]
                      forKey:[self getKeyString:-1]];
    
    /*结束指针*/
    NSInteger pn = *(Byte*)(self.userData + self.pos++);
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:pn]
                      forKey:[self getKeyString:-2]];
    
    /*事件条数*/
    NSInteger count = (pn > pm) ? (pn - pm) : (256 + pn - pm) ;
    [self.resultSet setValue:[NSNumber numberWithUnsignedChar:count]
                      forKey:[self getKeyString:-3]];
    
    for(int i = 0; i < count; i++){
        
        NSInteger ercType = *(Byte*)(self.userData + self.pos++);
        
        if (ercType == 0) {
            break;
        }
        
        NSString *fnMethod = [NSString stringWithFormat:@"retriveERC%d",ercType];
        SEL selector = NSSelectorFromString(fnMethod);
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Warc-performSelector-leaks"
        [self performSelector:selector];
#pragma clang diagnostic pop
        self._index++;
    }
    
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    
    self.keyCount += 1;
}




/*－－－－－－－－－－－－－－/
 数据初始化和版本变更记录
 
 
 
 
 
 /－－－－－－－－－－－－－－*/
-(void)retriveERC1{
    
    NSString *result = @"";
    BOOL flag = NO;
    
    
    self.pos++;

    NSString *date = [self bcdToTimeWithBytes:self.userData + self.pos
                                     withblen:5 withType:1];
    self.pos+=5;
     
    if ((*(Byte*)(self.userData + self.pos) & 0x01 ) == 1) {
        flag = YES;
        
    } else if ((*(Byte*)(self.userData + self.pos)>>1 & 0x01 ) == 1){
        flag = NO;
    }
    
    self.pos++;
    
    NSString *preVersion = [self asciiToStringWithBytes:self.userData + self.pos
                                               withblen:4];
    
    self.pos+=4;
    
    NSString *currentVersion = [self asciiToStringWithBytes:self.userData + self.pos
                                                   withblen:4];
    
    self.pos+=4;
    
    if (flag) {
        result = [NSString stringWithFormat:@"终端进行参数及数据区初始化\r初始化时间:%@\r",
                  date];
    } else {
        result = [NSString stringWithFormat:@"终端版本变更\r变更时间:%@\r变更前版本:%@\r变更后版本:%@",
                  date,
                  preVersion,
                  currentVersion];
        
    }
    [self.resultSet setValue:result forKey:[self getKeyString:self._index]];
}









/*－－－－－－－－－－－－－－/
 参数变更
 
 
 
 
 /－－－－－－－－－－－－－－*/
-(void)retriveERC3{
    
    NSString *result;
    
    /*长度*/
    NSInteger length = *(Byte*)(self.userData + self.pos++);
    
    /*参数更新时间*/
    NSString *date = [self bcdToTimeWithBytes:self.userData + self.pos
                                     withblen:5 withType:1];
    self.pos+=5;
    
    /*启动站地址*/
    NSString *address = [NSString stringWithFormat:@"%d",*(Byte*)(self.userData + self.pos++)]; 
    NSString *unitId;
    
    for(int i = 0; i < length - 6; i++){
        
        NSString *temp = [NSString stringWithFormat:@"\r数据单元%@参数已更新 ",
                  [self binToStringWithBytes:self.userData + self.pos withblen:4]];
        unitId = [unitId stringByAppendingString:temp];
        self.pos += 4;
    }
    
    result = [NSString stringWithFormat:@"终端参数变更\r更新时间:%@\r启动站地址:%@\r变更参数数据单元:%@",
              date,address,unitId];
    
    NSLog(@"%@",result);
    [self.resultSet setValue:result forKey:[self getKeyString:self._index]];
}











/*－－－－－－－－－－－－－－/
 电流回路异常
 
 
 
 
 /－－－－－－－－－－－－－－*/
-(void)retriveERC9{
    
    NSString *result;
    
    /*长度*/
//    NSInteger length = *(Byte*)(self.userData + self.pos++);
    self.pos++;
    
    /*发生时间*/
    NSString *date = [self bcdToTimeWithBytes:self.userData + self.pos
                                     withblen:5 withType:1];
    self.pos+=5;
    
    /*测量点号*/
    NSString *mPoint = [NSString stringWithFormat:@"%d",*(unsigned short*)(self.userData + self.pos) & 0x0fff];
    
    /*起止标志*/
    NSString *startendFlag = (*(unsigned short*)(self.userData + self.pos)>>15) ? @"发生" : @"恢复";
    self.pos += 2;
    
    /*异常标志*/
    NSString *flagD0 =    (*(Byte*)(self.userData + self.pos) & 0x01)     ? @"A相发生异常" : @"";
    NSString *flagD1 =   ((*(Byte*)(self.userData + self.pos)>>1) & 0x01) ? @"B相发生异常" : @"";
    NSString *flagD2 =   ((*(Byte*)(self.userData + self.pos)>>2) & 0x01) ? @"C相发生异常" : @"";
    
    NSInteger flagD6D7 = (*(Byte*)(self.userData + self.pos)>>6) & 0x03;
    
    NSString *sflagD6D7;
    
    if (flagD6D7 == 1) {
        sflagD6D7 = @"异常类型:短路";
        
    } else if (flagD6D7 == 2){
        sflagD6D7 = @"异常类型:开路";
        
    } else if (flagD6D7 == 3){
        sflagD6D7 = @"异常类型:反向";
        
    } else {
        sflagD6D7 = @"";
    }
    self.pos++;
    
    
    float vUaUab;
    float vUb;
    float vUcUcb;
    
    for(int i = 0; i < 3; i++){
        float temp = [self bcdToDoubleWithBytes:self.userData + self.pos
                                       withblen:2
                                       withdlen:1];
        self.pos += 2;
        switch (i) {
            case 0:
                vUaUab = temp;
                break;
            case 1:
                vUb = temp;
                break;
            case 2:
                vUcUcb = temp;
        }
    }
    
    float vIa;
    float vIb;
    float vIc;
    
    for(int i = 0; i < 3; i++){
        float temp = [self bcdToSignedDoubleWithBytes:self.userData + self.pos
                                             withblen:3
                                             withdlen:3
                                          withSignPos:Left];
        self.pos += 3;
        
        switch (i) {
            case 0:
                vIa = temp;
                break;
            case 1:
                vIb = temp;
                break;
            case 2:
                vIc = temp;
                break;
        }
    }
    
    /*发生时电能表正向有功总电能示值*/
    float recnetTotal = [self bcdToDoubleWithBytes:self.userData + self.pos withblen:5 withdlen:4];
    self.pos += 5;
    
    result = [NSString stringWithFormat:@"电流回路异常%@\r发生时间:%@\r测量点号:%@,%@%@%@,%@\r发生时Ua/Uab%.1f\r发生时Ub%.1f\r发生时Uc/Ucb%.1f\r发生时Ia%.3f\r发生时Ib%.3f\r发生时Ia%.3f\r发生时电能表正向有功总电能示值%.4f",startendFlag,
              date,
              mPoint,
              flagD0,flagD1,flagD2,sflagD6D7,
              vUaUab,vUb,vUcUcb,
              vIa,vIb,vIc,
              recnetTotal];
    
   [self.resultSet setValue:result forKey:[self getKeyString:self._index]];
}










/*－－－－－－－－－－－－－－/
 电压回路异常
 
 
 
 
 /－－－－－－－－－－－－－－*/
-(void)retriveERC10{
    NSString *result;
    
    /*长度*/
    //    NSInteger length = *(Byte*)(self.userData + self.pos++);
    self.pos++;
    
    /*发生时间*/
    NSString *date = [self bcdToTimeWithBytes:self.userData + self.pos
                                     withblen:5 withType:1];
    self.pos+=5;
    
    /*测量点号*/
    NSString *mPoint = [NSString stringWithFormat:@"%d",*(unsigned short*)(self.userData + self.pos) & 0x0fff];
    
    /*起止标志*/
    NSString *startendFlag = (*(unsigned short*)(self.userData + self.pos)>>15) ? @"发生" : @"恢复";
    self.pos += 2;
    
    /*异常标志*/
    NSString *flagD0 =    (*(Byte*)(self.userData + self.pos) & 0x01)     ? @"A相发生异常" : @"";
    NSString *flagD1 =   ((*(Byte*)(self.userData + self.pos)>>1) & 0x01) ? @"B相发生异常" : @"";
    NSString *flagD2 =   ((*(Byte*)(self.userData + self.pos)>>2) & 0x01) ? @"C相发生异常" : @"";
    
    NSInteger flagD6D7 = (*(Byte*)(self.userData + self.pos)>>6) & 0x03;
    
    NSString *sflagD6D7;
    
    if (flagD6D7 == 1) {
        sflagD6D7 = @"异常类型:断相";
        
    } else if (flagD6D7 == 2){
        sflagD6D7 = @"异常类型:失压";
        
    } else {
        sflagD6D7 = @"";
    }
    self.pos++;
    
    
    float vUaUab;
    float vUb;
    float vUcUcb;
    
    for(int i = 0; i < 3; i++){
        float temp = [self bcdToDoubleWithBytes:self.userData + self.pos
                                       withblen:2
                                       withdlen:1];
        self.pos += 2;
        switch (i) {
            case 0:
                vUaUab = temp;
                break;
            case 1:
                vUb = temp;
                break;
            case 2:
                vUcUcb = temp;
                break;
        }
    }
    
    float vIa;
    float vIb;
    float vIc;
    
    for(int i = 0; i < 3; i++){
        float temp = [self bcdToSignedDoubleWithBytes:self.userData + self.pos
                                             withblen:3
                                             withdlen:3
                                          withSignPos:Left];
        self.pos += 3;
        
        switch (i) {
            case 0:
                vIa = temp;
                break;
            case 1:
                vIb = temp;
                break;
            case 2:
                vIc = temp;
                break;
        }
    }
    
    /*发生时电能表正向有功总电能示值*/
    float recnetTotal = [self bcdToDoubleWithBytes:self.userData + self.pos withblen:5 withdlen:4];
    self.pos += 5;
    
    result = [NSString stringWithFormat:@"电压回路异常%@\r发生时间:%@\r测量点号:%@,%@%@%@,%@\r发生时Ua/Uab%.1f\r发生时Ub%.1f\r发生时Uc/Ucb%.1f\r发生时Ia%.3f\r发生时Ib%.3f\r发生时Ia%.3f\r发生时电能表正向有功总电能示值%.4f",startendFlag,
              date,
              mPoint,
              flagD0,flagD1,flagD2,sflagD6D7,
              vUaUab,vUb,vUcUcb,
              vIa,vIb,vIc,
              recnetTotal];
    
    [self.resultSet setValue:result forKey:[self getKeyString:self._index]];
}










/*－－－－－－－－－－－－－－/
 相序异常 
 
 
 
 
 /－－－－－－－－－－－－－－*/
-(void)retriveERC11{
    
    NSString *result;
    
    /*长度*/
    //    NSInteger length = *(Byte*)(self.userData + self.pos++);
    self.pos++;
    
    /*发生时间*/
    NSString *date = [self bcdToTimeWithBytes:self.userData + self.pos
                                     withblen:5 withType:1];
    self.pos+=5;
    
    /*测量点号*/
    NSString *mPoint = [NSString stringWithFormat:@"%d",*(unsigned short*)(self.userData + self.pos) & 0x0fff];
    
    /*起止标志*/
    NSString *startendFlag = (*(unsigned short*)(self.userData + self.pos)>>15) ? @"发生" : @"恢复";
    self.pos += 2;
    
    float dUaUab;
    float dUb;
    float dUcUcb;
    float dIa;
    float dIb;
    float dIc;
    
    for(int i = 0; i<6; i++){
        float temp = [self bcdToSignedDoubleWithBytes:self.userData + self.pos
                                             withblen:2
                                             withdlen:1
                                             withSignPos:Left];
        self.pos += 2;
        
        switch (i) {
            case 0:
                dUaUab = temp;
                break;
            case 1:
                dUb = temp;
                break;
            case 2:
                dUcUcb = temp;
                break;
            case 3:
                dIa = temp;
                break;
            case 4:
                dIb = temp;
                break;
            case 5:
                dIc = temp;
                break;
        }
    }

    /*发生时电能表正向有功总电能示值*/
    float recnetTotal = [self bcdToDoubleWithBytes:self.userData + self.pos withblen:5 withdlen:4];
    self.pos += 5;
    
    result = [NSString stringWithFormat:@"相序异常%@\r发生时间:%@\r测量点号:%@\r发生时∠Ua/Uab%.1f\r发生时∠Ub%.1f\r发生时∠Uc/Ucb%.1f\r发生时∠Ia%.1f\r发生时∠Ib%.1f\r发生时∠Ia%.1f\r发生时电能表正向有功总电能示值%.4f",startendFlag,
              date,
              mPoint,
              dUaUab,dUb,dUcUcb,
              dIa,dIb,dIc,
              recnetTotal];
    
    [self.resultSet setValue:result forKey:[self getKeyString:self._index]];
}

/*－－－－－－－－－－－－－－/
 终端停上电
 
 
 
 
 /－－－－－－－－－－－－－－*/
-(void)retriveERC14{
    
    NSString *result;
    
    /*长度*/
    //    NSInteger length = *(Byte*)(self.userData + self.pos++);
    self.pos++;
    
    /*发生时间*/
    NSString *date1 = [self bcdToTimeWithBytes:self.userData + self.pos
                                     withblen:5 withType:1];
    self.pos+=5;
    
    NSString *date2 = [self bcdToTimeWithBytes:self.userData + self.pos
                                      withblen:5 withType:1];
    
    self.pos += 5;
    
    result = [NSString stringWithFormat:@"终端停/上电事件\r停电发生时间:%@\r上电发生时间:%@",date1,
              date2];
    
    [self.resultSet setValue:result forKey:[self getKeyString:self._index]];
}


/*－－－－－－－－－－－－－－/
 电压电流不平衡越限
 
 
 
 
 /－－－－－－－－－－－－－－*/
-(void)retriveERC17{
    
    NSString *result;
    
    self.pos++;
    
    /*发生时间*/
    NSString *date = [self bcdToTimeWithBytes:self.userData + self.pos
                                     withblen:5 withType:1];
    self.pos+=5;
    
    /*测量点号*/
    NSString *mPoint = [NSString stringWithFormat:@"%d",*(unsigned short*)(self.userData + self.pos) & 0x0fff];
    
    /*起止标志*/
    NSString *startendFlag = (*(unsigned short*)(self.userData + self.pos)>>15) ? @"发生" : @"恢复";
    self.pos += 2;

    /*异常标志*/
    NSString *flagD0 =    (*(Byte*)(self.userData + self.pos) & 0x01)     ? @"电压不平衡度越限" : @"";
    NSString *flagD1 =   ((*(Byte*)(self.userData + self.pos)>>1) & 0x01) ? @"电流不平衡度越限" : @"";
    self.pos++;
    
    float vUUBR = [self bcdToSignedDoubleWithBytes:self.userData + self.pos
                                          withblen:2
                                          withdlen:1
                                       withSignPos:Left];
    self.pos += 2;
    
    float vIUBR = [self bcdToSignedDoubleWithBytes:self.userData + self.pos
                                          withblen:2
                                          withdlen:1
                                       withSignPos:Left];
    self.pos += 2;
    
    float vUaUab;
    float vUb;
    float vUcUcb;
    float vIa;
    float vIb;
    float vIc;
    
    for( int i = 0; i<3; i++){
        float temp = [self bcdToDoubleWithBytes:self.userData + self.pos
                                       withblen:2
                                       withdlen:1];
        self.pos += 2;
        
        switch (i) {
            case 0:
                vUaUab = temp;
                break;
            case 1:
                vUb = temp;
                break;
            case 2:
                vUcUcb = temp;
                break;
        }
    }
    
    for( int i = 0; i<3; i++){
        float temp = [self bcdToSignedDoubleWithBytes:self.userData + self.pos
                                       withblen:3
                                       withdlen:3
                                    withSignPos:Left];
        self.pos += 3;
        
        switch (i) {
            case 0:
                vIa = temp;
                break;
            case 1:
                vIb = temp;
                break;
            case 2:
                vIc = temp;
                break;
        }
    }
    
    
    result = [NSString stringWithFormat:@"电压/电流不平衡度越限%@\r,发生时间:%@\r测量点号%@%@%@\r发生时的电压不平衡度%.1f\r发生时的电流不平衡度%.1f\r发生时的UaUab%.1f\r发生时的Ub%.1f\r发生时的UcUcb%.1f\r发生时的Ia%.1f\r发生时的Ib%.1f\r发生时的Ic%.1f",startendFlag,
              date,
              mPoint,
              flagD0,flagD1,
              vUUBR,vIUBR,
              vUaUab,vUb,vUcUcb,
              vIa,vIb,vIc];
    
    [self.resultSet setValue:result forKey:[self getKeyString:self._index]];
}

/*－－－－－－－－－－－－－－/
 电压越限
 /－－－－－－－－－－－－－－*/
-(void)retriveERC25{
    NSString *result;
    
    self.pos++;
    
    /*发生时间*/
    NSString *date = [self bcdToTimeWithBytes:self.userData + self.pos
                                     withblen:5 withType:1];
    self.pos+=5;
    
    /*测量点号*/
    NSString *mPoint = [NSString stringWithFormat:@"%d",*(unsigned short*)(self.userData + self.pos) & 0x0fff];
    
    /*起止标志*/
    NSString *startendFlag = (*(unsigned short*)(self.userData + self.pos)>>15) ? @"发生" : @"恢复";
    self.pos += 2;
    
    /*异常标志*/
    NSString *flagD0 =    (*(Byte*)(self.userData + self.pos) & 0x01)     ? @"A相发生越限" : @"";
    NSString *flagD1 =   ((*(Byte*)(self.userData + self.pos)>>1) & 0x01) ? @"B相发生越限" : @"";
    NSString *flagD2 =   ((*(Byte*)(self.userData + self.pos)>>2) & 0x01) ? @"C相发生越限" : @"";
    
    NSInteger flagD6D7 = (*(Byte*)(self.userData + self.pos)>>6) & 0x03;
    
    NSString *sflagD6D7;
    
    if (flagD6D7 == 1) {
        sflagD6D7 = @"异常类型:越上上限";
        
    } else if (flagD6D7 == 2){
        sflagD6D7 = @"异常类型:越上限";
        
    } else {
        sflagD6D7 = @"";
    }
    self.pos++;
    
    float vIa;
    float vIb;
    float vIc;
    
    for(int i = 0; i < 3; i++){
        float temp = [self bcdToSignedDoubleWithBytes:self.userData + self.pos
                                             withblen:3
                                             withdlen:3
                                          withSignPos:Left];
        self.pos += 3;
        
        switch (i) {
            case 0:
                vIa = temp;
                break;
            case 1:
                vIb = temp;
                break;
            case 2:
                vIc = temp;
                break;
        }
    }
    
    result = [NSString stringWithFormat:@"电流越限%@\r发生时间:%@\r测量点号%@,%@%@%@%@\r发生时的Ia%.3f\r发生时的Ib%.3f\r发生时的Ic%.3f",
              startendFlag,
              date,
              mPoint,
              flagD0,flagD1,flagD2,sflagD6D7,
              vIa,vIb,vIc];
    
    [self.resultSet setValue:result forKey:[self getKeyString:self._index]];
}

/*－－－－－－－－－－－－－－/
 CT异常事件记录
 
 
 
 
 /－－－－－－－－－－－－－－*/
-(void)retriveERC34{
    
    NSString *result;
    
    self.pos++;
    
    /*发生时间*/
    NSString *date = [self bcdToTimeWithBytes:self.userData + self.pos
                                     withblen:5 withType:1];
    self.pos+=5;
    
    /*测量点号*/
    NSString *mPoint = [NSString stringWithFormat:@"%d",*(unsigned short*)(self.userData + self.pos) & 0x0fff];
    
    /*起止标志*/
    NSString *startendFlag = (*(unsigned short*)(self.userData + self.pos)>>15) ? @"发生" : @"恢复";
    self.pos += 2;
    
    /*异常标志*/
    NSString *flagD0 =    (*(Byte*)(self.userData + self.pos) & 0x01)     ? @"A相发生事件" : @"";
    NSString *flagD1 =   ((*(Byte*)(self.userData + self.pos)>>1) & 0x01) ? @"B相发生事件" : @"";
    NSString *flagD2 =   ((*(Byte*)(self.userData + self.pos)>>2) & 0x01) ? @"C相发生事件" : @"";
    
    NSInteger flagD6D7 = (*(Byte*)(self.userData + self.pos)>>6) & 0x03;
    
    NSString *sflagD6D7;
    
    if (flagD6D7 == 1) {
        sflagD6D7 = @"异常类型:一次侧短路";
        
    } else if (flagD6D7 == 2){
        sflagD6D7 = @"异常类型:二次侧短路";
        
    } else if (flagD6D7 == 3) {
        sflagD6D7 = @"异常类型:二次侧开路";
    }
    self.pos++;
    
    result = [NSString stringWithFormat:@"CT异常事件%@\r发生时间:%@\r测量点号%@,%@%@%@%@",
              startendFlag,
              date,
              mPoint,
              flagD0,flagD1,flagD2,sflagD6D7];
    
    [self.resultSet setValue:result forKey:[self getKeyString:self._index]];
}
@end
