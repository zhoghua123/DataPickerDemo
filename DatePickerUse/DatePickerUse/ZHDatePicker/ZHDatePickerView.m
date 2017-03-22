//
//  ZHDatePickerView.m
//  dddd
//
//  Created by xyj on 17/2/24.
//  Copyright © 2017年 xyj. All rights reserved.
//
#define SCREEN_W [[UIScreen mainScreen] bounds].size.width
#define SCREEN_H [[UIScreen mainScreen] bounds].size.height
#define ZHToolViewHeight     40
#define ZHToolBtnWidth       70
#define ZHPickerViewHeight   200

#import "ZHDatePickerView.h"
static UIView *datePickerView_;
static UIDatePicker *datePicker_;
static void (^choiceBlock_)(NSDate *);

@interface ZHDatePickerView ()

@end
@implementation ZHDatePickerView

+(void)datePickerViewWithType:(DatePicerType)datePickerType andChoiceBlock: (void (^)(NSDate *choiceDate))choiceBlock{
    choiceBlock_ = choiceBlock;
    [ZHDatePickerView setupDatepickerWitHtype:datePickerType];
}
//日期选择器
+(void)setupDatepickerWitHtype:(DatePicerType)dateType{
    //日期选择器
    datePickerView_ = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    datePickerView_.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    [[UIApplication sharedApplication].keyWindow addSubview:datePickerView_];
    //    datePickerView_.hidden = true;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMaskViewAction:)];
    [datePickerView_ addGestureRecognizer:tap];
    
    datePicker_ = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, SCREEN_H, SCREEN_W, ZHPickerViewHeight)];
    datePicker_.backgroundColor = [UIColor whiteColor];
    switch (dateType) {
        case DatePicerTypeDefault:
            datePicker_.datePickerMode = UIDatePickerModeDate;
            break;
        case DatePicerTypeTime:
            datePicker_.datePickerMode = UIDatePickerModeTime;
            break;
        case DatePicerTypeDateAndTime:
            datePicker_.datePickerMode = UIDatePickerModeDateAndTime;
            break;
        case DatePicerTypeCountDownTimer:
            datePicker_.datePickerMode = UIDatePickerModeCountDownTimer;
            break;
        default:
            break;
    }
    
//    datePicker_.maximumDate = [NSDate date];
    [datePickerView_ addSubview:datePicker_];
    
    UIView * toolView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H + ZHToolViewHeight, SCREEN_W, ZHToolViewHeight)];
    toolView.backgroundColor = [UIColor whiteColor];
    [datePickerView_ addSubview:toolView];
    UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancleBtn.frame = CGRectMake(0, 0, ZHToolBtnWidth, ZHToolViewHeight);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:cancleBtn];
    
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmBtn.frame = CGRectMake(SCREEN_W - ZHToolBtnWidth, 0, ZHToolBtnWidth, ZHToolViewHeight);
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:confirmBtn];
    
    //动画的实现
    [UIView animateWithDuration:0.25 animations:^{
        datePicker_.frame = CGRectMake(0, SCREEN_H - ZHPickerViewHeight, SCREEN_W, ZHPickerViewHeight);
        toolView.frame = CGRectMake(0, SCREEN_H - ZHPickerViewHeight - ZHToolViewHeight, SCREEN_W, ZHToolViewHeight);
    }];
}

//点击了背景
+ (void)tapMaskViewAction:(UITapGestureRecognizer *)tap {
    [datePickerView_ removeFromSuperview];
    [ZHDatePickerView deleteAll];
}
//点击了取消
+ (void)cancleBtnAction:(UIButton *)button {
    [datePickerView_ removeFromSuperview];
    [ZHDatePickerView deleteAll];
}
//点击了确定
+ (void)confirmBtnAction:(UIButton *)button {
    [datePickerView_ removeFromSuperview];
    choiceBlock_(datePicker_.date);
    [ZHDatePickerView deleteAll];
}

//删除所有的全局变量,防止循环引用
+(void)deleteAll{
    datePicker_ = nil;
    datePickerView_ = nil;
    choiceBlock_ = nil;
}

@end
