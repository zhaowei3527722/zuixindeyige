//
//  ViewController.m
//  功能引导页
//
//  Created by Chen on 15/6/8.
//  Copyright (c) 2015年 chenweidong. All rights reserved.
//

#import "ViewController.h"
#import "WDGuideScrollView.h"
#import "RootTaBarViewController.h"

@interface ViewController ()<WdGuideScorollViewDeleageta>
@property (nonatomic, strong) WDGuideScrollView *guideView;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    NSArray *imageArray = [NSArray array];
        imageArray = @[@"引导1.jpg",@"引导2.jpg",@"引导3.jpg"];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth == 320? ScreenWidth / 2 - 60:ScreenWidth / 2 - 70, ScreenHeight - 120, ScreenWidth == 320?120:140, 45)];
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    button.titleLabel.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:@"矩形-2@2x.png"] forState:(UIControlStateNormal)];
    
    button.titleLabel.font = [UIFont systemFontOfSize:ScreenHeight == 480?18:20];
    [self.guideView scrollViewWithImageArray:imageArray WithButton:button];
    [self.view addSubview:self.guideView];
    self.guideView.deleageta = self;
    self.view .backgroundColor = [UIColor whiteColor];
    
    
}
-(void)buttonAction
{
    if (self.guideView.enterClick) {
        self.guideView.enterClick();
    }
    RootTaBarViewController *root  = [[RootTaBarViewController alloc]init];
    
    [self presentViewController:root animated:YES completion:nil];
    
    if (self.guideView.enterClick) {
        self.guideView.enterClick();
        NSLog(@"没有问题想的对");
        
    }

}

-(WDGuideScrollView *)guideView
{
    if (_guideView == nil) {
        _guideView = [[WDGuideScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        __weak typeof(self) weakSelf = self;
        _guideView.enterClick = ^{
            [UIView animateWithDuration:1.0 animations:^{
                weakSelf.guideView.hidden = YES;
            }];
        };
        [self.view addSubview:_guideView];
    }
    return _guideView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
