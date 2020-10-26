//
//  CCImg_FL_LabBtn.h
//  WDYJForAppStore
//
//  Created by Admin on 2020/3/2.
//  Copyright © 2020 丁侃. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 图标在上，文本在下按钮的图文间隔比例（0-1），默认0.8 */
#define fl_buttonTopRadio 0.8
/** 图标在下，文本在上按钮的图文间隔比例（0-1），默认0.5 */
#define fl_buttonBottomRadio 0.5


typedef enum{
    FLAlignmentStatusNormal,    //左图标右文本 居中显示
    FLAlignmentStatusImageLeft, //左图标右文本(靠左显示)
    FLAlignmentStatusLeft,      // 左文本右图标 靠左显示
    FLAlignmentStatusCenter,    // 左文本右图标 居中显示
    FLAlignmentStatusRight,     // 左文本右图标 靠右显示
    FLAlignmentStatusTop,       // 图标在上，文本在下(居中)
    FLAlignmentStatusBottom,    // 图标在下，文本在上(居中)
}FLAlignmentStatus;



NS_ASSUME_NONNULL_BEGIN

@interface CCImg_FL_LabBtn : UIButton

/** 外界通过设置按钮的 status 属性，创建不同类型的按钮 */
@property (nonatomic,assign)FLAlignmentStatus status;
/** 图标与文字之间的间距 */
@property (nonatomic,assign)CGFloat fl_padding;

+ (instancetype)fl_shareButton;

- (instancetype)initWithAlignmentStatus:(FLAlignmentStatus)status;

@end

NS_ASSUME_NONNULL_END
