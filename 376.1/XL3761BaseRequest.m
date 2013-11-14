//
//  XL3761BaseRequest.m
//  XLDistributionBoxApp
//
//  376.1 Frame base Class
//
//  Created by JY on 13-5-21.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761BaseRequest.h"
#import "XLSettingsManager.h"

@interface XL3761BaseRequest()

@property(nonatomic,retain) NSString *notifyName;
@property(nonatomic,retain) XLSettingsManager *setting;
@end

@implementation XL3761BaseRequest

@synthesize header,controlField,addressField;
@synthesize AFN,SEQ,dadt,userData,userDataLength,auxFieldLength;
@synthesize pos,resultSet,finalSet;
@synthesize notifyName;
@synthesize keyCount;
//@synthesize sem;

#pragma mark -init

/*－－－－－－－－－－－－－－－－－
 初始化数据集
－－－－－－－－－－－－－－－－－*/
-(id)init
{
    if (self = [super init]) {
        
        NSLog(@"解析类: %@",[self class]);
        
        self.pos = 0;
        
        self.resultSet = [[NSMutableDictionary alloc] init];
        self.finalSet  = [[NSMutableDictionary alloc] init];
        
        self.setting = [XLSettingsManager sharedXLSettingsManager];
        
        self.notifyName  = [NSString stringWithFormat:@"%@NotificationFor%@",
                            [self class],
                            self.setting.notifyPrefix];

    }
    return self;
}

#pragma mark -parse

dispatch_queue_t   queue;
dispatch_group_t   group;


/*－－－－－－－－－－－－－－－－－
 解析用户数据区
－－－－－－－－－－－－－－－－－*/
-(void)parseUserData{
    
//    group = dispatch_group_create();
//    queue = dispatch_queue_create("com.x.x", NULL);
//    
//    int i =0;
//    while (i<10000) {
//        dispatch_group_async(group,queue, ^{
//            NSLog(@"Alive.......%d",i);
//        });
//        i++;
//    }
//    
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    [self sendResult];
 
 

    if (self.controlField.FCBOrACD) {
        self.auxFieldLength += 2;
    }
    
    if (self.SEQ.TpV) {
        self.auxFieldLength += 6;
    }
    
    if ([self.dadt count] > 1) {
        
        [self parseCombineDADT];
    } else {
        [self parseNonCombineDADT];
    }
}


/*－－－－－－－－－－－－－－－－－
 解析组合DADT
 串行队列顺序执行解析
－－－－－－－－－－－－－－－－－*/
-(void)parseCombineDADT{

    NSString *fnNumber;
    SEL       fnMethod;
    group = dispatch_group_create();
    queue = dispatch_queue_create("COM.XLCOMBINE.QUEUE", DISPATCH_QUEUE_SERIAL);
    
    //循环执行分解得到的DADT 得到总的数据集
    for (XL3761DADTRecord *record in self.dadt)
    {
        fnNumber = [NSString stringWithFormat:@"F%d",record.fId];
        fnMethod =  NSSelectorFromString(fnNumber);
        
        //方法block
        dispatch_block_t _block = ^(void){
            
            if(!self.setting.cancelSend){
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Warc-performSelector-leaks"
                [self performSelector:fnMethod];
#pragma clang diagnostic pop
            }
            
        };
        dispatch_group_async(group, queue, _block);
    }
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
//    self.notifyName = [NSString stringWithFormat:@"%@Notification",
//                       self.notifyName];
    
    [self sendResult];
}


