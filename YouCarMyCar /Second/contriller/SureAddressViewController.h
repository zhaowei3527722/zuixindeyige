//
//  SureAddressViewController.h
//  YouCarMyCar
//
//  Created by LLY on 15/7/29.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyTextFiedNoimage.h"

@interface SureAddressViewController : UIViewController
@property (nonatomic ,strong)UIScrollView *myScrollView;
@property (nonatomic ,strong)MyTextFiedNoimage *myNameMY;
@property (nonatomic ,strong)MyTextFiedNoimage *myAddressMY;
@property (nonatomic ,strong)MyTextFiedNoimage *myPhoneNumberMy;
@property (nonatomic ,strong)MyTextFiedNoimage *myEmailMY;
@property (nonatomic ,strong)UIButton *mySureButton;

@end
