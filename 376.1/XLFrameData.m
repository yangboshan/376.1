//
//  XLFrameData.m
//  XLDistributionBoxApp
//
//  376.1 Frame agent
//
//  Created by JY on 13-5-17.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XLFrameData.h"
#import "XL3761BaseRequest.h"

//3761协议标识
#define PROTOCOL   0x2
//帧起始符
#define FRAME_START_BYTE 0x68
//帧结束符
#define FRAME_END_BYTE   0x16

@interface XLFrameData()
{
    int                frameLength;     //帧总长
    Byte              *frameData;       //帧数据

    int                userDataLength;  //用户数据长度
    
    XL3761BaseRequest *baseRequest;
}

-(Byte)getCheckSum:(Byte *)userData :(int)length;     //获取校验和

-(int) parseUserDataLength;                           //解析用户数据长度

-(BOOL)frameCheck;                                    //帧检查

-(void)initBaseRequest;

-(void)parseControlField;                             //解析控制域

-(void)parseAddressField;                             //解析地址域

-(void)parseSEQField;

-(void)parseDADT;

-(void)parseAUXField;

-(NSString*)getHexString:(Byte)byte;

-(Byte)getMaskByte:(NSInteger)i;

@end

@implementation XLFrameData

@synthesize receivedData;

/*－－－－－－－－－－－－－－－－－
  初始化
－－－－－－－－－－－－－－－－－*/
-(id)initWithData:(NSData*)recData
{
    if (self=[super init]) {
        
        self.receivedData = recData;
        
        frameLength =  [self.receivedData length];
        
        frameData   =   malloc(frameLength);
        
        memcpy(frameData, (Byte*)[self.receivedData bytes],
               frameLength);
        
        
//        baseRequest = [[XL3761BaseRequest alloc] init];
        //................
    }
    return self;
}

#pragma mark -frame check


/*－－－－－－－－－－－－－－－－－
 帧检查
－－－－－－－－－－－－－－－－－*/
-(BOOL)frameCheck
{
    if ([self.receivedData length]!=0) {
        
        userDataLength = [self parseUserDataLength];
        
        if (userDataLength == -1) {
            return NO;
        }
        /*检查起始位结束位*/
        if ( *(frameData)               != FRAME_START_BYTE ||
             *(frameData+5)             != FRAME_START_BYTE ||
             *(frameData+frameLength-1) != FRAME_END_BYTE) {
            
            NSLog(@"开始位结束位检查出错");
            return NO;
        }
        
        if (frameLength!=userDataLength+8) {
            NSLog(@"长度检查出错");
            return NO;
        }
        
        /*检查帧校验和*/
        if ([self getCheckSum:frameData + 6 :userDataLength]
                         != *(frameData+frameLength-2)) {
            NSLog(@"校验和检查出错");
            return NO;
        }
    } else {
        return NO;
    }
    
    return YES;
}

/*－－－－－－－－－－－－－－－－－
 获取校验和
－－－－－－－－－－－－－－－－－*/
-(Byte)getCheckSum:(Byte *)userData :(int)length
{
    Byte *pos = userData;
    Byte total = 0;
    
    for ( int i =0; i<length; ++i)
    {
        total += *pos;
        ++pos;
    }
    
//    NSLog(@"校验和%2x",total);
    return total;
}


/*－－－－－－－－－－－－－－－－－
 解析用户数据长度
－－－－－－－－－－－－－－－－－*/
-(int)parseUserDataLength
{

    unsigned short* lengthField = (unsigned short*)(frameData+1);
    
    //检测协议类型
    if ((*lengthField & 0x0003)!=PROTOCOL) {
        return -1;
    }
    
    NSLog(@"用户数据长度:%d",(*lengthField)>>2);
    
    return (*lengthField)>>2;
}


#pragma mark -frame parse
/*－－－－－－－－－－－－－－－－－
 解析固定字节
－－－－－－－－－－－－－－－－－*/
-(void)initBaseRequest
{
    baseRequest.userDataLength = userDataLength;
    [self parseControlField];
    [self parseAddressField];
    [self parseSEQField];
    [self parseDADT];
    
    baseRequest.userData = malloc(userDataLength - 11);
    memcpy(baseRequest.userData,frameData+18,userDataLength - 11);
    
    free(frameData);
}


