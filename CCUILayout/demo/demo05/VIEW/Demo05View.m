//
//  Demo05View.m
//  CCUIContainer
//
//  Created by Admin on 2020/5/18.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "Demo05View.h"
#import "WDZMyInfoItem00.h"

@implementation Demo05View


- (instancetype)init
{
    self = [super init];
    if (self) {
        // MARK: 通过 plist 方法创建 View 中的元素
//       UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
//       [self configUIControlsIsLoadDebug:NO mainTabEdges:insets adapterApp:NO];
//       [self setDebugShowSection:YES];
        
        
        // MARK: 通过实例方法创建 View 中的元素
//        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
//        NSMutableArray *uis = [NSMutableArray array];
//        NSMutableArray *uiMs = [NSMutableArray array];
//        for (int i = 0; i < 5; i++) {
//            // MARK: 模拟传入实例对象值
//            //CCUIContainerView *tmp = [CCUIContainerView new];
//            WDZMyInfoItem00 *tmp = [WDZMyInfoItem00 new];
//            // 不能在这里 为 tmp 中添加子元素 <tmp 是独立封装好的 view 类>
//            [uis addObject:tmp];
//
//            CCUIContainerUiMode *cm = [CCUIContainerUiMode new];
//            cm.height = 60;
//            cm.bind = [[NSNumber alloc] initWithInt:i];
//            [uiMs addObject:cm];
//        }
//
//        [self configUIControls:uis layout:uiMs mainTabEdges:insets];
                
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // MARK: 通过 plist 方法创建 View 中的元素
       UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
       [self configUIControlsIsLoadDebug:NO mainTabEdges:insets adapterApp:NO];
       [self setDebugShowSection:YES];
        
        
        // MARK: 通过实例方法创建 View 中的元素
//        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
//        NSMutableArray *uis = [NSMutableArray array];
//        NSMutableArray *uiMs = [NSMutableArray array];
//        for (int i = 0; i < 5; i++) {
//            // MARK: 模拟传入实例对象值
//            //CCUIContainerView *tmp = [CCUIContainerView new];
//            WDZMyInfoItem00 *tmp = [WDZMyInfoItem00 new];
//            // 不能在这里 为 tmp 中添加子元素 <tmp 是独立封装好的 view 类>
//            [uis addObject:tmp];
//
//            CCUIContainerUiMode *cm = [CCUIContainerUiMode new];
//            cm.height = 60;
//            cm.bind = [[NSNumber alloc] initWithInt:i];
//            [uiMs addObject:cm];
//        }
//
//        [self configUIControls:uis layout:uiMs mainTabEdges:insets];
        
    }
    return self;
}

@end
