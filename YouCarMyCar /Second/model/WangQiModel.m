//
//  WangQiModel.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/8/13.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "WangQiModel.h"

@implementation WangQiModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.myID = value;
    }
}


@end
