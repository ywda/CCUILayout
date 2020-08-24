//
//  CCUILayoutView.h
//  CCUILayout
//  MARK: 基础 CELL 类
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCUILayout_Unit_Header.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCUILayoutView : UIView

/** view 上绑定的布局配置信息*/
@property (nonatomic, strong) CCUILayoutUiMode * CLM;

// TODO: 模板方法 <子 view 布局,以及初始化>
- (void)setUpDataAndUi;

@end

NS_ASSUME_NONNULL_END
