//
//  CommonHandle.m
//  ITInformation - 4.15
//
//  Created by lanou3g on 15-4-16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CommonHandle.h"
#import "PrefixHeader.pch"
@implementation CommonHandle

static CommonHandle *isHandle = nil;
+(CommonHandle *)shareHandle
{
    @synchronized(self)
    {
        if (isHandle == nil) {
            isHandle = [[CommonHandle alloc] init];
            isHandle.isShiYongXieYi = YES;
        }
    }
    
    return isHandle;
}


@end
