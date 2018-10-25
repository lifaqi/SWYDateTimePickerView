//
//  ToolKit.h
//  SWYDateTimePickerView
//
//  Created by 淘翼购 on 2018/10/17.
//  Copyright © 2018年 shenwuyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolKit : NSObject

#pragma mark - view
/// 判断UIView是否在滚动
+(BOOL)anySubViewScrolling:(UIView *)view;

#pragma mark - date
/// 获取时间
+(NSDateComponents *)getDate:(NSDate *)date;

/// 获取当前日期,默认格式：yyyy-MM-dd HH:mm:ss
+(NSString *)getCurrentDate;

/// 获取当前日期,自定义格式
+(NSString *)getCurrentDate:(NSString *)dateFormatter;

/// 把日期字符串格式化为日期对象,默认格式：yyyy-MM-dd HH:mm:ss
+(NSDate *)getDateWithDateString:(NSString *)dateString;

/// 把日期字符串格式化为日期对象，自定义格式
+(NSDate *)getDateWithDateString:(NSString *)dateString andDateFormatter:(NSString *)dateFormatter;

/// 把日期对象格式化为日期字符串，自定义格式
+(NSString *)getDateStringWithDate:(NSDate *)date andDateFormatter:(NSString *)dateFormatter;

@end
