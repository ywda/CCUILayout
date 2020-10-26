//
//  CCUIContainerUiMode.h
//  CCUIContainer
//  MARK: 某个 VIEW CELL 元素要绑定的 UiMode
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCUIContainerUiMode : NSObject

/** 绑定值 <作用：区分复用同一个 CELL 或者 VIEW 的时候的标记> */
@property (nonatomic, strong) NSNumber * bind;
/** CELL 或者 VIEW 的类名 */
@property (nonatomic, copy)   NSString * name;
/** CELL 或者 VIEW 的布局 高度 */
@property (nonatomic, assign) CGFloat    height;
/** CELL 或者 VIEW 的布局 用途描述 */
@property (nonatomic, copy)   NSString * desc;

/** 某些情况下要特殊化设置 CELL 的背景色 */
@property (nonatomic, strong) UIColor * bgColor;

@end

NS_ASSUME_NONNULL_END
