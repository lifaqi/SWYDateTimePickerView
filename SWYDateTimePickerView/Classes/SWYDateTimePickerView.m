//
//  SWYDateTimePickerView.m
//  SWYDateTimePickerView
//
//  Created by 淘翼购 on 2018/10/8.
//  Copyright © 2018年 shenwuyue. All rights reserved.
//

#import "SWYDateTimePickerView.h"
#import "CommonDef.h"
#import "ToolKit.h"
#import "UIView+Category.h"

@interface SWYDateTimePickerView()<UIPickerViewDataSource, UIPickerViewDelegate>{
    NSInteger yearRange;
    NSInteger dayRange;
    NSInteger startYear;
    NSInteger selectedYear;
    NSInteger selectedMonth;
    NSInteger selectedDay;
    NSInteger selectedHour;
    NSInteger selectedMinute;
    NSInteger selectedSecond;
    NSString *selectStr;
}

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *chooseButton;

@end

@implementation SWYDateTimePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.alpha = 0;
        [self addTarget:self action:@selector(clickViewEvent)];
        
        [self initView];
        
        [self initData];
    }
    return self;
}

#pragma mark - initView
-(void)initView{
    // contentView
    [self addSubview:self.contentView];
    // topView
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    topView.backgroundColor = [UIColor whiteColor];
//    [topView addTarget:self action:@selector(clickTopViewEvent)];
    [_contentView addSubview:topView];
    // cancelButton
    [topView addSubview:self.cancelButton];
    // chooseButton
    [topView addSubview:self.chooseButton];
    // splitView
    UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, ScreenWidth, 0.5)];
    splitView.backgroundColor = [UIColor colorWithRed:247/255. green:247/255. blue:247/255. alpha:1];
    [topView addSubview:splitView];
    // pickerView
    [_contentView addSubview:self.pickerView];
}

#pragma mark - initData
-(void)initData{
    NSCalendar *carlendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger currentYear = [carlendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    startYear = currentYear - 15;
    yearRange = 50;
}

-(void)setDatePickerViewMode:(DatePickerViewMode)datePickerViewMode{
    _datePickerViewMode = datePickerViewMode;
    if(_defaultValue == nil){
        [self setCurrentDate:[NSDate date]];
    }else{
        [self setCurrentDate:[ToolKit getDateWithDateString:_defaultValue andDateFormatter:@"HH:mm"]];
    }
}

#pragma mark - lazy loading
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 220)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, 180)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(12, 0, 40, 40)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [UIColor clearColor];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelButton setTitleColor:[UIColor colorWithRed:65/255. green:139/255. blue:237/255. alpha:1] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(clickCancelButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(UIButton *)chooseButton{
    if (!_chooseButton) {
        _chooseButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 52, 0, 40, 40)];
        [_chooseButton setTitle:@"确定" forState:UIControlStateNormal];
        _chooseButton.backgroundColor = [UIColor clearColor];
        _chooseButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_chooseButton setTitleColor:[UIColor colorWithRed:65/255. green:139/255. blue:237/255. alpha:1] forState:UIControlStateNormal];
        [_chooseButton addTarget:self action:@selector(clickChooseButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseButton;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.datePickerViewMode == DatePickerViewModeDateTime) {
        return 5;
    }else if (self.datePickerViewMode == DatePickerViewModeDate){
        return 3;
    }else if (self.datePickerViewMode == DatePickerViewModeTime){
        return 2;
    }
    
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.datePickerViewMode == DatePickerViewModeDateTime) {
        switch (component) {
            case 0:{
                return yearRange;
            }
                break;
            case 1:{
                return 12;
            }
                break;
            case 2:{
                return dayRange;
            }
                break;
            case 3:{
                return 24;
            }
                break;
            case 4:{
                return 60;
            }
                break;
            default:
                break;
        }
    }else if (self.datePickerViewMode == DatePickerViewModeDate){
        switch (component) {
            case 0:{
                return yearRange;
            }
                break;
            case 1:{
                return 12;
            }
                break;
            case 2:{
                return dayRange;
            }
                break;
            default:
                break;
        }
    }else if (self.datePickerViewMode == DatePickerViewModeTime){
        switch (component) {
            case 0:{
                return 24;
            }
                break;
            case 1:{
                return 60;
            }
                break;
            default:
                break;
        }
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth * component / 6.0, 0, ScreenWidth / 6.0, 30)];
    label.font = [UIFont systemFontOfSize:15.0];
    label.tag = component * 10000 + row;
    label.textAlignment = NSTextAlignmentCenter;
    if (self.datePickerViewMode == DatePickerViewModeDateTime) {
        switch (component) {
            case 0:{
                label.text = [NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
            }
                break;
            case 1:{
                label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
            }
                break;
            case 2:{
                
                label.text=[NSString stringWithFormat:@"%ld日",(long)row+1];
            }
                break;
            case 3:{
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld时",(long)row];
            }
                break;
            case 4:{
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld分",(long)row];
            }
                break;
            case 5:{
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld秒",(long)row];
            }
                break;
            default:
                break;
        }
    }else if (self.datePickerViewMode == DatePickerViewModeDate){
        switch (component) {
            case 0:{
                label.text = [NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
            }
                break;
            case 1:{
                label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
            }
                break;
            case 2:{
                
                label.text=[NSString stringWithFormat:@"%ld日",(long)row+1];
            }
                break;
            default:
                break;
        }
    }else if (self.datePickerViewMode == DatePickerViewModeTime){
        switch (component) {
            case 0:{
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld时",(long)row];
            }
                break;
            case 1:{
                label.textAlignment=NSTextAlignmentRight;
                label.text=[NSString stringWithFormat:@"%ld分",(long)row];
            }
                break;
            default:
                break;
        }
    }
    return label;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (self.datePickerViewMode == DatePickerViewModeDateTime) {
        return ([UIScreen mainScreen].bounds.size.width-40) / 5;
    }else if (self.datePickerViewMode == DatePickerViewModeDate){
        return ([UIScreen mainScreen].bounds.size.width-40) / 3;
    }else if (self.datePickerViewMode == DatePickerViewModeTime){
        return ([UIScreen mainScreen].bounds.size.width-40) / 2;
    }
    return 0;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.datePickerViewMode == DatePickerViewModeDateTime) {
        switch (component) {
            case 0:{
                selectedYear=startYear + row;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 1:{
                selectedMonth=row+1;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 2:{
                selectedDay=row+1;
            }
                break;
            case 3:{
                selectedHour=row;
            }
                break;
            case 4:{
                selectedMinute=row;
            }
                break;
                
            default:
                break;
        }
        
        selectStr =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld",selectedYear,selectedMonth,selectedDay,selectedHour,selectedMinute];
    }else if (self.datePickerViewMode == DatePickerViewModeDate){
        switch (component) {
            case 0:{
                selectedYear=startYear + row;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
            }
                break;
            case 1:{
                selectedMonth=row+1;
                dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
                [self.pickerView reloadComponent:2];
            }
                break;
            case 2:{
                selectedDay=row+1;
            }
                break;
                
            default:
                break;
        }
        
        selectStr =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld",selectedYear,selectedMonth,selectedDay];
    }else if (self.datePickerViewMode == DatePickerViewModeTime){
        switch (component) {
            case 0:{
                selectedHour=row;
            }
                break;
            case 1:{
                selectedMinute=row;
            }
                break;
                
            default:
                break;
        }
        
        selectStr =[NSString stringWithFormat:@"%.2ld:%.2ld",selectedHour,selectedMinute];
    }
}

#pragma mark - func
-(void)showView{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        _contentView.frame = CGRectMake(0, ScreenHeight - 220, ScreenWidth, 220);
    }];
}

