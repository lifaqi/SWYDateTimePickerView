//
//  SWYDateTimePickerView.h
//  SWYDateTimePickerView
//
//  Created by 淘翼购 on 2018/10/8.
//  Copyright © 2018年 shenwuyue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DatePickerViewMode){
    DatePickerViewModeDateTime, // 年月日，时分
    DatePickerViewModeDate, // 年月日
    DatePickerViewModeTime // 时分
};

@protocol SWYDateTimePickerViewDelegate <NSObject>
@optional
/**
 * 确定按钮
 */
-(void)didClickFinishDateTimePickerView:(NSString*)date;
/**
 * 取消按钮
 */
-(void)didClickCancelDateTimePickerView;

@end

@interface SWYDateTimePickerView : UIView

@property (nonatomic, weak) id<SWYDateTimePickerViewDelegate> delegate;
@property (nonatomic, strong) NSString *defaultValue; // 要在datePickerViewMode前面赋值
@property (nonatomic, assign) DatePickerViewMode datePickerViewMode;

-(void)showView;
-(void)hiddenView;

@end
