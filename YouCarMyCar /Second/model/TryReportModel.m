//
//  TryReportModel.m
//  YouCarMyCar
//
//  Created by LLY on 15/8/14.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "TryReportModel.h"

@implementation TryReportModel

-(void)setValue:(id)value forKey:(NSString *)key
{
   
    if (value != [NSNull null]) {
        [super setValue:value forKey:key];
        if ([key isEqualToString:@"id"]) {
            self.myid = value;
            
            
            if (value == [NSNull null]) {
                NSLog(@"%@",value);
                
            }
        }

    }
    
    }


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
