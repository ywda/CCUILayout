//
//  WDZLoginCenterItem01.m
//  refactor_LoginCenter
//  MARK: 登录中心 `App Logo` Item
//  Created by Admin on 2020/5/18.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "WDZLoginCenterItem01.h"

@interface WDZLoginCenterItem01 ()

@property(nonatomic,strong) UIImageView *appLogo;

@end

@implementation WDZLoginCenterItem01

- (void)setUpDataAndUi
{
    self.appLogo = [UIImageView new];
    [self addSubview:self.appLogo];
    self.appLogo.backgroundColor = CCUILayout_DEBUG_RANDOM_COLOR;
}

- (void)layoutSubviews
{
    [self.appLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100*0.618);
    }];
}


@end
