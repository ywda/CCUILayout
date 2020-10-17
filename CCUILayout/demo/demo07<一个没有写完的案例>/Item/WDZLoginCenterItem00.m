//
//  WDZLoginCenterItem00.m
//  refactor_LoginCenter
//  MARK: 登录中心 `切换服务器按钮区域` Item
//  Created by Admin on 2020/5/18.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "WDZLoginCenterItem00.h"

@interface WDZLoginCenterItem00 ()

@property(nonatomic,strong) UIButton *switchBtn;

@end

@implementation WDZLoginCenterItem00

- (void)setUpDataAndUi
{
    self.switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.switchBtn];
    self.switchBtn.backgroundColor = CCUILayout_RANDOM_COLOR_LIGHT;
}


- (void)layoutSubviews
{
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(38);
        make.height.mas_equalTo(38*0.618);
    }];
}



@end
