//
//  SpectGoodRigthViewController.h
//  YouCarMyCar
//
//  Created by LLY on 15/8/15.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WangQiModel.h"
#import "ZWTextView.h"

@interface SpectGoodRigthViewController : UIViewController
@property (nonatomic ,strong)WangQiModel *mymodel;
-(id)initWithModel:(WangQiModel *)model;


@end
