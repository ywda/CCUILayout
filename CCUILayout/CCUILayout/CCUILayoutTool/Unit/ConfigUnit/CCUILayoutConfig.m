//
//  CCUILayoutConfig.m
//  CCUILayout
//  MARK: 定制版本的配置文件
//  Created by Admin on 2020/5/14.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutConfig.h"

@implementation CCUILayoutConfig


/** MARK: 根据App 自动加载页面的不同APP 适配文件 处理->: {className + _APPTYPE}*/
+ (NSString*) getConfigPlistNameBy:(NSString*)className
{
    // 一般就是 APP 的类型区分字段 <这里暂时为 @"">
    NSString *APPTYPE = @"";
    NSString *tmp = [className stringByAppendingString:@"_"];
    tmp = [tmp stringByAppendingString:APPTYPE];

    return tmp;
}

@end
