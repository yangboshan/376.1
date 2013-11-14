//
//  XLFrameData.h
//  XLDistributionBoxApp
//
//  376.1 Frame agent
//
//  Created by JY on 13-5-17.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLFrameData : NSObject

@property (nonatomic,retain) NSData *receivedData;

-(id)  initWithData:(NSData*)recData;
-(void)parseUserData;

@end
