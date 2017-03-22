//
//  ViewController.m
//  DatePickerUse
//
//  Created by xyj on 17/3/22.
//  Copyright © 2017年 xyj. All rights reserved.
//

#import "ViewController.h"
#import "ZHDatePickerView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ViewController
- (IBAction)datePickerAction:(id)sender {
    
    [ZHDatePickerView datePickerViewWithType:DatePicerTypeDefault andChoiceBlock:^(NSDate *choiceDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *DateString = [dateFormatter stringFromDate:choiceDate];
        self.dateLabel.text = DateString;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
