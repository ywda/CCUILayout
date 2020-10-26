//
//  CCUIContainerDebugUiMode.h
//  WDZForAppStore
//  MARK: 注释部分的 debugUiMode
//  Created by Admin on 2020/9/5.
//  Copyright © 2020 Wandianzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCUIContainerUiMode.h"
#import "CCSpeedyTool.h"
#import "CCUIContainer_Font.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCUIContainerDebugUiMode : NSObject

@property(nonatomic, strong) CCUIContainerUiMode *linkCLM;
@property(nonatomic, strong) NSString *desc;
@property(nonatomic, assign) CGFloat height;


/** MARK: 获取计算得到的描述文字高度数组 */
+ (NSMutableArray<CCUIContainerDebugUiMode*>*) getCalculateNotesModesFrom:(NSArray<CCUIContainerUiMode*>*)dbm;

@end

NS_ASSUME_NONNULL_END
