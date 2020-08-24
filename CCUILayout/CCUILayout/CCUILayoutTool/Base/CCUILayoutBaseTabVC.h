//
//  CCUILayoutBaseTabVC.h
//  CCUILayout
//  MARK: 布局页面工具 CCUILayoutBaseTabVC 类
//  Created by Admin on 2020/5/6.
//  Copyright © 2020 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCUILayout_Unit_Header.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCUILayoutBaseTabVC : UITableViewController

/** 暴露给子页面的 views 实例数组 */
@property (nonatomic, strong)NSArray<UIResponder *> * subviews;
/** 布局原型  列表 */
@property(nonatomic,strong)NSMutableArray<CCUILayoutUiMode*> *subviewModes;

/** MARK: 初始化方法一：从 plist 配置中加载
    @isDebug   是否从 _debug 的文件中加载配置
    @edges  mainTab 的四个边距
    @isAdapter 是否适配定制版本的App页面 <务必注意：在没有做定制化的时候，一定要传 NO>
    MARK:  需要在子类的 init 方法中调用 */
- (void) configUIControlsIsLoadDebug:(BOOL)isDebug
                        mainTabEdges:(UIEdgeInsets)edges
                          adapterApp:(BOOL)isAdapter;


/** MARK: 初始化方法二：从传入的实例对象创建加载
    @subUis   创建的实例对象<视为VC上的某区域的元素数组>
    @subLModes   创建的实例对象的相关配置参数数组 <CCUILayoutUiMode 的 bind、height 为必设值、desc 可以设值、其余则无须设值, bind  值为负数则视为分割线等级次要元素>
    @edges  mainTab 的 contentInset 一般设置为 UIEdgeInsetsZero <通常来控制 tab 的top、bottom 的边距>;
    MARK:  需要在子类的 init 方法中调用 */
- (void) configUIControls:(NSArray<UIResponder *> *)subUis
                   layout:(NSArray<CCUILayoutUiMode*> *)subLModes
             mainTabEdges:(UIEdgeInsets)edges;

/** MARK: 返回所有的布局 view 类实例 <方便使用场景VC中操作>*/
- (void) wholeUIControls:(void(^)(NSArray<UIResponder*>*,NSMutableArray<CCUILayoutUiMode*>*))subviews;

/** MARK: 返回用户点击 cell、view 元素的下标<某些场景可能有用>
    @reback 参数说明 ui 一条布局单位<cell或view> ；uim 是ui的mode ；index 是ui 在 uis 数组中的下标<并不是bind值>
 */
- (void) getUIControlsTouchIndex:(void(^)(UIResponder *ui,CCUILayoutUiMode *uim,NSInteger index))reback;

/** MARK: 页面数据有所变动，及时更新页面布局 */
- (void) updateUIControls:(NSMutableArray<CCUILayoutUiMode*> *)subviewModes;

/** MARK: 是否开启 分区布局调试 设置<默认关闭> */
- (void) setDebugShowSection:(BOOL)isOpen;


@end

NS_ASSUME_NONNULL_END


