//
//  CCUILayoutBaseVC.h
//  CCUILayout
//
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCUILayout_Unit_Header.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCUILayoutBaseVC : UIViewController

/** 暴露给子页面的 views 实例数组 */
@property (nonatomic, strong)NSArray<UIResponder *> * subviews;
/** 布局原型  列表 */
@property(nonatomic,strong)NSMutableArray<CCUILayoutMode*> *dataSourceMode;


/** @open   是否从 _debug 的文件中加载配置
    @edges  mainTab 的四个边距
    MARK:  需要在子类的 init 方法中调用 */
- (void) configUIControlsIsLoadDebug:(BOOL)open mainTabEdges:(UIEdgeInsets)edges;

/** 返回所有的布局 view 类实例 <方便使用场景VC中操作>*/
- (void) wholeUIControls:(void(^)(NSArray<UIResponder*>*,NSMutableArray<CCUILayoutMode*>*))subviews;


/** 页面数据有所变动，及时更新高度布局 */
- (void) updateUIControlHeights:(NSMutableArray<CCUILayoutMode*> *)dataSourceMode;

// MARK: 更新 tableview 布局
- (void)update_TabEdges:(UIEdgeInsets)edges;

// MARK: ———————————— 👇 非主要功能方法  ————————————

/** MARK:  是否开启 分区布局调试 设置<默认关闭> */
- (void) setDebugShowSection:(BOOL)isOpen;

// MARK: ———————————— 👆 非主要功能方法  ————————————

@end

NS_ASSUME_NONNULL_END


