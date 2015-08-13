//
//  ZWTextView.h
//  封装一个textView类
//
//  Created by ZhaoWei on 15/7/18.
//  Copyright (c) 2015年 ZhaoWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWTextView : UITextView
@property (nonatomic,strong)NSString *placeholder;
@property (nonatomic,strong)UIColor *placeholderColor;
- (void)_initialize;
- (void)_updateShouldDrawPlaceholder;
- (void)_textChanged:(NSNotification *)notification;
@end
