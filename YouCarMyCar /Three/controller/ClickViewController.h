//
//  ClickViewController.h
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/7.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClickViewControllerDelegate <NSObject>

-(void)sender:(NSString*)sexString;
-(void)coderNstring:(NSString *)coder moblePhone:(NSString *)moblePhone;
-(void)codernstring:(NSString *)coder email:(NSString *)email;
-(void)senderAddress:(NSString *)addressStr;

@end

@interface ClickViewController : UIViewController
@property (nonatomic)int i;
@property (nonatomic,copy)NSString *sexStr;
@property (nonatomic,strong)UIButton *bianjiBT;
@property (nonatomic,strong)UIButton *shanchuBT;
@property (nonatomic,strong)UIButton *morenBT;
@property (nonatomic,strong)NSIndexPath *myIndexPath;
@property (nonatomic,copy)NSString *sexString;
@property (nonatomic,copy)NSString *addressStr;
@property (nonatomic,assign)id<ClickViewControllerDelegate>delegate;
@end
