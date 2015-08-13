//
//  NowViewModel.h
//  YouCarMyCar
//
//  Created by LLY on 15/7/27.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NowViewModel : NSObject

/*

 •	"id": "25",
	•	"title": "我是试用产品",
	•	"info": "",
	•	"img": "04919964077568145.png",
	•	"price": "30.00",
	•	"try_limit_people": "0",
	•	"try_people": "28",
	•	"type": "2",
	•	"number": "3",
	•	"start_time": "1438652333",
	•	"small_info": "我是试用产品",
	•	"period_no": "12",
	•	"score": "12",
	•	"big_img": "",
	•	"date": -4,
	•	"hours": -13,
	•	"minutes": -24,
	•	"seconds": -53

 */

@property (nonatomic ,strong)NSString *start_time;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *try_limit_people;
@property (nonatomic ,strong)NSString *try_people;
@property (nonatomic ,strong)NSString *type;
@property (nonatomic ,strong)NSString *minutes;
@property (nonatomic ,strong)NSString *number;
@property (nonatomic ,strong)NSString *period_no;
@property (nonatomic ,strong)NSString *priceseconds;
@property (nonatomic ,strong)NSString *score;
@property (nonatomic ,strong)NSString *small_info;
@property (nonatomic ,strong)NSString *big_img;
@property (nonatomic ,strong)NSString *date;
@property (nonatomic ,strong)NSString *hours;
@property (nonatomic ,strong)NSString *myid;
@property (nonatomic ,strong)NSString *img;
@property (nonatomic ,strong)NSString *info;


@end
