//
//  CCUILayoutDebugView.h
//  CCUILayout
//  MARK: DebugView 类用来展示当前页面元素信息，方便调试
//  FIXME: <高度计算尚有瑕疵，但是基本满足当前需求，后面维护>
//  Created by Admin on 2020/5/15.
//  Copyright © 2020 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCUILayoutDebugUiMode.h"


NS_ASSUME_NONNULL_BEGIN

@interface CCUILayoutDebugView : UITableViewHeaderFooterView

- (void) setWithElementInfo:(CCUILayoutDebugUiMode*)mode;

// MARK: 加载的 CCUILayoutBaseView 对象可能属于 CCUILayoutBaseVC、CCUILayoutBaseTabVC 的子类对象，区别描述区域，建议设置为`红色`
- (void) setWithElementInfoColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
