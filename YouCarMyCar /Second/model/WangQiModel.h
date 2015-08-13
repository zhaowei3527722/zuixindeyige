//
//  WangQiModel.h
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/8/13.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WangQiModel : NSObject
/*
 "big_img": "",
 "date": "-6",
 "end_time": "1439986678",
 "hours": "-4",
 "id": "18",
 "img": "04919242442855740.jpg",
 "minutes": "-18",
 "number": "0",
 "period_no": "0",
 "presence": 0,
 "price": "99.00",
 "score": "0",
 "seconds": "-57",
 "small_info": "",
 "start_time": "1439365678",
 "title": "导航记录仪",
 "try_limit_people": "0",
 "try_people": "66",
 "type": "2"
 
 */
@property (nonatomic,strong)NSString *big_img;
@property (nonatomic,strong)NSString *date;
@property (nonatomic,strong)NSString *end_time;
@property (nonatomic,strong)NSString *hours;
@property (nonatomic,strong)NSString *myID;
@property (nonatomic,strong)NSString *img;
@property (nonatomic,strong)NSString *minutes;
@property (nonatomic,strong)NSString *number;
@property (nonatomic,strong)NSString *period_no;
@property (nonatomic,strong)NSString *presence;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *score;
@property (nonatomic,strong)NSString *seconds;
@property (nonatomic,strong)NSString *small_info;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *try_limit_people;
@property (nonatomic,strong)NSString *try_people;
@property (nonatomic,strong)NSString *type;



@end
