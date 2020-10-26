//
//  UIView_001.m
//  CCUIContainer
//
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "UIView_001.h"
#import "CCUIContainer_Unit_Header.h"

@interface UIView_001 ()
@property (nonatomic, strong) UILabel *demoLab;

@end

@implementation UIView_001

-(void)setUpDataAndUi {
    
    self.demoLab = [UILabel new];
    [self addSubview:self.demoLab];
    [self.demoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.demoLab.text = @"UIView_001 : CCUIContainerView";
    
    self.backgroundColor = UIColor.redColor;
}

@end
