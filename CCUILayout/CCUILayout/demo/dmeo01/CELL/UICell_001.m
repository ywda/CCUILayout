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
    self.demoLab.text = @"类名：UICell_001 : 描述：我就是一个简单的 CCUILayoutCell 对象";
    self.demoLab.numberOfLines = 0;
    [self.demoLab setFont:[UIFont systemFontOfSize:10 weight:(UIFontWeightLight)]];
    
    [self layoutSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.demoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(4);
        make.bottom.mas_equalTo(-4);
    }];
}


@end
