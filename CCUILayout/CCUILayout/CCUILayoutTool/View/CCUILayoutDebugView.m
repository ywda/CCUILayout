//
//  CCUILayoutDebugView.m
//  CCUILayout
//  MARK: DebugView 类用来展示当前页面元素信息，方便调试
//  FIXME: <高度计算尚有瑕疵，但是基本满足当前需求，后面维护>
//  Created by Admin on 2020/5/15.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutDebugView.h"
#import "CCUILayout_Color.h"
#import "CCUILayout_Font.h"
#import "CCUILayout_Enum.h"
#import <Masonry/Masonry.h>

@interface CCUILayoutDebugView ()

@property(nonatomic,strong) UILabel *Lab;

@end

@implementation CCUILayoutDebugView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = CCUILayout_BLACK;
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
    self.Lab.textColor = CCUILayout_WHITE;
    [self addSubview:self.Lab];
    self.Lab.backgroundColor = CCUILayout_BLACK;
    
    self.Lab.font = CCUILayout_FONT_PFSC_Regular_(12);
}

- (void) layoutSubviews
{
    
    [self.Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
    }];
    
    self.backgroundView.backgroundColor = CCUILayout_BLACK;
}

- (void)setWithElementInfo:(CCUILayoutDebugUiMode *)mode
{
    
    self.Lab.text = mode.desc;
    // 微调效果
    [self.Lab setAdjustsFontSizeToFitWidth:YES];
}

// 设置背景色
- (void) setWithElementInfoColor:(UIColor *)color
{
    self.Lab.backgroundColor = color;
    self.backgroundColor = color;
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
