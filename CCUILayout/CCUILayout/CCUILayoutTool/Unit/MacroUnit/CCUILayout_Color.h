//
//  CCUILayout_Color.h
//  CCUILayout
//
//  Created by Admin on 2020/4/30.
//  Copyright © 2020 Admin. All rights reserved.
//

#ifndef CCUILayout_Color_h
#define CCUILayout_Color_h


// MARK: 调试颜色
// ————————————————————————————————————————————————————————
/* TODO: --- 👇【CCUILayout 工具】 暗黑依赖下的 适配
#define CCUILayout_PLACE_COLOR        UIColor.WDZ_separatorColor2
#define CCUILayout_RED                UIColor.WDZ_redColor
#define CCUILayout_GREEN              UIColor.WDZ_greenColor
#define CCUILayout_BLACK              UIColor.WDZ_titleTextColor9
#define CCUILayout_GRAY               UIColor.WDZ_titleTextColor6
#define CCUILayout_DARK               UIColor.WDZ_titleTextColor4
#define CCUILayout_LGRAY              UIColor.WDZ_titleTextColor3
#define CCUILayout_ORANG              UIColor.WDZ_chartOrangeColor
#define CCUILayout_WHITE              UIColor.WDZ_whiteColor
#define CCUILayout_CLEAR              UIColor.WDZ_clearColor
#define CCUILayout_YELLOW             UIColor.WDZ_yellowColor
#define CCUILayout_PAGE_BG_COLOR      WDZColorHexString(0xF7F7F7, 1, 0x191919, 1)
#define CCUILayout_kThemeColor        UIColor.WDZ_themeColor
#define CCUILayout_TEXT_COLOR1        CCUILayout_BLACK
#define CCUILayout_TEXT_COLOR2        CCUILayout_DARK
*/

/* TODO: --- 👇【CCUILayout 工具】 【非】暗黑依赖下的 适配 */
#define CCUILayout_PLACE_COLOR        [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0]
#define CCUILayout_RED                [UIColor redColor]
#define CCUILayout_GREEN              [UIColor greenColor]
#define CCUILayout_BLACK              [UIColor blackColor]
#define CCUILayout_GRAY               [UIColor grayColor]
#define CCUILayout_DARK               [UIColor darkGrayColor]
#define CCUILayout_LGRAY              [UIColor lightGrayColor]
#define CCUILayout_ORANG              [UIColor orangeColor]
#define CCUILayout_WHITE              [UIColor whiteColor]
#define CCUILayout_CLEAR              [UIColor clearColor]
#define CCUILayout_YELLOW             [UIColor yellowColor]
#define CCUILayout_PAGE_BG_COLOR      CCUILayout_WHITE
#define CCUILayout_kThemeColor        CCUILayout_YELLOW
#define CCUILayout_TEXT_COLOR1        CCUILayout_BLACK
#define CCUILayout_TEXT_COLOR2        CCUILayout_DARK


// 轻随机色
#define CCUILayout_RANDOM_COLOR_LIGHT CCUILayout_RANDOM_COLOR_LIGHT_MAKE(arc4random_uniform(156)+100, arc4random_uniform(156)+100, arc4random_uniform(156)+100, arc4random_uniform(156)+100)
#define CCUILayout_RANDOM_COLOR_LIGHT_MAKE(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
// 重随机色
#define CCUILayout_RANDOM_COLOR [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0*0.75) green:((float)arc4random_uniform(256) / 255.0*0.75) blue:((float)arc4random_uniform(256.0) / 255.0*0.75) alpha:1.0]


#endif /* CCUILayout_Color_h */
