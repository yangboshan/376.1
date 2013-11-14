//
//  XL3761DADTRecord.h
//  XLDistributionBoxApp
//
//  376.1 Frame dadt record
//
//  Created by JY on 13-5-22.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XL3761BaseRequest.h"

@interface XL3761DADTRecord : NSObject

@property (nonatomic,assign) NSInteger pId;
@property (nonatomic,assign) NSInteger fId;

-(id)initWith:(NSInteger)_fId :(NSInteger)_pId;
@end
