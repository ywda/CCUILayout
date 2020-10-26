//
//  CCUIContainerSuperBaseView.h
//  WDZForAppStore
//  MARK: 超级 View <一些公用的处理父类实现>
//  Created by Admin on 2020/9/5.
//  Copyright © 2020 Wandianzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCUIContainerUiMode.h"
#import "CCUIContainer_Enum.h"
#import "CCUIContainer_Font.h"
#import "CCUIContainer_Color.h"
#import "CCUIContainer_Debug.h"
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCUIContainerSuperBaseView : UIView

@property (nonatomic, strong) CCUIContainerUiMode * CLM;
/** 能够全屏的 容器 */
@property (nonatomic, strong) UIView *movieView;
/** 是否全屏的 状态回调 */
@property (nonatomic, copy) void(^chUiLayoutRb)(CCUIContainerViewState);

// MARK: 进入全屏
- (void) enterFullscreen;

// MARK: 退出全屏
- (void) exitFullscreen;

// MARK: 自动切换全屏-非全屏
- (void) autoEnterOrExitFullscreen;

@end

NS_ASSUME_NONNULL_END
