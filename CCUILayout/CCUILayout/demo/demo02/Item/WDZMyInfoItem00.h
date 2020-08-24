//
//  WDZMyInfoItem00.h
//  CCUILayout
//  MARK: 头像、员工照 复用 CELL
//  Created by Admin on 2020/4/30.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDZMyInfoItem00Mode : NSObject

/** 左边文字 */
@property (nonatomic, strong) NSString *topic;
/** 右边图片<图片名称、或者 图片url> */
@property (nonatomic, strong) NSString *imgUrl;
/** 是否显示图片<显示图片则隐藏右边文字，反之不隐藏> */
@property (nonatomic, assign) BOOL isHaveImg;
/** 右边文字 */
@property (nonatomic, strong) NSString *context;

@end

// MARK: 🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞

@interface WDZMyInfoItem00 : CCUILayoutCell


- (void) setUpCellWith:(WDZMyInfoItem00Mode*)mode click:(dispatch_block_t)block;
- (void) setUpCellWithLab:(NSString*)lab;

@end

NS_ASSUME_NONNULL_END