-(void)hiddenView{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        _contentView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 220);
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 220);
    }];
}

-(void)clickCancelButtonEvent{
    [self hiddenView];
}

-(void)clickChooseButtonEvent{
    if (![ToolKit anySubViewScrolling:_pickerView]) {
        if ([self.delegate respondsToSelector:@selector(didClickFinishDateTimePickerView:)]) {
            [self.delegate didClickFinishDateTimePickerView:selectStr];
        }
        
        [self hiddenView];
    }
}

-(NSInteger)isAllDay:(NSInteger)year andMonth:(NSInteger)month{
    int day=0;
    switch(month){
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            day=31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            day=30;
            break;
        case 2:{
            if(((year%4==0)&&(year%100!=0))||(year%400==0)){
                day=29;
                break;
            }else{
                day=28;
                break;
            }
        }
        default:
            break;
    }
    return day;
}

-(void)setCurrentDate:(NSDate *)currentDate{
    NSDateComponents *comps = [ToolKit getDate:currentDate];
    
    NSInteger year=[comps year];
    NSInteger month=[comps month];
    NSInteger day=[comps day];
    NSInteger hour=[comps hour];
    NSInteger minute=[comps minute];
    
    selectedYear=year;
    selectedMonth=month;
    selectedDay=day;
    selectedHour=hour;
    selectedMinute=minute;
    
    dayRange=[self isAllDay:year andMonth:month];
    
    if (self.datePickerViewMode == DatePickerViewModeDateTime) {
        [self.pickerView selectRow:year-startYear inComponent:0 animated:NO];
        [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
        [self.pickerView selectRow:day-1 inComponent:2 animated:NO];
        [self.pickerView selectRow:hour inComponent:3 animated:NO];
        [self.pickerView selectRow:minute inComponent:4 animated:NO];
        
        [self pickerView:self.pickerView didSelectRow:year-startYear inComponent:0];
        [self pickerView:self.pickerView didSelectRow:month-1 inComponent:1];
        [self pickerView:self.pickerView didSelectRow:day-1 inComponent:2];
        [self pickerView:self.pickerView didSelectRow:hour inComponent:3];
        [self pickerView:self.pickerView didSelectRow:minute inComponent:4];
        
        
    }else if (self.datePickerViewMode == DatePickerViewModeDate){
        [self.pickerView selectRow:year-startYear inComponent:0 animated:NO];
        [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
        [self.pickerView selectRow:day-1 inComponent:2 animated:NO];
        
        [self pickerView:self.pickerView didSelectRow:year-startYear inComponent:0];
        [self pickerView:self.pickerView didSelectRow:month-1 inComponent:1];
        [self pickerView:self.pickerView didSelectRow:day-1 inComponent:2];
    }else if (self.datePickerViewMode == DatePickerViewModeTime){
        [self.pickerView selectRow:hour inComponent:0 animated:NO];
        [self.pickerView selectRow:minute inComponent:1 animated:NO];
        
        [self pickerView:self.pickerView didSelectRow:hour inComponent:0];
        [self pickerView:self.pickerView didSelectRow:minute inComponent:1];
    }
    
    [self.pickerView reloadAllComponents];
}

-(void)clickViewEvent{
    [self hiddenView];
}

-(void)clickTopViewEvent{
    
}

@end