/*－－－－－－－－－－－－－－－－－
 适用于多个DADT散布于用户数据区
 串行队列顺序执行解析
－－－－－－－－－－－－－－－－－*/
-(void)parseNonCombineDADT{
 
    queue = dispatch_queue_create("COM.XLNONCOMBINE.QUEUE", DISPATCH_QUEUE_SERIAL);
    group = dispatch_group_create();
    
    NSString *fnNumber;
    SEL       fnMethod;
    
    XL3761DADTRecord *record = (XL3761DADTRecord*)[self.dadt objectAtIndex:0];
    
    fnNumber = [NSString stringWithFormat:@"F%d",record.fId];
    fnMethod = NSSelectorFromString(fnNumber);
    
    dispatch_block_t _block = ^(void){
        if(!self.setting.cancelSend){
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Warc-performSelector-leaks"
            [self performSelector:fnMethod];
#pragma clang diagnostic pop
        }
    };
    
    dispatch_group_async(group, queue, _block);
    dispatch_group_wait( group, DISPATCH_TIME_FOREVER);
    
    [self shouldContinue];
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    self.notifyName = [NSString stringWithFormat:@"%@Notification",
//                       self.notifyName];

    [self sendResult];
}

/*－－－－－－－－－－－－－－－－－
 递归解析
－－－－－－－－－－－－－－－－－*/
-(void)shouldContinue{
    //检查用户数据是否解析完毕
    if ((self.pos + self.auxFieldLength + 12) < self.userDataLength) {
        
        NSInteger fN           = *(Byte*)(self.userData + self.pos + 2);
        NSInteger fNGroup = *(Byte*)(self.userData + self.pos + 3);
        NSInteger fNumber = [self parseFnwithGroup:fNGroup withNumber:fN];
        
        NSString *fnNumber = [NSString stringWithFormat:@"F%d",fNumber];
        SEL fnMethod = NSSelectorFromString(fnNumber);
        
        self.pos +=4;
        
        dispatch_block_t _block = ^(void){
            
            if(!self.setting.cancelSend){
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Warc-performSelector-leaks"
                [self performSelector:fnMethod];
#pragma clang diagnostic pop
            }
            
        };
        dispatch_group_async(group, queue, _block);
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
    } else {
        return;
    }
    
    [self shouldContinue];
}

-(NSInteger)parseFnwithGroup:(NSInteger)group withNumber:(NSInteger)number{
    NSInteger tNumber = 0;
    
    for (int i = 7; i>=0;i--)
    {
        Byte mask;
        
        if (i>=4) {
            mask = ((Byte)pow(2, i-4))<<4 & 0xf0;
        } else {
            mask = (Byte)pow(2, i) & 0x0f;
        }

        if((number & mask) >> i)
        {
            tNumber = group * 8 + 1 + i;
        }
    }
    return tNumber;
}

#pragma mark -send
/*－－－－－－－－－－－－－－－－－
 POST DATA
－－－－－－－－－－－－－－－－－*/
-(void)performNotificationWith:(NSString*)notifyNames
                    withObject:(NSObject*)objc
                    withResult:(NSDictionary*)resultDic{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:notifyNames
                                                        object:objc
                                                      userInfo:resultDic];
    NSLog(@"发出通知:%@",notifyNames);
}

/*－－－－－－－－－－－－－－－－－
 Send
－－－－－－－－－－－－－－－－－*/
-(void)sendResult{
    if (!self.setting.cancelSend) {
        [self performNotificationWith:self.notifyName
                           withObject:nil
                           withResult:self.finalSet];
    }
}


/*－－－－－－－－－－－－－－－－－
 BCD转为DOUBLE
－－－－－－－－－－－－－－－－－*/
-(double)bcdToDoubleWithBytes:(Byte*)bcdCode
                     withblen:(NSInteger)bytesLength
                     withdlen:(NSInteger)digitLength{

    if (![self checkNullValue:bcdCode withblen:bytesLength]) {
        return 999999;
    }
    
    double result = 0;
    double temp;
    
    for ( int i =bytesLength-1; i>=0; i--)
    {
        temp   = (*(bcdCode + i)>>4 & 0x0f)*10 + (*(bcdCode + i) & 0x0f);
        
        result += temp * pow(10,2*i);
    }
    result = result/pow(10,digitLength);
    return result;
}


/*－－－－－－－－－－－－－－－－－
 BCD转为DOUBLE
 
 带符号
－－－－－－－－－－－－－－－－－*/
-(double)bcdToSignedDoubleWithBytes:(Byte*)bcdCode
                           withblen:(NSInteger)bytesLength
                           withdlen:(NSInteger)digitLength
                        withSignPos:(NSInteger)_pos{
    
    if (![self checkNullValue:bcdCode withblen:bytesLength]) {
        return 999999;
    }
    
    double result = 0;
    double temp;
    NSInteger sign;
    
    for ( int i =bytesLength-1; i>=0; i--){
        if (i == bytesLength -1) {
            if (_pos == Left) {
                sign   = *(bcdCode + i)>>7 & 0x01;
                temp  = (*(bcdCode + i)>>4 & 0x07)*10
                      + (*(bcdCode + i) & 0x0f);
                
            } else if (_pos == right){
                sign   = *(bcdCode + i)>>4 & 0x01;
                temp  = (*(bcdCode + i)>>5 & 0x07)*10
                      + (*(bcdCode + i) & 0x0f);
            }
            result += temp * pow(10,2*i);
        } else {
            
            temp   = (*(bcdCode + i)>>4 & 0x0f)*10
                   + (*(bcdCode + i) & 0x0f);
            result += temp * pow(10,2*i);
        }
    }
    
    result = result/pow(10,digitLength);
    if (sign) { return -result;}
    return result;
}


