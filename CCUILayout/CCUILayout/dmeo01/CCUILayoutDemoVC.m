//
//  CCUILayoutDemoVC.m
//  CCUILayout
//
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutDemoVC.h"

@implementation CCUILayoutDemoVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUIControlsIsLoadDebug:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /** MARK: 返回所有的布局 view 类实例 <方便使用场景VC中操作>*/
    [self wholeUIControls:^(NSArray<UIResponder *> * subviews, NSMutableArray<CCUILayoutMode *> * subviewModes) {
        NSLog(@"uis = %@ -- 子视图的个数 %ld",subviews,subviews.count);
    }];
    
    [self setDebugShowSection:YES];
}


@end
