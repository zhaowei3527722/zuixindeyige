//
//  EmailRegisterViewController.h
//  YouCarMyCar
//
//  Created by LLY on 15/7/21.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextFied.h"
#import "MyTextFiedNoimage.h"
@interface EmailRegisterViewController : UIViewController
@property (nonatomic ,strong)UIScrollView *phoneScrollView;
@property (nonatomic,strong)UIImageView *photoImabeView;

@property (nonatomic )CGFloat indextX;
@property (nonatomic)CGFloat indextY;

@property (nonatomic ,strong)MyTextFiedNoimage *nickNameMY;
@property (nonatomic ,strong)MyTextFiedNoimage *userNameMY;
@property (nonatomic ,strong)MyTextFied *numberMY;
@property (nonatomic ,strong)MyTextFiedNoimage *pasWordMY1;
@property (nonatomic ,strong)MyTextFiedNoimage *psaWordMY2;
@property (nonatomic ,strong)UIButton *registerButton;
@property (nonatomic ,strong)UIButton *numberButton;


@end
