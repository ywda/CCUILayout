//
//  CCUIContainerView.m
//  CCUIContainer
//  MARK: 基础 CELL 类
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerView.h"

@implementation CCUIContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 方法调用
        if([self respondsToSelector:@selector(setUpDataAndUi)]){
             [self setUpDataAndUi];
        }
        
        // 标记 cell
        if(IS_OPEN_CCUIContainer_DEBUG_COLOR){
            self.backgroundColor = CCUIContainer_RANDOM_COLOR_LIGHT;
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
