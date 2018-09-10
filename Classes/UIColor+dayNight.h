//
//  UIColor+WZHex.h
//  gb_ios
//
//  Created by evol on 2018/8/23.
//  Copyright © 2018年 wenchao.han. All rights reserved.
//

#import <UIKit/UIKit.h>


#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface UIColor (WZHex)

/** 为了切换夜色设置的 */
typedef NS_ENUM(NSUInteger, APPColorType) {
    APPColorTypeNone,
    APPColorMain,
    AppColorWhite, // 白变亮
    AppColorBackgroundDark,
    AppColorBackgroundLight,
    APPColorBGGrayLight, //
    APPColorBGWhiteDark,
    APPColorTitle222, // 222222
};

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithType:(APPColorType)type;

@end
