//
//  XLFramingRequest.m
//  XLDistributionBoxApp
//
//  组帧
//
//  Created by JY on 13-8-20.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761PackRequest.h"

#define START 0x68
#define END 0x16
#define PROTOCOL 0x02
#define ZERO 0x00


#define CF1 0x4a
#define CF2 0x4b


@interface XL3761PackRequest(){
    
    Byte *frame;
    int   length;
}

@property(nonatomic,assign) NSInteger pos;
@end

@implementation XL3761PackRequest


/*－－－－－－－－－－－－－－
 组帧
－－－－－－－－－－－－－－*/
-(NSData*)packFrame:(XL3761PackUserData*)userData{
    
    /*帧总长度*/
    length = userData.userDataLength + 8;
    
    frame = malloc(length);
    
    /*设置开始位 结束位*/
    frame[self.pos++] = START;
    *(frame+5) = START;
    *(frame + length -1) = END;
    
    /*设置长度L*/
    unsigned short lengthField = (userData.userDataLength)<<2
                                                    | PROTOCOL;
    
    //长度L1
    frame[self.pos++] = (Byte)(lengthField & 0x00ff);
    frame[self.pos++] = (Byte)((lengthField & 0xff00)>>8);
    
    //长度L2
    frame[self.pos++] = *(frame+1);
    frame[self.pos++] = *(frame+2);
    
    self.pos++;
    
    /*控制域*/
    frame[self.pos++] = CF2;
    
    /*地址域*/
    frame[self.pos++]  = 0x00;frame[self.pos++]  = 0x25;
    frame[self.pos++]  = 0x01;frame[self.pos++] = 0x00;
    frame[self.pos++] = 0x04;
    
    /*设置AFN*/
    frame[self.pos++] = userData.afn;
    
    /*设置SEQ*/
    frame[self.pos++] = 0x61;
 
    /*设置用户数据区*/
    [self setUserData:userData];
    
    /*设置校验和*/
    [self setCheckSum:(frame + 6)];

    NSData *data = [NSData dataWithBytes:frame
                                  length:length];
    free(frame);

    return data;
}



/*－－－－－－－－－－－－－－
 生成用户数据区
 
 遍历数组转化十进制数据为BCD
 －－－－－－－－－－－－－－*/
-(void)setUserData:(XL3761PackUserData*)userData{
    
//    self.pos = 14;
    
    [userData.userData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XL3761PackEntity *entity = (XL3761PackEntity*)obj;
        
        if (entity.useP0) {
            
            frame[self.pos++] = 0x00;
            frame[self.pos++] = 0x00;
            
        } else {
            frame[self.pos++] = 0x01;
            frame[self.pos++] = 0x01;
        }
        
        [self setDtField:entity.fn];
        
        if (entity.userData) {
            
            [entity.userData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                XL3761PackItem *item = (XL3761PackItem*)obj;
                
                if (!item.useByte) {
                    [self decimalToBcdForValue:item.value
                                  withBytesLen:item.byteslen
                                  withDigitLen:item.digitlen];
                } else {
                    frame[self.pos] = (Byte)item.value;
                    self.pos ++;
                }
            }];
        }
    }];
}


/*－－－－－－－－－－－－－－
 十进制转BCD码
 dec      ---  十进制数
 len      ---  转码后字节长度
 digitlen ---  小数位数
 －－－－－－－－－－－－－－*/
-(void)decimalToBcdForValue:(double)dec
               withBytesLen:(int)len
               withDigitLen:(int)digitlen{
    
    int decimal = dec * pow(10, digitlen);
    
    int i;
    int temp;
    for(i=0; i<len; i++)
    {
        temp = decimal%100;
        
        frame[self.pos++] = ((temp/10)<<4) + ((temp%10) & 0x0F);
        decimal /= 100;
    }
}

/*－－－－－－－－－－－－－－－－－
  生成校验和
－－－－－－－－－－－－－－－－－*/
-(void)setCheckSum:(Byte *)userData
{
    Byte *pos = userData;
    Byte total = 0;
    
    for ( int i =0; i<length - 8; ++i)
    {
        total += *pos;
        ++pos;
    }
    
    frame[length-2] = total;
}


/*－－－－－－－－－－－－－－－－－
 生成FN
 例如:  F16 ------> 80 01
－－－－－－－－－－－－－－－－－*/
-(void)setDtField:(NSString*)dt{
    
    NSInteger fn = [[dt substringFromIndex:1] integerValue];
    NSInteger group = (fn-1)/8;
    NSInteger _fn = (fn - 1) % 8 + 1 ;
    
    /*－－－－－－－－－－－－－－－－－
     8        |0
     1 0 0 0  |0 0 0 0  8-----> 80
     
       7      |0
     0 1 0 0  |0 0 0 0  7-----> 40
     
         6    |0
     0 0 1 0  |0 0 0 0  6-----> 20
     
           5  |0
     0 0 0 1  |0 0 0 0  5-----> 10
     －－－－－－－－－－－－－－－－－*/

    if (_fn > 4) {
        frame[self.pos++] = ((Byte)pow(2,_fn-1-4))<<4 & 0xf0;
    } else {
        frame[self.pos++] = (Byte)pow(2, _fn-1) & 0x0f;
    }
    
    frame[self.pos++] = group;
}

@end
