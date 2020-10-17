//
//  WDZElectrContrDetailOrderInfoView.m
//  CCUILayout
//
//  Created by Admin on 2020/10/17.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "WDZElectrContrDetailOrderInfoView.h"

@implementation WDZElectrContrDetailOrderInfoView

- (void)setUpDataAndUi {
    
    UILabel * lab = [UILabel new];
    lab.text = @"工单详情";
    lab.font = [UIFont systemFontOfSize:20];
    lab.frame = CGRectMake(10, 10, 200, 30);
    [self addSubview:lab];
    
    self.backgroundColor = CCUILayout_RANDOM_COLOR_LIGHT;
}

@end
