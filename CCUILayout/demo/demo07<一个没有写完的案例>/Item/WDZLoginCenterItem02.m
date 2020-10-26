//
//  WDZLoginCenterItem02.m
//  refactor_LoginCenter
//  MARK: 登录中心 `1、手机号码 2、验证码 3、电话号码/用户名 4、密码` Item
//  Created by Admin on 2020/5/18.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "WDZLoginCenterItem02.h"

@interface WDZLoginCenterItem02 ()

@property(nonatomic,strong) UIView *container;

@end

@implementation WDZLoginCenterItem02

- (void)setUpDataAndUi
{
    self.container = [UIView new];
    [self addSubview:self.container];
    self.container.backgroundColor = CCUIContainer_RANDOM_COLOR_LIGHT;
    
    [CCSpeedyTool cc_chageControlCircularWith:self.container
                           AndSetCornerRadius:2
                               SetBorderWidth:0.75
                               SetBorderColor:CCUIContainer_LGRAY
                             canMasksToBounds:YES];
}

- (void)layoutSubviews
{
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-5);
    }];
}

@end
