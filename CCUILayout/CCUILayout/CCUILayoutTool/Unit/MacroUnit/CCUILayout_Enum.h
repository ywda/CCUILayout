//
//  CCUILayout_Enum.h
//  WDZForAppStore
//
//  Created by Admin on 2020/5/6.
//  Copyright © 2020 Wandianzhang. All rights reserved.
//

#ifndef CCUILayout_Enum_h
#define CCUILayout_Enum_h

// MARK: 通用区别标识 <·用的时候赋予具体含义·>
// ——————————————————————————————————————————
typedef enum : NSUInteger {
    CCUILayoutMaskType0,
    CCUILayoutMaskType1,
    CCUILayoutMaskType2,
    CCUILayoutMaskType3,
    CCUILayoutMaskType4,
    CCUILayoutMaskTypeDef,
} CCUILayout_MaskType;


// MARK: 全屏切换标识 <·页面上局部View需要全屏展示场景下·使用>
// ——————————————————————————————————————————
typedef enum : NSUInteger {
    CCUILayoutViewStateSmall,         // 普通布局<非全屏状态·默认值·>
    CCUILayoutViewStateAnimating,     // 切换全屏状态中...
    CCUILayoutViewStateFullscreen,    // 已处于全屏中
} CCUILayoutViewState;


#endif /* CCUILayout_Enum_h */
