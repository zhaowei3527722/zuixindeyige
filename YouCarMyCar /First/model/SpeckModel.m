//
//  SpeckModel.m
//  YouCarMyCar
//
//  Created by LLY on 15/8/8.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "SpeckModel.h"

@implementation SpeckModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    if ([key isEqual:@"id"]) {
        self.myid = value;
        
    }
    
}

@end
