//
//  AddressModel.h
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/8/13.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "address": "beijing fangshan",
 "address_id": "125",
 "area_id": "0",
 "area_info": "",
 "city_id": "",
 "dlyp_id": "0",
 "is_default": "0",
 "member_id": "6163",
 "mob_phone": "18031931234",
 "tel_phone": "",
 "true_name": "wang ni ma",
 "zip_code": "052560"
 
 
 */
@interface AddressModel : NSObject
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *address_id;
@property (nonatomic,strong)NSString *area_id;
@property (nonatomic,strong)NSString *area_info;
@property (nonatomic,strong)NSString *dlyp_id;
@property (nonatomic,strong)NSString *is_default;
@property (nonatomic,strong)NSString *member_id;
@property (nonatomic,strong)NSString *mob_phone;
@property (nonatomic,strong)NSString *tel_phone;
@property (nonatomic,strong)NSString *true_name;
@property (nonatomic,strong)NSString *zip_code;
@property (nonatomic,strong)NSString *city_id;

@end
