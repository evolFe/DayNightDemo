//
//  UIColor+WZHex.m
//  gb_ios
//
//  Created by evol on 2018/8/23.
//  Copyright © 2018年 wenchao.han. All rights reserved.
//

#import "UIColor+dayNight.h"
#import "ELDayNightManager.h"

@implementation UIColor (WZHex)


+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

#define day_night_color(day_color, night_color) !([ELDayNightManager defaultManager].isNight) ? day_color : night_color
+ (UIColor *)colorWithType:(APPColorType)type
{
    switch (type) {
        case APPColorMain:
            return day_night_color(UIColorFromRGB(0x7c936e), UIColorFromRGB(0xdcc787));
        case AppColorWhite:
            return day_night_color([UIColor whiteColor], UIColorFromRGB(0xdcc787));
        case AppColorBackgroundDark:
            return day_night_color(UIColorFromRGB(0xedeeef), UIColorFromRGB(0x3a3928));
        case AppColorBackgroundLight:
            return day_night_color(UIColorFromRGB(0x7c936e), UIColorFromRGB(0x4b4a38));
        case APPColorBGGrayLight:
            return day_night_color(UIColorFromRGB(0xe8e8e8), UIColorFromRGB(0x4b4a38));
        case APPColorBGWhiteDark:
            return day_night_color([UIColor whiteColor], UIColorFromRGB(0x3a3928));
        case APPColorTitle222:
            return day_night_color(UIColorFromRGB(0x222222), UIColorFromRGB(0xdcc787));
        default:
            break;
    }
    return [UIColor clearColor];
}

@end
