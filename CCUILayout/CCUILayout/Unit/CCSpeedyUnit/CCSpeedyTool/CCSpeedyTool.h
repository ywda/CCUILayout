//
//  CCSpeedyTool.h
//  WDYJForAppStore
//
//  Created by Admin on 2020/2/29.
//  Copyright © 2020 丁侃. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface CCSpeedyTool : NSObject


// TODO: 设置按钮的圆角
/**
 @param anyControl 控件
 @param radius 圆角度
 @param width 边宽度
 @param borderColor 边线颜色
 @param can 是否裁剪
 @return 控件
 */
+ (id)cc_chageControlCircularWith:(id)anyControl
               AndSetCornerRadius:(NSInteger)radius
                   SetBorderWidth:(NSInteger)width
                   SetBorderColor:(UIColor *)borderColor
                 canMasksToBounds:(BOOL)can;

// TODO:快速添加阴影效果
/**
 @param anyControl 控件
 @param opacity 透明度
 @param shadowColor 阴影色
 @param offset 偏移量
 @param radius 圆角值
 **/
+ (void)cc_setUpShadowLayerWithControl:(id)anyControl
                               opacity:(CGFloat)opacity
                                shadow:(UIColor*)shadowColor
                                offSet:(CGSize)offset
                          shadowRadius:(NSInteger)radius;


// TODO: 选取部分数据变色（label）
/**
 @param label label
 @param arrray 变色数组
 @param color 变色颜色
 @return label
 */
+ (id)cc_setSomeOneChangeColor:(UILabel *)label
                SetSelectArray:(NSArray *)arrray
                SetChangeColor:(UIColor *)color;


// TODO:  根据传入字体大小计算字体宽高
+ (CGSize)cc_calculateTextSizeWithText : (NSString *)text
                           WithTextFont: (UIFont*)textFont
                              WithMaxW : (CGFloat)maxW ;

+ (CGSize)cc_calculateTextSizeWithText : (NSString *)text
                           WithTextFont: (UIFont*)textFont
                              WithMaxH : (CGFloat)maxH ;


// TODO: 下划线
/**
 @param view 下划线
 */
+ (void)cc_setUpAcrossPartingLineWith:(UIView *)view
                            WithColor:(UIColor *)color;


// TODO: 竖线线
/**
 @param view 竖线线
 */
+ (void)cc_setUpLongLineWith:(UIView *)view
                   WithColor:(UIColor *)color
              WithHightRatio:(CGFloat)ratio;


// TODO: 利用贝塞尔曲线设置圆角
/**
 @param control 按钮
 @param size 圆角尺寸
 */
+ (void)cc_setUpBezierPathCircularLayerWithControl:(UIButton *)control
                                              size:(CGSize)size;

// TODO: label首行缩进
/**
 @param label label
 @param emptylen 缩进比
 */
+ (void)cc_setUpLabel:(UILabel *)label
              Content:(NSString *)content
IndentationFortheFirstLineWith:(CGFloat)emptylen;

// TODO: 提示框
+ (void)cc_SetUpAlterWithView:(UIViewController *)vc
                      Message:(NSString *)message
                         Sure:(dispatch_block_t)sureBlock
                       Cancel:(dispatch_block_t)cancelBlock;

+ (void)cc_SetUpAlterWithView:(UIViewController *)vc
                      Message:(NSString *)message
                         Sure:(dispatch_block_t)sureBlock;

+ (void)cc_SetUpAlterWithView:(UIViewController *)vc
                      Message:(NSString *)message;

// TODO:触动
+ (void)cc_callFeedback;

/** MARK: 👇 切换动画 <禁止在TableView 的 CELL 上使用,会掉帧> */
+ (void)cc_setInAanimation:(UIView*)view;
+ (void)cc_setInAanimation:(UIView*)view delay:(CGFloat)delay;

/** MARK: 👇 切换动画 <可以在 TableView 的 CELL 上使用,不会掉帧> */
+ (void)cc_setInSlideAanimation:(UIView*)view;
+ (void)cc_setInSlideAanimation:(UIView*)view delay:(CGFloat)delay;

// TODO: 是否是空字符串
+ (BOOL)cc_isEmptyStr:(NSString*)str;

@end

NS_ASSUME_NONNULL_END
