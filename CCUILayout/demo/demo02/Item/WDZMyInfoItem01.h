//
//  WDZMyInfoItem01.h
//  CCUIContainer
//  MARK: 姓名、手机号、邮箱、部门 复用 CELL
//  Created by Admin on 2020/4/30.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDZMyInfoItem01Mode : NSObject

/** 左边文字 */
@property (nonatomic, strong) NSString *topic;
/** 是否可以编辑 */
@property (nonatomic, assign) BOOL isCanEditor;
/** 右边文字 */
@property (nonatomic, strong) NSString *context;

@end

// MARK: 🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞

@interface WDZMyInfoItem01 : CCUIContainerCell

- (void) setUpCellWith:(WDZMyInfoItem01Mode*)mode click:(CCUIContainer_block_str)block;
- (void) setUpCellWithLab:(NSString*)lab;


@end

NS_ASSUME_NONNULL_END
