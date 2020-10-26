//
//  CCUIContainerDebugView.m
//  CCUIContainer
//  MARK: DebugView 类用来展示当前页面元素信息，方便调试
//  FIXME: <高度计算尚有瑕疵，但是基本满足当前需求，后面维护>
//  Created by Admin on 2020/5/15.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerDebugView.h"
#import "CCUIContainer_Color.h"
#import "CCUIContainer_Font.h"
#import "CCUIContainer_Enum.h"
#import <Masonry/Masonry.h>

@interface CCUIContainerDebugView ()

@property(nonatomic,strong) UIView *container;
@property(nonatomic,strong) UILabel *Lab;

@end

@implementation CCUIContainerDebugView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self setUpDataAndUi];
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpDataAndUi];
    }
    return self;
}

- (void) setUpDataAndUi
{
    
    self.Lab = [UILabel new];
    self.Lab.numberOfLines = 0;
    self.Lab.textColor = CCUIContainer_WHITE;
    self.Lab.font = CCUIContainer_FONT_PFSC_Regular_(12);
    
    self.Lab.backgroundColor = CCUIContainer_BLACK;
    
    self.container = [UIView new];
    [self addSubview:self.container];
    self.container.backgroundColor = CCUIContainer_BLACK;
    
    [self addSubview:self.Lab];
    [self sendSubviewToBack:self.container];
}


- (void) layoutSubviews
{
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    [self.Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
    }];
    
    self.backgroundView.backgroundColor = CCUIContainer_BLACK;
    self.container.backgroundColor = CCUIContainer_BLACK;
}

- (void)setWithElementInfo:(CCUIContainerDebugUiMode *)mode
{
    self.linkCLM = mode.linkCLM;
    self.Lab.text = mode.desc;
    // 微调效果
    [self.Lab setAdjustsFontSizeToFitWidth:YES];
}

// 设置背景色
- (void) setWithElementInfoColor:(UIColor *)color
{
    self.Lab.backgroundColor = color;
    self.backgroundColor = color;
    self.container.backgroundColor = color;
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
