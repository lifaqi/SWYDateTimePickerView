//
//  ToolKit.m
//  SWYDateTimePickerView
//
//  Created by 淘翼购 on 2018/10/17.
//  Copyright © 2018年 shenwuyue. All rights reserved.
//

#import "ToolKit.h"

@implementation ToolKit

#pragma mark - view
+(BOOL)anySubViewScrolling:(UIView *)view{
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)view;
        if (scrollView.dragging || scrollView.decelerating) {
            return YES;
        }
    }
    for (UIView *theSubView in view.subviews) {
        if ([self anySubViewScrolling:theSubView]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - date

+(NSDateComponents *)getDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    
    return comps;
}

// 获取当前日期,默认格式：yyyy-MM-dd HH:mm:ss
+(NSString *)getCurrentDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter stringFromDate:[[NSDate alloc] init]];
}

// 获取当前日期,自定义格式
+(NSString *)getCurrentDate:(NSString *)dateFormatter{
    NSDateFormatter *mDateFormatter = [[NSDateFormatter alloc] init];
    mDateFormatter.dateFormat = dateFormatter;
    return [mDateFormatter stringFromDate:[[NSDate alloc] init]];
}

// 把日期字符串格式化为日期对象,默认格式：yyyy-MM-dd HH:mm:ss
+(NSDate *)getDateWithDateString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter dateFromString:dateString];
}

// 把日期字符串格式化为日期对象，自定义格式
+(NSDate *)getDateWithDateString:(NSString *)dateString andDateFormatter:(NSString *)dateFormatter{
    NSDateFormatter *dateFormatterTemp = [[NSDateFormatter alloc] init];
    dateFormatterTemp.dateFormat = dateFormatter;
    return [dateFormatterTemp dateFromString:dateString];
}

// 把日期对象格式化为日期字符串，自定义格式
+(NSString *)getDateStringWithDate:(NSDate *)date andDateFormatter:(NSString *)dateFormatter{
    NSDateFormatter *dateFormatterTemp = [[NSDateFormatter alloc] init];
    dateFormatterTemp.dateFormat = dateFormatter;
    return [dateFormatterTemp stringFromDate:date];
}

@end
