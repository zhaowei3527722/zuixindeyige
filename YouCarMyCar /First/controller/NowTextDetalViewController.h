//
//  NowTextDetalViewController.h
//  YouCarMyCar
//
//  Created by LLY on 15/7/27.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NowViewModel.h"

@interface NowTextDetalViewController : UIViewController
@property (nonatomic ,strong)UIScrollView *myscrollView;
@property (nonatomic,strong)UIButton *liftButton;
@property (nonatomic ,strong)UIButton *rightButton;
@property (nonatomic ,strong)NowViewModel *myModelnoW;

@property (nonatomic)BOOL iSbutton;




@end
