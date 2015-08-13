//
//  LoginViewController.h
//  YouCarMyCar
//
//  Created by LLY on 15/7/4.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyTextFied.h"
#import "MBProgressHUD.h"

@interface LoginViewController : UIViewController

@property (nonatomic ,strong)UIImageView *qqImageView;
@property (nonatomic ,strong)UIImageView *weixinImageView;
@property (nonatomic ,strong)UIImageView *xinlangImageView;
@property (nonatomic ,strong)UIImageView *photoImabeView;
@property (nonatomic )CGFloat indextX;
@property (nonatomic)CGFloat indextY;
@property (nonatomic ,strong)UIButton  *forgetPasswordButton;
@property (nonatomic,strong)UIButton *registerButton;
@property (nonatomic ,strong)UIButton *loginButton;
@property (nonatomic ,strong)MyTextFied *userNameMy;
@property (nonatomic ,strong)MyTextFied *userPassWordMy;
@property (nonatomic ,strong)UIButton *myZibutton;
@property (nonatomic )BOOL indext;
@property (nonatomic ,strong)MBProgressHUD *HUD;//加载



@end
