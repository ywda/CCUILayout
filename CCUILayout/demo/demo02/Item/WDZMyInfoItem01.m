//
//  WDZMyInfoItem01.m
//  CCUILayout
//  MARK: 姓名、手机号、邮箱、部门 复用 CELL
//  Created by Admin on 2020/4/30.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "WDZMyInfoItem01.h"

@implementation WDZMyInfoItem01Mode


@end


// MARK: 🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞


@interface WDZMyInfoItem01 ()<UITextFieldDelegate>

/** 左文字 Lab */
@property (nonatomic , strong) UILabel *Lab;
/** 右输入框 TF */
@property (nonatomic , strong) UITextField *TF;

/** 输入文字的 回调*/
@property (nonatomic , copy) CCUILayout_block_str tfBlock;


@end

@implementation WDZMyInfoItem01

- (void) setUpDataAndUi
{
    [self setUpUI];
    [self setUpColor];
//    [self addObserver];
    [self layoutSubviews];
}

- (void) setUpUI
{
    self.Lab= [UILabel new];
    self.TF = [UITextField new];
    self.TF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.TF.textAlignment = NSTextAlignmentRight;
    self.TF.delegate = self;
    [self.TF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self addSubview:self.Lab];
    [self addSubview:self.TF];

    self.Lab.text = @"员工照";
    self.Lab.font = CCUILayout_FONT_PFSC_Regular_14;

}

- (void) setUpColor
{
    self.backgroundColor = IS_OPEN_CCUILayout_DEBUG_COLOR ? CCUILayout_RANDOM_COLOR_LIGHT : CCUILayout_WHITE;
    self.Lab.textColor = CCUILayout_TEXT_COLOR1;
    
    self.Lab.backgroundColor = IS_OPEN_CCUILayout_DEBUG_COLOR ? CCUILayout_RANDOM_COLOR_LIGHT : CCUILayout_CLEAR;
    self.TF.backgroundColor = IS_OPEN_CCUILayout_DEBUG_COLOR ? CCUILayout_RANDOM_COLOR_LIGHT : CCUILayout_CLEAR;
}


- (void) layoutSubviews
{
    [self.Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(80);
    }];
    
    [self.TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.left.equalTo(self.Lab.mas_right).offset(10);
        make.top.mas_equalTo(8);
        make.bottom.mas_equalTo(-8);
    }];
}

- (void) setUpCellWith:(WDZMyInfoItem01Mode*)mode click:(CCUILayout_block_str)block
{
    //...设置更新头像代码...

    
//    self.tfBlock =  ^(){
//        !block?:block();
//    };
}



#pragma mark ————————————————👇 代理方法 ————————————————
// TODO: `return` 回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

// TODO: 文字变化回调
- (void)textFieldDidChange:(UITextField*)textField {
   NSLog(@"%@",[textField text]);
    self.TF.text = [textField text];
//    self.cMode.tfContext = [textField text];
//    [self update_PlaceHolder];
//    if (self.tfBlock) {
//        self.tfBlock([textField text]);
//    }
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (void) setUpCellWithLab:(NSString*)lab
{
    self.Lab.text = lab;
}

@end
