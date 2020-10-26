//
//  CCUIContainerBaseMode.h
//  CCUIContainer
//  MARK: 某个 BaseVC BaseTabVC 页面、BaseView 控制的的 UiMode
//  Created by Admin on 2020/5/17.
//  Copyright © 2020 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCUIContainerDebugUiMode.h"
#import "CCUIContainerUiMode.h"
#import "CCUIContainerDebugView.h"
#import "CCUIContainer_Enum.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCUIContainerBaseMode : NSObject


// MARK: ———————————— 👇 属性相关 ————————————

@property(nonatomic) CGFloat containerHeight;

/** 布局原型  列表 */
@property(nonatomic,strong)NSMutableArray<CCUIContainerUiMode*> *dbMode;
/** 处理后的展示的 view  列表 */
@property(nonatomic,strong)NSMutableArray<UIResponder*> *dbUi;
/** Element 对应的 日志Uis 数组 */
@property(nonatomic,strong)NSMutableArray<CCUIContainerDebugView*> *dbNoteUis;
/** Element 对应的 日志Uim 数组 */
@property(nonatomic,strong)NSMutableArray<CCUIContainerDebugUiMode*> *dbNoteUims;
/** tableView 的四周边距 */
@property(nonatomic)UIEdgeInsets edges;

/** 是否开启调试分区开关 */
@property(nonatomic,assign) BOOL showDebugTag;
/** 初始化 subviews 完成后进行数据回调 */
@property(nonatomic,copy) void (^uisubviewsRb)(NSArray<UIResponder*>*,NSMutableArray<CCUIContainerUiMode*>*);
/** 点击的 cell、view 元素下标 回调*/
@property(nonatomic,copy) void(^clickElementRb)(UIResponder*,CCUIContainerUiMode*,NSInteger);
/** 页面容器的 contentSizeH 值实时回调*/
@property(nonatomic,copy) void(^contentSizeHeightRb)(CGFloat);


// MARK: ———————————— 👇 方法相关 ————————————

// MARK: 获取 Element 元素类型
- (CCUIContainerElementType) classifiedUiControlsBy:(NSString *) className;

// MARK: 获取 所有·非日志·部分的总体高度
- (CGFloat) getTotalHeightsFromElementsdb;

// MARK: 获取 所有·日志·部分的总体高度
- (CGFloat) getTotalHeightsFromElementNotesdb;

// MARK: 回调·容器总体·含有日志的总体高度值
- (void) rbContainerHeightFor:(void(^)(CGFloat)) totalHeightRb;

// MARK: 更新与改变日志部分的 ui\uim 数据源
- (void)setShowDebugTag:(BOOL)showDebugTag;

// MARK: 获取日志部分的 uim 数据源
- (void) getElementNotesUimsFromSelf;


@end

NS_ASSUME_NONNULL_END