/*－－－－－－－－－－－－－－－－－
 BCD转为时间 A.17 etc.
－－－－－－－－－－－－－－－－－*/
-(NSString*)bcdToTimeWithBytes:(Byte*)bcdCode
                      withblen:(NSInteger)bytesLength
                      withType:(NSInteger)type{

    if (![self checkNullValue:bcdCode withblen:bytesLength]) {
        return @"N/A";
    }
    
    NSString *result = [[NSString alloc] init];
    NSString *temp;
    
    for ( int i = bytesLength - 1; i>=0; i--)
    {
        temp =[NSString stringWithFormat:@"%d", *(bcdCode + i)>>4 & 0x0f];
        result = [result stringByAppendingString:temp];
        
        temp =[NSString stringWithFormat:@"%d", *(bcdCode + i) & 0x0f];
        result = [result stringByAppendingString:temp];
        
        if (type == 1) {
            if (i == 4) {
                result = [result stringByAppendingString:@"年"];
            } else if(i == 3){
                result = [result stringByAppendingString:@"月"];
                
            } else if(i == 2){
                result = [result stringByAppendingString:@"日"];
                
            }else {
                if (i) result = [result stringByAppendingString:@":"];
            }
        } else if (type == 2){
            if (i == 2) {
                result = [result stringByAppendingString:@"日"];
            }else {
                if (i) result = [result stringByAppendingString:@":"];
            }
        } else {
            if (i) result = [result stringByAppendingString:@":"];
        }
 
    }
    return result;
}
/*－－－－－－－－－－－－－－－－－
 ASCII to NSString
 －－－－－－－－－－－－－－－－－*/
-(NSString*)asciiToStringWithBytes:(Byte*)asciiCode
                          withblen:(NSInteger)bytesLength{
    
    
    if (![self checkNullValue:asciiCode withblen:bytesLength]) {
        return @"N/A";
    }
    
    
    NSString *result = @"";
    NSString *temp;
    for(int i = 0; i < bytesLength; i++){
        
        temp = [NSString stringWithFormat:@"%c", *(Byte*)(asciiCode + i)];
        
        result = [result stringByAppendingString:temp];
    }
    return result;
}
/*－－－－－－－－－－－－－－－－－
 BIN to NSString
 －－－－－－－－－－－－－－－－－*/
-(NSString*)binToStringWithBytes:(Byte*)bin
                        withblen:(NSInteger)bytesLength{
    
    if (![self checkNullValue:bin withblen:bytesLength]) {
        return @"N/A";
    }
    
    NSString *result = @"";
    NSString *temp;
    for(int i = 0; i < bytesLength; i++){
        
        temp = [NSString stringWithFormat:@"%d", *(Byte*)(bin + i)];
        
        result = [result stringByAppendingString:temp];
    }
    return result;
}
 
-(BOOL)checkNullValue:(Byte*)_userData withblen:(NSInteger)blen{
    
    BOOL flag = NO;
    
    for(int i = 0;i<blen;i++){
        if (_userData[i] != 0xee && _userData[i]!=0xff) {
            flag = YES;
        }
    }
    return flag;
}

/*－－－－－－－－－－－－－－－－－
 总,费率1 ~ M; decimal
－－－－－－－－－－－－－－－－－*/
-(void)performGenericWithKey:(int)key
                  withLength:(int)byteLength
                    withRate:(int)rate
                   withDigit:(int)digit{

    [self.resultSet setValue:[NSNumber numberWithDouble:[self bcdToDoubleWithBytes:self.userData + self.pos
                                                                          withblen:byteLength
                                                                          withdlen:digit]]
                      forKey:[self getKeyString:key]];
    self.pos += byteLength;
    
    for ( int i = 1; i<= rate; i++)
    {
        [self.resultSet setValue:[NSNumber numberWithDouble:[self bcdToDoubleWithBytes:self.userData + self.pos
                                                                              withblen:byteLength
                                                                              withdlen:digit]]
                          forKey:[self getKeyString:key + i]];
        self.pos += byteLength;
    }
}


