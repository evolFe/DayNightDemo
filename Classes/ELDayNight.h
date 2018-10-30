//
//  WZPrivateView.h
//  gb_ios
//
//  Created by evol on 2018/9/3.
//  Copyright © 2018年 mingbai.fe All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+dayNight.h"
#import "NSString+dayNight.h"
#import "Header.h"
#import "ELDayNightManager.h"


typedef NSArray * ELColorTuple;
ELColorTuple ELMakeColorTuple(UIColor * dayColor, UIColor * nightColor);
UIColor * ELColorFromTuple(ELColorTuple colors);

#define ELNotification_sceneChange @"ELNotification_sceneChange"

#define REMOVE_NOTIFY_SCENE [[NSNotificationCenter defaultCenter] removeObserver:self name:ELNotification_sceneChange object:nil]


@interface ELDayNight : NSObject

/**
 公共API 设置白天夜景

 @param night 是否是夜景
 */
+ (void)setNight:(BOOL)night;

/**
 获取当前是否是夜景

 @return BOOL 是否夜景
 */
+ (BOOL)isNight;

@end




@class _ELColorContainer;
@interface UIView (colorType)
@property (nonatomic, copy) ELColorTuple dnBackGroundColor;
- (_ELColorContainer *)colorContainer;
@end

@interface UILabel (colorType)
@property (nonatomic ,copy) ELColorTuple dnTextColor;
@end

@interface UIButton (colorType)
- (void)setDnTitleColor:(ELColorTuple)colorTuple forState:(UIControlState)state;
- (void)setImageKey:(NSString *)key forState:(UIControlState)state;
@end

@interface UIImageView (colorType)
@property (nonatomic ,copy) NSString * imageKey;
- (void)setImageKey:(NSString *)imageKey stretchPoint:(CGPoint)strechPoint; // .9图
@end

@interface UITextField (colorType)
@property (nonatomic ,copy) ELColorTuple dnTextColor;
@end

@interface UITextView (colorType)
@property (nonatomic ,copy) ELColorTuple dnTextColor;
@end
