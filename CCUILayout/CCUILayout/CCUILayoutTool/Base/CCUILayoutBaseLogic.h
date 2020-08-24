//
//  CCUILayoutBaseLogic.h
//  CCUILayout
//  MARK: 一些基础逻辑的抽取
//  Created by Admin on 2020/5/15.
//  Copyright © 2020 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CCUILayout_Unit_Header.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCUILayoutBaseLogic : NSObject

@property (nonatomic, assign) BOOL isCheckOk;
@property (nonatomic, strong) NSString* warEr;
@property (nonatomic, strong) NSMutableArray<CCUILayoutUiMode*>* uims;


// MARK: 创建时校验模型是否安全
+ (CCUILayoutBaseLogic*) checkPropertyWithUIControls:(NSArray<UIResponder *> *)subUis
                                              layout:(NSArray<CCUILayoutUiMode*> *)subLModes;

@end

NS_ASSUME_NONNULL_END
