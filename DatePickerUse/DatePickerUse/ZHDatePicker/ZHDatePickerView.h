//
//  ZHDatePickerView.h
//  dddd
//
//  Created by xyj on 17/2/24.
//  Copyright © 2017年 xyj. All rights reserved.
//

typedef enum {
    DatePicerTypeDefault = 0,
    DatePicerTypeTime = 1,
    DatePicerTypeDateAndTime = 2,
    DatePicerTypeCountDownTimer = 3
}DatePicerType;

#import <UIKit/UIKit.h>

@interface ZHDatePickerView : UIView
//注意:不用考block虑循环引用,内部已经处理
+(void)datePickerViewWithType:(DatePicerType) datePickerType andChoiceBlock: (void (^)(NSDate *choiceDate))choiceBlock;
@end
