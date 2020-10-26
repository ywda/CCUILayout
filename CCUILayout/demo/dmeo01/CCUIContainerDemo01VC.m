//
//  CCUIContainerDemo01VC.m
//  CCUIContainer
//  MARK: 模拟从plist快速创建 页面 demo 父类 CCUIContainerBaseTabVC
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerDemo01VC.h"

@implementation CCUIContainerDemo01VC

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUIControlsIsLoadDebug:NO mainTabEdges:UIEdgeInsetsZero adapterApp:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /** MARK: 返回所有的布局 view 类实例 <方便使用场景VC中操作>*/
    [self wholeUIControls:^(NSArray<UIResponder *> * subviews, NSMutableArray<CCUIContainerUiMode *> * cc_subviewModes) {
        NSLog(@"uis = %@ -- 子视图的个数 %ld",subviews,subviews.count);
    }];
    
    [self setShowNoteView:YES];
    
}


@end
