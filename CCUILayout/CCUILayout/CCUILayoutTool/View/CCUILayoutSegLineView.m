//
//  CCUILayoutSegLineView.m
//  WDZForAppStore
//  MARK: 常用的基础分割线
//  Created by Admin on 2020/9/3.
//  Copyright © 2020 Wandianzhang. All rights reserved.
//

#import "CCUILayoutSegLineView.h"

@implementation CCUILayoutSegLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 方法调用
        if([self respondsToSelector:@selector(setUpDataAndUi)]){
             [self setUpDataAndUi];
        }
        // 标记 cell
        if(IS_OPEN_CCUILayout_DEBUG_COLOR){
            self.backgroundColor = CCUILayout_RANDOM_COLOR_LIGHT;
        }
        self.backgroundColor = CCUILayout_PAGE_BG_COLOR;
    }
    return self;
}

-(void)setUpDataAndUi{}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
