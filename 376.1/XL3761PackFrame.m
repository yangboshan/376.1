//
//  XL3761PackFrame.m
//  XLDistributionBoxApp
//
//  Created by JY on 13-8-29.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761PackFrame.h"
#import "XL3761PackEntity.h"
#import "XL3761PackItem.h"
#import "XLSocketManager.h"

#import "XL3761PackUserData.h"

@interface XL3761PackFrame()

@property (nonatomic,strong) XLSocketManager *socketManager;

@end

@implementation XL3761PackFrame

SYNTHESIZE_SINGLETON_FOR_CLASS(XL3761PackFrame)


-(id)init{
    if (self = [super init]) {
        self.socketManager = [XLSocketManager sharedXLSocketManager];
    }
    return self;
}

/*－－－－－－－－－－－－－－
 通用召测 
 
 不带用户数据
 －－－－－－－－－－－－－－*/
-(void)commonRequestWithAfn:(Byte)afn
                     withFn:(NSString*)fn{
    
    NSMutableArray *array = [NSMutableArray array];
    
    XL3761PackEntity *entity = [[XL3761PackEntity alloc] init];
    [entity setFn:fn];
    [array addObject:entity];
    
    XL3761PackUserData *userData = [[XL3761PackUserData alloc] init];
    [userData setAfn:afn];
    [userData setUserData:array];
    
    [self.socketManager packRequestFrame:userData];
}


/*－－－－－－－－－－－－－－
 测量点限值参数
 
 AFN04 F26
 －－－－－－－－－－－－－－*/
-(void)setDevicePara{
 
 
}


/*－－－－－－－－－－－－－－
 通用召测
 
 数据时标 Tdm  日月年
 －－－－－－－－－－－－－－*/
-(void)commonRequestWithAfn:(Byte)afn
                     withFn:(NSArray*)fn
                    withTdd:(NSString*)tdd{
    NSRange range= NSMakeRange(2, 2);
    NSInteger year = [[tdd substringWithRange:range] integerValue];
    
    range = NSMakeRange(5, 2);
    NSInteger month = [[tdd substringWithRange:range] integerValue];
    
    range = NSMakeRange(8, 2);
    NSInteger day = [[tdd substringWithRange:range] integerValue];
    
    
    NSMutableArray *finalArray = [NSMutableArray array];
    
    for(NSString *_fn in fn){
        
        XL3761PackEntity *entity = [[XL3761PackEntity alloc] init];
        [entity setFn:_fn];
        
        NSMutableArray *array = [NSMutableArray array];
        
        for(int i = 0; i < 3; i++){
            
            XL3761PackItem *dataItem = [[XL3761PackItem alloc] init];
            
            if (i == 0) {
                dataItem.value = day;
            } else if(i == 1){
                dataItem.value = month;
            } else if (i == 2){
                dataItem.value = year;
            }
            [dataItem setDigitlen:0];
            [dataItem setByteslen:1];
            [array addObject:dataItem];
        }
        
        [entity setUserData:array];
        
        if ([_fn isEqualToString:@"F49"]) {
            [entity setUseP0:YES];
        }
        
        [finalArray addObject:entity];
    }
    
    XL3761PackUserData *userData = [[XL3761PackUserData alloc] init];
    [userData setAfn:afn];
    [userData setUserData:finalArray];
    
    [self.socketManager packRequestFrame:userData];
    
}


/*－－－－－－－－－－－－－－
 通用召测 
 
 数据时标 月年
 －－－－－－－－－－－－－－*/
-(void)commonRequestWithAfn:(Byte)afn
                     withFn:(NSArray*)fn
              withTdm:(NSString*)tdm{
    
    NSRange range= NSMakeRange(2, 2);
    NSInteger year = [[tdm substringWithRange:range] integerValue];
    NSInteger month = [[tdm substringFromIndex:5] integerValue];
    
    NSMutableArray *finalArray = [NSMutableArray array];
    
    for(NSString *_fn in fn){
        
        XL3761PackEntity *entity = [[XL3761PackEntity alloc] init];
        [entity setFn:_fn];
        
        NSMutableArray *array = [NSMutableArray array];
        
        for(int i = 0; i < 2; i++){
            
            XL3761PackItem *dataItem = [[XL3761PackItem alloc] init];
            
            dataItem.value = (i == 0) ? month : year;
            [dataItem setDigitlen:0];
            [dataItem setByteslen:1];
            [array addObject:dataItem];
        }
        
        [entity setUserData:array];
        
        if ([_fn isEqualToString:@"F51"]) {
            [entity setUseP0:YES];
        }
        
        [finalArray addObject:entity];
    }
    
    XL3761PackUserData *userData = [[XL3761PackUserData alloc] init];
    [userData setAfn:afn];
    [userData setUserData:finalArray];
    
    [self.socketManager packRequestFrame:userData];
}


/*－－－－－－－－－－－－－－
 通用召测
 
 数据时标 Tdc  曲线数据时标
 
 分时月日年
 
 数据冻结密度
 
 数据点数
 －－－－－－－－－－－－－－*/
