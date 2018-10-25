//
//  UIView+Category.h
//  Wenshen
//
//  Created by Rain on 17/7/11.
//  Copyright © 2017年 zykj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

/// 添加事件
- (void)addTarget:(id)target action:(SEL)action;

/// 移除事件
- (void)removeTarget:(id)target action:(SEL)action;

@end
