//
//  XL3761AFN4.m
//  XLDistributionBoxApp
//
//  Created by JY on 13-8-20.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761AFN4.h"

@interface XL3761AFN4()

@property(nonatomic,assign) NSInteger _index;
@end

@implementation XL3761AFN4


/*－－－－－－－－－－－－－－－－－
终端事件记录 配置设置
 
F9
－－－－－－－－－－－－－－－－－*/
-(void)F9{
    NSLog(@"执行:%s",__func__);
}


/*－－－－－－－－－－－－－－－－－
终端电能表交流采样装置 配置参数
 
F10
－－－－－－－－－－－－－－－－－*/
-(void)F10{
    NSLog(@"执行:%s",__func__);
}


/*－－－－－－－－－－－－－－－－－
测量点基本参数
 
F25
－－－－－－－－－－－－－－－－－*/
-(void)F25{
    NSLog(@"执行:%s",__func__);
}


/*－－－－－－－－－－－－－－－－－
测量点限值参数
 
F26
－－－－－－－－－－－－－－－－－*/
-(void)F26{
    NSLog(@"执行:%s",__func__);
    
    self.resultSet = nil;
    self.resultSet = [[NSMutableDictionary alloc] init];
    
    
    //每个项数据格式
    NSArray *formatList =
            @[@"A7",@"A7",@"A7",@"A7",@"BIN",@"A5",@"A7",@"BIN",@"A5",@"A25",
                            @"BIN",@"A5",@"A25",@"BIN",@"A5",@"A25",@"BIN",@"A5",@"A23",@"BIN",
                            @"A5",@"A23",@"BIN",@"A5",@"A5",@"BIN",@"A5",@"A5",@"BIN",@"A5",@"BIN"];
 
    [formatList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *format = formatList[idx];
        
        NSString *fnMethod = [NSString stringWithFormat:@"afn4Retrive%@",format];
        SEL selector = NSSelectorFromString(fnMethod);
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Warc-performSelector-leaks"
        [self performSelector:selector];
#pragma clang diagnostic pop

        self._index+=1;
    }];
 
    [self.finalSet setValue:self.resultSet
                     forKey:[self getKeyString:self.keyCount]];
    self.keyCount += 1;
}

/*－－－－－－－－－－－－－－－－－
FORMAT:A5
 －－－－－－－－－－－－－－－－－*/
-(void)afn4RetriveA5{
    
    [self.resultSet setValue:[NSNumber numberWithDouble:
                              [self bcdToSignedDoubleWithBytes:self.userData + self.pos
                                                      withblen:2
                                                      withdlen:1
                                                   withSignPos:Left]]
                      forKey:[self getKeyString:self._index]];
    self.pos+=2;
}

/*－－－－－－－－－－－－－－－－－
 FORMAT:A7
 －－－－－－－－－－－－－－－－－*/
-(void)afn4RetriveA7{
    
    [self.resultSet setValue:[NSNumber numberWithDouble:
                              [self bcdToDoubleWithBytes:self.userData + self.pos
                                                withblen:2
                                                withdlen:1]]
                      forKey:[self getKeyString:self._index]];
    self.pos+=2;
}

/*－－－－－－－－－－－－－－－－－
 FORMAT:A23
 －－－－－－－－－－－－－－－－－*/
-(void)afnRetriveA23{
    
    [self.resultSet setValue:[NSNumber numberWithDouble:
                              [self bcdToDoubleWithBytes:self.userData + self.pos
                                                withblen:3
                                                withdlen:4]]
                      forKey:[self getKeyString:self._index]];
    self.pos+=3;
}

/*－－－－－－－－－－－－－－－－－
 FORMAT:A25
 －－－－－－－－－－－－－－－－－*/
-(void)afnRetriveA25{
    
    [self.resultSet setValue:[NSNumber numberWithDouble:
                              [self bcdToSignedDoubleWithBytes:self.userData + self.pos
                                                      withblen:3
                                                      withdlen:3
                                                   withSignPos:Left]]
                      forKey:[self getKeyString:self._index]];
    self.pos+=3;
}

/*－－－－－－－－－－－－－－－－－
 FORMAT:BIN
 －－－－－－－－－－－－－－－－－*/
-(void)afnRetriveBIN{
    
    [self.resultSet setValue:[NSNumber numberWithDouble:*(Byte*)(self.userData + self.pos)]
                      forKey:[self getKeyString:self._index]];
    self.pos+=1;
}

@end