-(void)commonRequestWithAfn:(Byte)afn
                     withFn:(NSArray*)fn
                    withTdc:(NSString*)tdc{
    
    NSArray *splitArray = [tdc componentsSeparatedByString:@","];
    NSMutableArray *finalArray = [NSMutableArray array];
    
    for(NSString *_fn in fn){
        
        XL3761PackEntity *entity = [[XL3761PackEntity alloc] init];
        [entity setFn:_fn];
        
        NSMutableArray *array = [NSMutableArray array];
        
        for(int i = 0; i < 7;i++ ){
            
            XL3761PackItem *dataItem = [[XL3761PackItem alloc] init];
            dataItem.value = [splitArray[i] integerValue];
            [dataItem setDigitlen:0];
            [dataItem setByteslen:1];
            [array addObject:dataItem];
        }
        
        [entity setUserData:array];
        [finalArray addObject:entity];
    }
    
    XL3761PackUserData *userData = [[XL3761PackUserData alloc] init];
    [userData setAfn:afn];
    [userData setUserData:finalArray];
    
    [self.socketManager packRequestFrame:userData];
}


/*－－－－－－－－－－－－－－
 通用召测
 
 F1 重要事件 F2 一般事件
 
 召测事件 pm 起始指针  pn 结束指针
 －－－－－－－－－－－－－－*/
-(void)commonRequestWithAfn:(Byte)afn
                     withFn:(NSString*)fn
                     withPm:(NSInteger)pm
                     withPn:(NSInteger)pn{
    
    NSMutableArray *finalArray = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray array];
    
    XL3761PackEntity *entity = [[XL3761PackEntity alloc] init];
    [entity setFn:fn];
    
    for(int i = 0; i<2; i++){
        
        XL3761PackItem *dataItem = [[XL3761PackItem alloc] init];
        [dataItem setValue:(i == 0) ? pm : pn];
        [dataItem setByteslen:1];
        [dataItem setDigitlen:0];
        [dataItem setUseByte:YES];
        [array addObject:dataItem];
    }
    
    [entity setUseP0:YES];
    [entity setUserData:array];
    [finalArray addObject:entity];
    
    XL3761PackUserData *userData = [[XL3761PackUserData alloc] init];
    [userData setAfn:afn];
    [userData setUserData:finalArray];
    
    [self.socketManager packRequestFrame:userData];
}



/*－－－－－－－－－－－－－－－－－－－－－
 对时 AFN05 F31
 
 对时报文时间设置
 
 例:2013年12月26日 21:24:38 星期四
 
       3           8
 0  0  1   1  | 1 0 0 0 -->38秒
 .
 .
 
  星期四    1       2
 1  0  0   1  | 0 0 2 0 -->星期四 12月
 
      1            3
 0  0  0   1  | 0 0 1 1 -->13年
 －－－－－－－－－－－－－－－－－－－－－*/
-(void)setDeviceClock{
    
    XL3761PackEntity *entity = [[XL3761PackEntity alloc] init];
//    [entity setAfn:0x05];
    [entity setFn:@"F31"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|
                                                         NSDayCalendarUnit|NSHourCalendarUnit|
                                                         NSMinuteCalendarUnit|NSSecondCalendarUnit|
                                                         NSWeekdayCalendarUnit)
                                               fromDate:[NSDate date]];
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSMutableArray *list = (NSMutableArray*)@[[NSString stringWithFormat:@"%d",[components second]],
                                              [NSString stringWithFormat:@"%d",[components minute]],
                                              [NSString stringWithFormat:@"%d",[components hour]],
                                              [NSString stringWithFormat:@"%d",[components day]]];
                                              
    
    [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        XL3761PackItem *item = [[XL3761PackItem alloc] init];
        item.value = [(NSString*)obj doubleValue];
        [item setDigitlen:0];
        [item setByteslen:1];
        [array addObject:item];
    }];

    list = (NSMutableArray*)@[[NSNumber numberWithInteger:( (([components weekday]-1)<<5 & 0xe0)|
                                                           ([components month]/10 << 4))|
                               ([components month]%10 & 0x0f)],
                              [NSNumber numberWithInteger:[components year]%2000]];
    
    
    [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XL3761PackItem *item = [[XL3761PackItem alloc] init];
        item.value = [(NSString*)obj doubleValue];
        [item setDigitlen:0];
        [item setByteslen:1];
        if (!idx) [item setUseByte:YES];
        [array addObject:item];
    }];
    
    XL3761PackItem *item = [[XL3761PackItem alloc] init];
    [item setValue:0];
    [item setDigitlen:0];
    [item setByteslen:16];
    [array addObject:item];

    entity.userData = array;
    entity.useP0 = YES;
    
    NSMutableArray *finalArray = [NSMutableArray array];
    [finalArray addObject:entity];
    
    XL3761PackUserData *userData = [[XL3761PackUserData alloc] init];
    [userData setAfn:0x05];
    userData.userData = finalArray;

    [self.socketManager packRequestFrame:userData];
}

@end
