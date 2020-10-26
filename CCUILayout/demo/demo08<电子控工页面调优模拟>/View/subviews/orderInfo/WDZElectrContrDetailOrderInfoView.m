//
//  WDZElectrContrDetailOrderInfoView.m
//  CCUIContainer
//
//  Created by Admin on 2020/10/17.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "WDZElectrContrDetailOrderInfoView.h"

@interface WDZElectrContrDetailOrderInfoView ()

@property(nonatomic,strong) UIView *chChild;

@end

@implementation WDZElectrContrDetailOrderInfoView

- (void)setUpDataAndUi {
    
    UILabel * lab = [UILabel new];
    lab.text = @"工单详情";
    lab.font = [UIFont systemFontOfSize:20];
    lab.frame = CGRectMake(10, 10, 200, 30);
    [self addSubview:lab];
    
    self.backgroundColor = CCUIContainer_RANDOM_COLOR_LIGHT;
    
    [self enterOrExitFullAct];
}

- (UIView *)chChild {
    if (!_chChild) {
        _chChild = [UIView new];
        _chChild.backgroundColor = CCUIContainer_RANDOM_COLOR;
    }
    return _chChild;
}

// MARK: 全屏的实现
- (void) enterOrExitFullAct {
    
    self.chChild.frame = CGRectMake(0, 50, 80, 50);
    [self addSubview:self.chChild];
    self.movieView = self.chChild;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chScreenAct)];
    [self.chChild addGestureRecognizer:tap];
}

- (void) chScreenAct {
    
    [self autoEnterOrExitFullscreen];
}

@end
