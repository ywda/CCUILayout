//
//  CCUILayoutBaseView.m
//  CCUILayout
//
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutBaseView.h"

@implementation CCUILayoutBaseView

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
    }
    return self;
}

-(void)setUpDataAndUi{}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
