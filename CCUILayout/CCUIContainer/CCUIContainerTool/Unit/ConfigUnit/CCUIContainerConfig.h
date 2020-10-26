//
//  CCUIContainerConfig.h
//  CCUIContainer
//  MARK: 定制版本的配置文件
//  Created by Admin on 2020/5/14.
//  Copyright © 2020 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCUIContainerConfig : NSObject

/** MARK: 根据App 自动加载页面的不同APP 适配文件 处理->: {className + _WDZAPPTYPE}*/
+ (NSString*) getConfigPlistNameBy:(NSString*)className;

@end

NS_ASSUME_NONNULL_END

