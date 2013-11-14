//
//  XLSocketOperation.m
//  XLDistributionBoxApp
//
//  Created by JY on 13-5-15.
//  Copyright (c) 2013年 XLDZ. All rights reserved.
//

#import "XLSocketOperation.h"

#define CURTHREAD_DICTIONARY @"CURRENT_THREAD_DICTIONARY"

#define currentOperation() (NSOperation*)[[[NSThread currentThread] threadDictionary] \
                            valueForKey:CURTHREAD_DICTIONARY]

@implementation XLSocketOperation

@synthesize target=_target;
@synthesize object=_object;
@synthesize selector=_selector;

-(id)init
{
    if(self = [super init])
    {
        [self setQueuePriority:NSOperationQueuePriorityNormal];
        self.target =nil;
        self.object = nil;
        self.selector = nil;
    }
    return self;
}

-(void)main
{
    if ([self.target respondsToSelector:self.selector]) {
        NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
        [threadDictionary setObject:self forKey:CURTHREAD_DICTIONARY];
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:self.object];
#pragma clang diagnostic pop
        
        
        [threadDictionary removeObjectForKey:CURTHREAD_DICTIONARY];
    }
}

@end
