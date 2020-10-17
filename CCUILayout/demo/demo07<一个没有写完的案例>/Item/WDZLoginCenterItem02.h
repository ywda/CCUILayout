//
//  WDZLoginCenterItem02.h
//  refactor_LoginCenter
//  MARK: 登录中心 `1、手机号码 2、验证码 3、电话号码/用户名 4、密码` Item
//  Created by Admin on 2020/5/18.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDZLoginCenterItem02Mode : CCUILayoutCell

/** 1、ccl_type0  电话号码/用户名
    2、ccl_type1  密码
    3、ccl_type2  手机号码
    4、ccl_type3  验证码 */
@property (nonatomic, assign) CCUILayout_MaskType funcType;

@end

// MARK: 🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞

@interface WDZLoginCenterItem02 : CCUILayoutCell


@end

NS_ASSUME_NONNULL_END
