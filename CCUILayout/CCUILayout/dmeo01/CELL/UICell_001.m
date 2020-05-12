//
//  UICell_001.m
//  CCUILayout
//
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "UICell_001.h"
#import "CCUILayout_Unit_Header.h"

@interface UICell_001 ()
@property (nonatomic, strong) UILabel *demoLab;

@end

@implementation UICell_001

-(void)setUpDataAndUi{
    self.demoLab = [UILabel new];
    [self addSubview:self.demoLab];
    [self.demoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.demoLab.text = @"UICell_001 : CCUILayoutBaseCell";
}

@end