/*－－－－－－－－－－－－－－－－－
 解析信息点信息类
－－－－－－－－－－－－－－－－－*/
-(void)parseDADT
{
    NSMutableArray *dadtArray = [[NSMutableArray alloc] init];
    NSMutableArray *fNArray =   [[NSMutableArray alloc] init];
    NSMutableArray *pnArray =   [[NSMutableArray alloc] init];
 
    Byte pN           = *(Byte*)(frameData+14);
    NSInteger pNGroup = *(Byte*)(frameData+15);
    
    Byte fN           = *(Byte*)(frameData+16);
    NSInteger fNGroup = *(Byte*)(frameData+17);

    NSInteger tNumber = 0;
    
    for (int i = 7; i>=0;i--)
    {
        Byte mask = [self getMaskByte:i];
        
        if((fN & mask) >> i)
        {
            tNumber = fNGroup * 8 + 1 + i;
            [fNArray addObject:[NSNumber numberWithInteger:
                                                 tNumber]];
        }
        
        if((pN & mask) >> i)
        {
            tNumber = pNGroup * 8 - (7 - i);
            [pnArray addObject:[NSNumber numberWithInteger:
                                                 tNumber]];
        }
    }
    
    pnArray = (NSMutableArray*)[[pnArray reverseObjectEnumerator]
                                allObjects];
    
    for (NSNumber *fNumber in fNArray)
    {
        if (![pnArray count]) {
            XL3761DADTRecord *record = [[XL3761DADTRecord alloc] initWith:
                                        [fNumber integerValue] :
                                        0];
            
            [dadtArray addObject:record];
            
        } else {
            for ( NSNumber *pNumber in pnArray)
            {
                XL3761DADTRecord *record = [[XL3761DADTRecord alloc] initWith:
                                            [fNumber integerValue] :
                                            [pNumber integerValue]];
                
                [dadtArray addObject:record];
            }
        }
    }
    
    baseRequest.dadt = dadtArray;
}


/*－－－－－－－－－－－－－－－－－
 解析SEQ
－－－－－－－－－－－－－－－－－*/
-(void)parseSEQField
{
    XL3761SEQField *seqField = [[XL3761SEQField alloc] initWith:(*(Byte*)(frameData+13) & 0x80)>>7 :
                                   (*(Byte*)(frameData+13) & 0x40)>>6 :
                                   (*(Byte*)(frameData+13) & 0x20)>>5 :
                                   (*(Byte*)(frameData+13) & 0x10)>>4 :
                                   (*(Byte*)(frameData+13) & 0x0f)];
    baseRequest.SEQ = seqField;
}


/*－－－－－－－－－－－－－－－－－
 解析链路用户数据控制域
－－－－－－－－－－－－－－－－－*/
-(void)parseControlField
{
    
    XL3761ControlField *controlField = [[XL3761ControlField alloc] initWith:(*(Byte*)(frameData+6) & 0x80)>>7 :
                                                                       (*(Byte*)(frameData+6) & 0x40)>>6 :
                                                                       (*(Byte*)(frameData+6) & 0x20)>>5 :
                                                                       (*(Byte*)(frameData+6) & 0x10)>>4 :
                                                                       (*(Byte*)(frameData+6) & 0x0f)];
    baseRequest.controlField = controlField;
}

/*－－－－－－－－－－－－－－－－－
 解析链路用户数据地址域
－－－－－－－－－－－－－－－－－*/
-(void)parseAddressField
{
 
    XL3761AddressField *addressField = [[XL3761AddressField alloc] initWith:(unsigned short*)(frameData+7) :
                                                                       (unsigned short*)(frameData+9) :
                                                                       (unsigned char *)(frameData+11)];
    
    baseRequest.addressField = addressField;
}


/*－－－－－－－－－－－－－－－－－
 解析AUX域
－－－－－－－－－－－－－－－－－*/
-(void)parseAUXField
{
    
}

/*－－－－－－－－－－－－－－－－－
 获得MASK BYTE
－－－－－－－－－－－－－－－－－*/
-(Byte)getMaskByte:(NSInteger)i
{
    Byte mask;
    
    if (i>=4) {
        mask = ((Byte)pow(2, i-4))<<4 & 0xf0;
    } else {
        mask = (Byte)pow(2, i) & 0x0f;
    }
    
    return mask;
}

/*－－－－－－－－－－－－－－－－－
 HEX 4 Class Name
－－－－－－－－－－－－－－－－－*/
-(NSString*)getHexString:(Byte)byte
{
    return [[NSString stringWithFormat:@"%x",byte] uppercaseString];
}


#pragma mark - frames hand out
/*－－－－－－－－－－－－－－－－－
 PARSE
－－－－－－－－－－－－－－－－－*/
-(void)parseUserData
{
    if (![self frameCheck]) {
        return;
    }
    
    baseRequest.AFN = *(Byte*)(frameData+12);
    
    NSString *afnClass = [NSString stringWithFormat:@"%@%@",
                          NSLocalizedString(@"CLASS_PREFIX", nil),
                          [self getHexString:*(Byte*)(frameData+12)]];
    
    baseRequest = [[NSClassFromString(afnClass) alloc] init];
    
    [self initBaseRequest];
    
    [baseRequest parseUserData];
}

@end
