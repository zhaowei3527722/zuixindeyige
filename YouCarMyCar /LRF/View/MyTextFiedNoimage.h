//
//  MyTextFiedNoimage.h
//  YouCarMyCar
//
//  Created by LLY on 15/7/22.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyTextFiedNoimageDelegete <NSObject>

-(void)ReturnAction:(UITextField *)textfield;


@end

@interface MyTextFiedNoimage : UIView


@property (nonatomic ,strong)UIImageView *myBigimageView;
@property (nonatomic ,strong)UIImageView *mySmallimageView;
@property (nonatomic ,strong)UITextField *mytextField;
@property (nonatomic ,assign)id<MyTextFiedNoimageDelegete>delegate;


@end
