//
//  CCUIContainerBaseMode+Scroll.h
//  CCUIContainer
//
//  Created by Admin on 2020/10/24.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerBaseMode.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCUIContainerBaseMode (Scroll)

//@property(nonatomic,assign) CGFloat scrollContainerHeight;

// MARK: 创建 scrollView 的页面元素
- (NSMutableArray<UIResponder *> *) create_SubViewsForScrollView:(UIScrollView*)scrollView;

// MARK: 更新 scrollView 的页面元素
- (void) update_SubViewsForScrollView:(UIScrollView*)scrollView;

// MARK: 更新 scrollView 的页面元素 布局
- (void) layout_SubViewsForScrollView:(UIScrollView*)scrollView;

@end

NS_ASSUME_NONNULL_END
