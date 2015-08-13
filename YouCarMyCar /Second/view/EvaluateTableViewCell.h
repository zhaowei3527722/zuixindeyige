//
//  EvaluateTableViewCell.h
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/30.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWTextView.h"
#import "PrefixHeader.pch"
@interface EvaluateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shiyongIcon;
@property (weak, nonatomic) IBOutlet UILabel *shiyongLable;
@property (weak, nonatomic) IBOutlet UIImageView *textImage;
@property (weak, nonatomic) IBOutlet UIButton *zhaoxiangButton;
@property (nonatomic,strong)ZWTextView *zwTextView;
@end
