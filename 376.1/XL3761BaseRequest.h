//
//  XL3761BaseRequest.h
//  XLDistributionBoxApp
//
//  376.1 Frame base Class
//
//  Created by JY on 13-5-21.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XL3761AddressField.h"
#import "XL3761ControlField.h"
#import "XL3761SEQField.h"
#import "XL3761Header.h"
#import "XL3761DADTRecord.h"

#import "XLNotifications.h"
#import "XLDataID.h"

#define Left  0
#define right 1

@interface XL3761BaseRequest : NSObject

@property(nonatomic,retain) XL3761Header       *header;
@property(nonatomic,retain) XL3761ControlField *controlField;
@property(nonatomic,retain) XL3761AddressField *addressField;

@property(nonatomic,assign) Byte AFN;
@property(nonatomic,retain) XL3761SEQField *SEQ;
@property(nonatomic,retain) NSArray *dadt;
@property(nonatomic,assign) Byte *userData;

@property(nonatomic,retain) NSMutableDictionary *resultSet;
@property(nonatomic,retain) NSMutableDictionary *finalSet;

@property(nonatomic,assign) NSInteger auxFieldLength;
@property(nonatomic,assign) NSInteger pos;
@property(nonatomic,assign) NSInteger userDataLength;
@property(nonatomic,assign) NSInteger keyCount;

//@property(nonatomic,assign) dispatch_semaphore_t sem;

-(void)parseUserData;

-(void)performNotificationWith:(NSString*)notifyName
                    withObject:(NSObject*)objc
                    withResult:(NSDictionary*)resultDic;

-(void)performGenericWithKey:(int)key
                  withLength:(int)byteLength
                    withRate:(int)rate
                   withDigit:(int)digit;

-(void)performGenericWithKey:(int)key
                    withKey2:(int)key2
                 withLength1:(int)byteLength1
                 withLength2:(int)byteLength2
                    withRate:(int)rate
                   withDigit:(int)digit;

-(void)performGenericWithKey:(int)key
                  withLength:(int)byteLength
                    withRate:(int)rate;

-(void)performGenericWithKey:(int)key
                  withLength:(int)byteLength
                    withRate:(int)rate
                   withDigit:(int)digit
                    isSigned:(BOOL)sign
                     signPos:(int)_pos;

-(void)performGenericWithKey:(int)key
                    withKey2:(int)key2
                  withLength:(int)byteLength
               withLoopTimes:(int)rate
                   withDigit:(int)digit;

-(double)bcdToDoubleWithBytes:(Byte*)bcdCode
                     withblen:(NSInteger)bytesLength
                     withdlen:(NSInteger)digitLength;

-(double)bcdToSignedDoubleWithBytes:(Byte*)bcdCode
                           withblen:(NSInteger)bytesLength
                           withdlen:(NSInteger)digitLength
                        withSignPos:(NSInteger)pos;

-(NSString*)bcdToTimeWithBytes:(Byte*)bcdCode
                      withblen:(NSInteger)bytesLength
                      withType:(NSInteger)type;

-(NSString*)asciiToStringWithBytes:(Byte*)asciiCode
                          withblen:(NSInteger)bytesLength;


-(NSString*)binToStringWithBytes:(Byte*)bin
                        withblen:(NSInteger)bytesLength;

-(NSString*)getKeyString:(int)key;
-(void)sendResult;
-(void)shouldContinue;
@end
