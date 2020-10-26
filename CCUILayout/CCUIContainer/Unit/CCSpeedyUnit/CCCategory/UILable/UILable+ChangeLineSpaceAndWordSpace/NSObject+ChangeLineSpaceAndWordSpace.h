//
//  NSObject+ChangeLineSpaceAndWordSpace.h
//  CCUIContainer
//
//  Created by Admin on 2019/12/12.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ChangeLineSpaceAndWordSpace)

/// 改变行间距
/// @param label 要改变的Lab
/// @param space 间距
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/// 改变字间距
/// @param label 要改变的Lab
/// @param space 间距
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;


/// 改变行间距和字间距
/// @param label 要改变的Lab
/// @param lineSpace 行间距
/// @param wordSpace 字间距
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;


@end

NS_ASSUME_NONNULL_END
