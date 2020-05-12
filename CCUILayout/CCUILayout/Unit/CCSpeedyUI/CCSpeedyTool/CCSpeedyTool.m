//
//  CCSpeedyTool.m
//  WDYJForAppStore
//
//  Created by Admin on 2020/2/29.
//  Copyright © 2020 丁侃. All rights reserved.
//

#import "CCSpeedyTool.h"
#import <Masonry/Masonry.h>

@implementation CCSpeedyTool

// TODO: 设置按钮的圆角
/**
 @param anyControl 控件
 @param radius 圆角度
 @param width 边宽度
 @param borderColor 边线颜色
 @param can 是否裁剪
 @return 控件
 */
+ (id)cc_chageControlCircularWith:(id)anyControl
               AndSetCornerRadius:(NSInteger)radius
                   SetBorderWidth:(NSInteger)width
                   SetBorderColor:(UIColor *)borderColor
                 canMasksToBounds:(BOOL)can
{
    CALayer *icon_layer=[(UIControl*)anyControl layer];
    [icon_layer setCornerRadius:radius];
    [icon_layer setBorderWidth:width];
    [icon_layer setBorderColor:[borderColor CGColor]];
    [icon_layer setMasksToBounds:can];
    
    return anyControl;
}

// TODO: 选取部分数据变色（label）
/**
 @param label label
 @param arrray 变色数组
 @param color 变色颜色
 @return label
 */
+ (id)cc_setSomeOneChangeColor:(UILabel *)label
                SetSelectArray:(NSArray *)arrray
                SetChangeColor:(UIColor *)color{
    if (label.text.length == 0) {
        return 0;
    }
    int i;
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:label.text];
    for (i = 0; i < label.text.length; i ++) {
        NSString *a = [label.text substringWithRange:NSMakeRange(i, 1)];
        NSArray *number = arrray;
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(i, 1)];
        }
    }
    label.attributedText = attributeString;
    return label;
}


// TODO:  根据传入字体大小计算字体宽高
+ (CGSize)cc_calculateTextSizeWithText : (NSString *)text
                           WithTextFont: (UIFont*)textFont
                              WithMaxW : (CGFloat)maxW {
    
    CGFloat textMaxW = maxW;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    /*  --- 👇 废弃<对字体有一个区分> ---
     // FIXME: 注意 iOS9 字体需要在外部适配，这里不再内部适配字体 <textFont 传参注意>
    NSString *PFR = ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? @"PingFangSC-Regular" : @"PingFang SC";
    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:PFR size:textFont]} context:nil].size;
    */
    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size;
    
    return textSize;
}

+ (CGSize)cc_calculateTextSizeWithText : (NSString *)text
                           WithTextFont: (UIFont*)textFont
                              WithMaxH : (CGFloat)maxH {
    CGFloat textMaxH = maxH;
    CGSize textMaxSize = CGSizeMake(MAXFLOAT, textMaxH);
    // FIXME: 注意 iOS9 字体需要在外部适配，这里不再内部适配字体 <textFont 传参注意>
    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size;
    
    return textSize;
}

// TODO: 下划线
/**
 @param view 下划线
 */
+ (void)cc_setUpAcrossPartingLineWith:(UIView *)view
                            WithColor:(UIColor *)color {
    UIView *cellAcrossPartingLine = [[UIView alloc] init];
    cellAcrossPartingLine.backgroundColor = color;
    [view addSubview:cellAcrossPartingLine];
    
    [cellAcrossPartingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(view);
        make.bottom.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(view.width, 1));
    }];
}


// TODO: 竖线线
/**
 @param view 竖线线
 */
+ (void)cc_setUpLongLineWith:(UIView *)view
                   WithColor:(UIColor *)color
              WithHightRatio:(CGFloat)ratio {
    if (ratio == 0) { // 默认1
        ratio = 1;
    }
    UIView *cellLongLine = [[UIView alloc] init];
    cellLongLine.backgroundColor = color;
    [view addSubview:cellLongLine];
    
    [cellLongLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(view);
        make.centerY.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(1, view.height * ratio));
    }];
}

// TODO: 利用贝塞尔曲线设置圆角
/**
 @param control 按钮
 @param size 圆角尺寸
 */
+ (void)cc_setUpBezierPathCircularLayerWithControl:(UIButton *)control
                                              size:(CGSize)size {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:control.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft |UIRectCornerTopRight cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = control.bounds;
    maskLayer.path = maskPath.CGPath;
    control.layer.mask = maskLayer;
}


// TODO: label首行缩进
/**
 @param label label
 @param emptylen 缩进比
 */
+ (void)cc_setUpLabel:(UILabel *)label
              Content:(NSString *)content IndentationFortheFirstLineWith:(CGFloat)emptylen {
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:content attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    
    label.attributedText = attrText;
}

// TODO: 提示框
+ (void)cc_SetUpAlterWithView:(UIViewController *)vc
                      Message:(NSString *)message
                         Sure:(dispatch_block_t)sureBlock
                       Cancel:(dispatch_block_t)cancelBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        !cancelBlock ? : cancelBlock();
    }];
    //确定
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        !sureBlock ? : sureBlock();
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
}

+ (void)cc_SetUpAlterWithView:(UIViewController *)vc
                      Message:(NSString *)message
                         Sure:(dispatch_block_t)sureBlock{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];

    //确定
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        !sureBlock ? : sureBlock();
    }];
    [alertController addAction:okAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
    
}

+ (void)cc_SetUpAlterWithView:(UIViewController *)vc
                      Message:(NSString *)message{
    [CCSpeedyTool cc_SetUpAlterWithView:vc Message:message Sure:^{
    }];
}

// TODO:触动
+ (void)cc_callFeedback
{
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleHeavy];
        [generator prepare];
        [generator impactOccurred];
    }
}

// TODO:切换动画
+ (void)cc_setInAanimation:(UIView*)view{
    CATransition * transition = [CATransition animation];
    transition.type = @"moveOut";
    transition.subtype = @"fromCenter";
    transition.duration = 0.3;
    [view.window.layer removeAllAnimations];
    [view.window.layer addAnimation:transition forKey:nil];
}

// TODO: 是否是空字符串
+ (BOOL)cc_isEmptyStr:(NSString*)str {
     if (!str) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!str.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [str stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

@end
