//
//  UIView_000.m
//  CCUIContainer
//
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "UIView_000.h"
#import "CCUIContainer_Unit_Header.h"

@interface UIView_000 ()
@property (nonatomic, strong) UILabel *demoLab;

@end

@implementation UIView_000

-(void)setUpDataAndUi{
    self.demoLab = [UILabel new];
    [self addSubview:self.demoLab];
    [self.demoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.demoLab.text = @"UIView_000 : UIView";
    
    self.backgroundColor = UIColor.redColor;
}

@end
