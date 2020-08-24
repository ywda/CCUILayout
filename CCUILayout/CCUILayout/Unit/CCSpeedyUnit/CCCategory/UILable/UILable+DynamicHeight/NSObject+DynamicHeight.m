//
//  NSObject+DynamicHeight.m
//  CCUILayout
//  动态计算多行 Lab 的尺寸
//  Created by Admin on 2019/12/11.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "NSObject+DynamicHeight.h"

@implementation UILabel (DynamicHeight)


-(CGSize)sizeOfMultiLineLabel{
    return [self sizeThatFits:CGSizeMake(self.frame.size.width, MAXFLOAT)];
}

@end
