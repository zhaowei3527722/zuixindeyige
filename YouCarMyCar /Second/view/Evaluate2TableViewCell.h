//
//  Evaluate2TableViewCell.h
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/30.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWTextView.h"
#import "PrefixHeader.pch"
@interface Evaluate2TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shiyongIcon;
@property (weak, nonatomic) IBOutlet UILabel *shiyongTitle;
@property (weak, nonatomic) IBOutlet UIImageView *shiyongImage;
@property (nonatomic,strong)ZWTextView *zwTextView;
@end
