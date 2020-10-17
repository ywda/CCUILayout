//
//  WDZMyInfoItem00.m
//  CCUILayout
//  MARK: 头像、员工照 复用 CELL
//  Created by Admin on 2020/4/30.
//  Copyright © 2020 Admin. All rights reserved.
//


#import "WDZMyInfoItem00.h"

@implementation WDZMyInfoItem00Mode


@end


// MARK: 🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞


@interface WDZMyInfoItem00 ()

/** 最左文字 Lab */
@property (nonatomic , strong) UILabel *Lab1,*Lab2;
/** 中、右图片 Img */
@property (nonatomic , strong) UIImageView *Img1,*Img2;
/** 点击整个 Cell 回调*/
@property (nonatomic , copy) dispatch_block_t click;


@end

@implementation WDZMyInfoItem00

- (void) setUpDataAndUi
{
    [self setUpUI];
    [self setUpColor];
    [self add_Tap];
    [self layoutSubviews];
}

- (void) setUpUI
{
    self.Lab1= [UILabel new];
    self.Lab2= [UILabel new];
    self.Img1 = [UIImageView new];
    self.Img2 = [UIImageView new];
    
    [self addSubview:self.Lab1];
    [self addSubview:self.Lab2];
    [self addSubview:self.Img1];
    [self addSubview:self.Img2];
    
    self.Lab1.text = @"员工照";
    self.Lab1.font = CCUILayout_FONT_PFSC_Regular_14;
    self.Lab2.text = @"上传员工照";
    self.Lab2.font = CCUILayout_FONT_PFSC_Regular_14;
    self.Lab2.textAlignment = NSTextAlignmentRight;
    
    self.Img1.image = [UIImage imageNamed:@"tmpImg"];
    self.Img2.image = [UIImage imageNamed:@"teal"];
    [CCSpeedyTool cc_chageControlCircularWith:self.Img1 AndSetCornerRadius:24 SetBorderWidth:0 SetBorderColor:CCUILayout_CLEAR canMasksToBounds:YES];
    
    // 初始化设置
    self.Img1.alpha = 1;
}

- (void) setUpColor
{
    self.backgroundColor = IS_OPEN_CCUILayout_DEBUG_COLOR?CCUILayout_RANDOM_COLOR_LIGHT:CCUILayout_WHITE;
    self.Lab1.textColor = CCUILayout_TEXT_COLOR1;
    self.Lab2.textColor = CCUILayout_GREEN;
    self.Img1.backgroundColor = IS_OPEN_CCUILayout_DEBUG_COLOR?CCUILayout_RANDOM_COLOR_LIGHT:CCUILayout_CLEAR;
    self.Lab1.backgroundColor = IS_OPEN_CCUILayout_DEBUG_COLOR?CCUILayout_RANDOM_COLOR_LIGHT:CCUILayout_CLEAR;
    self.Img2.backgroundColor = IS_OPEN_CCUILayout_DEBUG_COLOR?CCUILayout_RANDOM_COLOR_LIGHT:CCUILayout_CLEAR;
}

- (void)add_Tap{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickAction)];
    [self addGestureRecognizer:tap];
}

- (void) layoutSubviews
{
    [self.Lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(150);
    }];
    
    [self.Lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.Img2.mas_left).offset(-10);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(120);
    }];
    
    [self.Img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.Img2.mas_left).offset(-10);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(48);
    }];
    
    [self.Img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(13);
    }];
}

- (void) setUpCellWith:(NSString*)imgUrl click:(dispatch_block_t)block
{
    //...设置更新头像代码...
    
    self.Img1.alpha = 0;
    
    self.click =  ^(){
        !block?:block();
    };
}

- (void)tapClickAction{
    !self.click?:self.click();
    NSLog(@"%s", __func__);
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (void) setUpCellWithLab:(NSString*)lab
{
    self.Lab1.text = lab;
}

@end
