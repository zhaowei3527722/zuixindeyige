//
//  CommonHandle.h
//  ITInformation - 4.15
//
//  Created by lanou3g on 15-4-16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonHandle : NSObject

+(CommonHandle *)shareHandle;

@property (nonatomic)NSInteger tableViewTag;
@property (nonatomic, retain)NSString *whichDetailURL;
@property (nonatomic)BOOL isShiYongXieYi;  // 判断试用协议是否被选中;
@end
