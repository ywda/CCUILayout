//
//  CCUIContainer_Enum.h
//  WDZForAppStore
//
//  Created by Admin on 2020/5/6.
//  Copyright © 2020 Wandianzhang. All rights reserved.
//

#ifndef CCUIContainer_Enum_h
#define CCUIContainer_Enum_h

// MARK: 通用区别标识 <·用的时候赋予具体含义·>
// ——————————————————————————————————————————
typedef enum : NSUInteger {
    CCUIContainerMaskType0,
    CCUIContainerMaskType1,
    CCUIContainerMaskType2,
    CCUIContainerMaskType3,
    CCUIContainerMaskType4,
    CCUIContainerMaskTypeDef,
} CCUIContainer_MaskType;


// MARK: 元素枚举值
// ——————————————————————————————————————————
typedef enum : NSUInteger {
    
    CCUIContainerElementTypeCell = 1,
    CCUIContainerElementTypeView = 2,
    CCUIContainerElementTypeDebugView = 3,
    CCUIContainerElementTypeUnKonw = -1,

} CCUIContainerElementType;


// MARK: 全屏切换标识 <·页面上局部View需要全屏展示场景下·使用>
// ——————————————————————————————————————————
typedef enum : NSUInteger {
    CCUIContainerViewStateSmall,         // 普通布局<非全屏状态·默认值·>
    CCUIContainerViewStateAnimating,     // 切换全屏状态中...
    CCUIContainerViewStateFullscreen,    // 已处于全屏中
} CCUIContainerViewState;


#endif /* CCUIContainer_Enum_h */
