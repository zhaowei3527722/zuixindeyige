//
//  Urljson.h
//  YouCarMyCar
//
//  Created by LLY on 15/8/14.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Urljson : NSObject

@property (nonatomic,strong)NSString *img;
@property (nonatomic ,strong)NSString *type;
@property (nonatomic ,strong)NSString *size;
@property (nonatomic ,strong)NSString *width;
@property (nonatomic ,strong)NSString *heigth;
@property (nonatomic ,strong)NSString *mda5;


/*
 
 ：[{"img":"sdfdsfsfsdfsdfs","type":"jpg","size":"100","width":"12","height":"12","md5":"sssss"}] （数组方式，可多个）
 参数说明：
 img=>图片base_64加密串
 type=>jpg\png\gif 图片扩展名
 size=>体积 字节
 width=>宽
 height=>高
 md5=>base_64加密串的md5加密。效验数据是否完整
 

 
 */

@end
