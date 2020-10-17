//
//  WDZElectrContrDetailVedioBarView.m
//  CCUILayout
//
//  Created by Admin on 2020/10/17.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "WDZElectrContrDetailVedioBarView.h"
#import "CCUITimeChLine.h"


@interface WDZElectrContrDetailVedioBarView ()

@property(nonatomic,strong) CCUITimeChLine *chTimeLine;

@end

@implementation WDZElectrContrDetailVedioBarView

- (CCUITimeChLine *)chTimeLine {
    if (!_chTimeLine) {
        _chTimeLine = [CCUITimeChLine new];
        [_chTimeLine setChStepType:(CCUITimeChStepTypeMin)];
    }
    return _chTimeLine;
}

- (void)setUpDataAndUi {
    
    UILabel * lab = [UILabel new];
    lab.text = @"视频进度条";
    lab.font = [UIFont systemFontOfSize:20];
    lab.frame = CGRectMake(10, 10, 200, 30);
    [self addSubview:lab];
    
    self.backgroundColor = CCUILayout_RANDOM_COLOR_LIGHT;
    
    
    self.chTimeLine.frame = CGRectMake(0, 50, UIScreen.mainScreen.bounds.size.width, 90);
    [self addSubview:self.chTimeLine];
}

@end

