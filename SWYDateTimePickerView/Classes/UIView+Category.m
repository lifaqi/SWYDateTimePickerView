//
//  UIView+Category.m
//  Wenshen
//
//  Created by Rain on 17/7/11.
//  Copyright © 2017年 zykj. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

- (void)addTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tapIv = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    self.userInteractionEnabled = true;
    [self addGestureRecognizer:tapIv];
}

- (void)removeTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tapIv = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self removeGestureRecognizer:tapIv];
}

@end
