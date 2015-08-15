//
//  SpectGoodRigthViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/8/15.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "SpectGoodRigthViewController.h"

@interface SpectGoodRigthViewController ()

@end

@implementation SpectGoodRigthViewController
-(id)initWithModel:(WangQiModel *)model

{
    
    if ([super init]) {
        
        self.mymodel= model;
        
        
    }
    return self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
