//
//  AllDeteModel.m
//  YouCarMyCar
//
//  Created by LLY on 15/8/15.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "AllDeteModel.h"

@implementation AllDeteModel
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.myid  = value;
        
    }
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
