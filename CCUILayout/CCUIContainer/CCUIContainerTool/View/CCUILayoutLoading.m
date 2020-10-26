
//
//  CCUILayoutLoading.m
//  CCUILayout
//  MARK: 页面中存在费时的绘制UI的时候，加载出页面前的等待状态 封装
//  Created by Admin on 2020/10/24.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutLoading.h"
#import "CCUILayout_Color.h"

@interface CCUILayoutLoading ()

@end

@implementation CCUILayoutLoading

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = CCUILayout_PAGE_BG_COLOR;
        [self setUpUi];
    }
    return self;
}

- (void) setUpUi {}


@end