/*－－－－－－－－－－－－－－－－－
 总,费率1 ~ M; decimal time
－－－－－－－－－－－－－－－－－*/
-(void)performGenericWithKey:(int)key
                    withKey2:(int)key2
                 withLength1:(int)byteLength1
                 withLength2:(int)byteLength2
                    withRate:(int)rate
                   withDigit:(int)digit{
    
    [self.resultSet setValue:[NSNumber numberWithDouble:[self bcdToDoubleWithBytes:self.userData + self.pos
                                                                          withblen:byteLength1
                                                                          withdlen:digit]]
                              forKey:[self getKeyString:key]];
    self.pos += byteLength1;
    
    [self.resultSet setValue:[self bcdToTimeWithBytes:self.userData+self.pos
                                             withblen:byteLength2 withType:2]
                              forKey:[self getKeyString:key2]];
    
    self.pos += byteLength2;
    
    for ( int i = 1; i<= rate; i++)
    {
        [self.resultSet setValue:[NSNumber numberWithDouble:[self bcdToDoubleWithBytes:self.userData + self.pos
                                                                              withblen:byteLength1
                                                                              withdlen:digit]]
                          forKey:[self getKeyString:key+i]];
        self.pos += byteLength1;
        
        [self.resultSet setValue:[self bcdToTimeWithBytes:self.userData+self.pos
                                                 withblen:byteLength2 withType:2]
                          forKey:[self getKeyString:key2+i]];
        
        self.pos += byteLength2;
    }
}


/*－－－－－－－－－－－－－－－－－
 总,费率1 ~ M; time
－－－－－－－－－－－－－－－－－*/
-(void)performGenericWithKey:(int)key
                  withLength:(int)byteLength
                    withRate:(int)rate{
    
    [self.resultSet setValue:[self bcdToTimeWithBytes:self.userData+self.pos
                                             withblen:byteLength withType:2]
                      forKey:[self getKeyString:key]];
    
    self.pos += byteLength;
    
    for ( int i = 1; i<= rate; i++)
    {
        [self.resultSet setValue:[self bcdToTimeWithBytes:self.userData+self.pos
                                                 withblen:byteLength withType:2]
                          forKey:[self getKeyString:key + i]];
        self.pos += byteLength;
    }
}

-(void)performGenericWithKey:(int)key
                  withLength:(int)byteLength
                    withRate:(int)rate
                   withDigit:(int)digit
                    isSigned:(BOOL)sign
                     signPos:(int)_pos{

    for ( int i =0; i<rate; i++)
    {
        if (sign) {
            [self.resultSet setValue:[NSNumber numberWithDouble:
                                      [self bcdToSignedDoubleWithBytes:self.userData + self.pos
                                                              withblen:byteLength
                                                              withdlen:digit
                                                           withSignPos:_pos]]
                              forKey:[self getKeyString:key + i]];
            
        } else {
            
            [self.resultSet setValue:[NSNumber numberWithDouble:
                                      [self bcdToDoubleWithBytes:self.userData + self.pos
                                                        withblen:byteLength
                                                        withdlen:digit]]
                              forKey:[self getKeyString:key + i]]; 
        }
        self.pos += byteLength;
    }
}


-(void)performGenericWithKey:(int)key
                    withKey2:(int)key2
                  withLength:(int)byteLength
               withLoopTimes:(int)rate
                   withDigit:(int)digit{
    
    self.pos += 2;
    
    for(int i = 0 ; i < rate; i++ ){
        [self.resultSet setValue:[NSNumber numberWithDouble:[self bcdToDoubleWithBytes:self.userData + self.pos
                                                                              withblen:byteLength
                                                                              withdlen:digit]]
                          forKey:[self getKeyString:key + i]];
        self.pos += byteLength;
        
        [self.resultSet setValue:[self bcdToTimeWithBytes:self.userData+self.pos
                                                 withblen:byteLength withType:2]
                          forKey:[self getKeyString:key2 + i ]];
        
        self.pos += byteLength;
    }
}


-(NSString*)getKeyString:(int)key
{
    return [NSString stringWithFormat:@"%d",key];
}

-(void)dealloc
{
//    [super dealloc];
//    [addressField release];
//    [controlField release];
//    [SEQ release];
//    [dadt release];
//    [resultSet release];
//    [finalSet release];
    free(userData);
}

@end
