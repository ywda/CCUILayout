//
//  NSObject+DynamicHeight.h
//  CCUIContainer
//  动态计算多行 Lab 的尺寸
//  Created by Admin on 2019/12/11.
//  Copyright © 2019 Admin. All rights reserved.
//


#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (DynamicHeight)

 -(CGSize)sizeOfMultiLineLabel;

@end

NS_ASSUME_NONNULL_END
