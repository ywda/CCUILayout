//
//  CCUILayoutCell.h
//  CCUILayout
//  MARK: 基础 CELL 类
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutSuperBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCUILayoutCell : CCUILayoutSuperBaseCell

/** MARK: 模板方法 <子 view 布局,以及初始化> */
- (void)setUpDataAndUi;

@end

NS_ASSUME_NONNULL_END
