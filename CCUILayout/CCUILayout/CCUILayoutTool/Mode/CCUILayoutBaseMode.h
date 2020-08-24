//
//  CCUILayoutBaseMode.h
//  CCUILayout
//  MARK: 某个 BaseVC BaseTabVC 页面、BaseView 控制的的 UiMode
//  Created by Admin on 2020/5/17.
//  Copyright © 2020 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCUILayout_Unit_Header.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCUILayoutBaseMode : NSObject


// TODO: ———————————— 👇 属性相关 ————————————

/** 布局原型  列表 */
@property(nonatomic,strong)NSMutableArray<CCUILayoutUiMode*> *dbMode;
/** 处理后的展示的 view  列表 */
@property(nonatomic,strong)NSMutableArray<UIResponder*> *dbUi;
/** 注册防止重用的 reuseIdentifier  列表 */
@property(nonatomic,strong)NSMutableArray<NSString*> *reuseIdentifiers;
/** Element View 描述说明数组 */
@property(nonatomic,strong)NSArray<CCUILayoutDebugViewMode*> *dbElementNotes;
/** tableView 的四周边距 */
@property(nonatomic)UIEdgeInsets edges;

/** 是否开启调试分区开关 */
@property(nonatomic,assign) BOOL isDebugShowSection;
/** 初始化 subviews 完成后进行数据回调 */
@property(nonatomic,copy) void (^uisubviewsRb)(NSArray<UIResponder*>*,NSMutableArray<CCUILayoutUiMode*>*);
/** 点击的 cell、view 元素下标 回调*/
@property(nonatomic,copy) void(^clickElementRb)(UIResponder*,CCUILayoutUiMode*,NSInteger);



// TODO: ———————————— 👇 方法相关 ————————————

// MARK: 创建 TableView 的页面元素
- (void) create_SubViewsFor:(UITableView*)tableView;

// MARK: 注册 CELL 重用标识
- (void) register_Cell_ReuseIdentifierFor:(UITableView*)tableView;

// MARK: 注册 TabHeader 重用标识
- (void) register_TabHeader_ReuseIdentifierFor:(UITableView*)tableView;

// MARK: 获取 重用 CELL 元素类型
- (CCUILayout_MaskType) classifiedUiControlsBy:(NSString *) className;

// MARK: cellForRowAtIndexPath 方法内部的逻辑转移
- (UITableViewCell *)getTableView:(UITableView *)tableView
            cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
