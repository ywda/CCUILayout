//
//  WDZElectrContrDetailVedioHandleView.m
//  CCUIContainer
//
//  Created by Admin on 2020/10/17.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "WDZElectrContrDetailVedioHandleView.h"


@interface WDZElectrContrDetailVedioHandleView ()

@property(nonatomic,copy) void(^rbAct) (BOOL);
@property(nonatomic,assign) BOOL tapBool;

@end

@implementation WDZElectrContrDetailVedioHandleView

- (void)setUpDataAndUi {
    
    UILabel * lab = [UILabel new];
    lab.text = @"播放器控制处理";
    lab.font = [UIFont systemFontOfSize:20];
    lab.frame = CGRectMake(10, 10, 200, 30);
    [self addSubview:lab];
    
    
    self.tapBool = NO;
    self.backgroundColor = CCUIContainer_RANDOM_COLOR_LIGHT;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.tapBool = !self.tapBool;
    !self.rbAct?:self.rbAct(self.tapBool);
}

- (void) updateWithRb:(void(^)(BOOL)) isHaveBarRb {
    self.rbAct = ^(BOOL value) {
        isHaveBarRb(value);
    };
}

@end

