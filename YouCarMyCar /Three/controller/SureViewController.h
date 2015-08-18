//
//  SureViewController.h
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/16.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"



@interface SureViewController : UIViewController
@property (nonatomic)int j;
@property (nonatomic,strong)UITextField *nameFd;
@property (nonatomic,strong)UITextField *addressFd;
@property (nonatomic,strong)UITextField *phoneFd;
@property (nonatomic,strong)UITextField *youzhengFd;
@property (nonatomic,strong)AddressModel *addressMd;

@end
