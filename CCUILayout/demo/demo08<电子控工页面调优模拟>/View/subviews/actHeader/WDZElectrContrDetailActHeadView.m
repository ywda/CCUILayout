//
//  WDZElectrContrDetailActHeadView.m
//  CCUIContainer
//
//  Created by Admin on 2020/10/17.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "WDZElectrContrDetailActHeadView.h"

@implementation WDZElectrContrDetailActHeadView

- (void)setUpDataAndUi {
    
    UILabel * lab = [UILabel new];
    lab.text = @"信息标签";
    lab.font = [UIFont systemFontOfSize:20];
    lab.frame = CGRectMake(10, 10, 200, 30);
    [self addSubview:lab];
    
    self.backgroundColor = CCUIContainer_RANDOM_COLOR_LIGHT;
}

@end

