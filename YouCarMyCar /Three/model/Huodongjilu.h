//
//  Huodongjilu.h
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/8/18.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 
 {
 "big_img": "http://img.nichewoche.com/shop/product/1439710200_3155_8220.png",
 "id": "115",
 "img": "http://img.nichewoche.com/shop/product/1439710200_9077_6153.jpg",
 "number": "23",
 "open_prize": "1440055700",
 "period_no": "10",
 "small_info": "当汽车因电瓶缺电而无法启动汽车时，可以应急启动汽车。2、检修照明：自带照明灯 夜晚检修汽车可以照明。 3、12V电源输出：自带点烟器插座，可以输出12V直流电。4、配合车载逆变器，就成为移动的220V电源。 5、充电方便，带车充和220V充电器，既可以在家里充电，也可以在车上充电",
 "status": "0",
 "title": "多功能移动电池 汽车应急启动电源 备用电瓶 自驾旅行专用品",
 "try_id": "43",
 "try_people": "28"
 },

 
 */
@interface Huodongjilu : NSObject

@property (nonatomic,strong)NSString *big_img;
@property (nonatomic,copy)NSString *myID;
@property (nonatomic,copy)NSString *img;
@property (nonatomic,copy)NSString *number;
@property (nonatomic,copy)NSString *open_prize;
@property (nonatomic,copy)NSString *period_no;
@property (nonatomic,copy)NSString *small_info;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *try_id;
@property (nonatomic,copy)NSString *try_people;


@end
