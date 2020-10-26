//
//  CCUIContainer_Color.h
//  CCUIContainer
//
//  Created by Admin on 2020/4/30.
//  Copyright © 2020 Admin. All rights reserved.
//

#ifndef CCUIContainer_Color_h
#define CCUIContainer_Color_h


// MARK: 调试颜色
// ————————————————————————————————————————————————————————
/* TODO: --- 👇【CCUIContainer 工具】 暗黑依赖下的 适配
#define CCUIContainer_PLACE_COLOR        UIColor.WDZ_separatorColor2
#define CCUIContainer_RED                UIColor.WDZ_redColor
#define CCUIContainer_GREEN              UIColor.WDZ_greenColor
#define CCUIContainer_BLACK              UIColor.WDZ_titleTextColor9
#define CCUIContainer_GRAY               UIColor.WDZ_titleTextColor6
#define CCUIContainer_DARK               UIColor.WDZ_titleTextColor4
#define CCUIContainer_LGRAY              UIColor.WDZ_titleTextColor3
#define CCUIContainer_ORANG              UIColor.WDZ_chartOrangeColor
#define CCUIContainer_WHITE              UIColor.WDZ_whiteColor
#define CCUIContainer_CLEAR              UIColor.WDZ_clearColor
#define CCUIContainer_YELLOW             UIColor.WDZ_yellowColor
#define CCUIContainer_PAGE_BG_COLOR      WDZColorHexString(0xF7F7F7, 1, 0x191919, 1)
#define CCUIContainer_kThemeColor        UIColor.WDZ_themeColor
#define CCUIContainer_TEXT_COLOR1        CCUIContainer_BLACK
#define CCUIContainer_TEXT_COLOR2        CCUIContainer_DARK
*/

/* TODO: --- 👇【CCUIContainer 工具】 【非】暗黑依赖下的 适配 */
#define CCUIContainer_PLACE_COLOR        [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0]
#define CCUIContainer_RED                [UIColor redColor]
#define CCUIContainer_GREEN              [UIColor greenColor]
#define CCUIContainer_BLACK              [UIColor blackColor]
#define CCUIContainer_GRAY               [UIColor grayColor]
#define CCUIContainer_DARK               [UIColor darkGrayColor]
#define CCUIContainer_LGRAY              [UIColor lightGrayColor]
#define CCUIContainer_ORANG              [UIColor orangeColor]
#define CCUIContainer_WHITE              [UIColor whiteColor]
#define CCUIContainer_CLEAR              [UIColor clearColor]
#define CCUIContainer_YELLOW             [UIColor yellowColor]
#define CCUIContainer_PAGE_BG_COLOR      CCUIContainer_WHITE
#define CCUIContainer_kThemeColor        CCUIContainer_YELLOW
#define CCUIContainer_TEXT_COLOR1        CCUIContainer_BLACK
#define CCUIContainer_TEXT_COLOR2        CCUIContainer_DARK


// 轻随机色
#define CCUIContainer_RANDOM_COLOR_LIGHT CCUIContainer_RANDOM_COLOR_LIGHT_MAKE(arc4random_uniform(156)+100, arc4random_uniform(156)+100, arc4random_uniform(156)+100, arc4random_uniform(156)+100)
#define CCUIContainer_RANDOM_COLOR_LIGHT_MAKE(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
// 重随机色
#define CCUIContainer_RANDOM_COLOR [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0*0.75) green:((float)arc4random_uniform(256) / 255.0*0.75) blue:((float)arc4random_uniform(256.0) / 255.0*0.75) alpha:1.0]


#endif /* CCUIContainer_Color_h */
