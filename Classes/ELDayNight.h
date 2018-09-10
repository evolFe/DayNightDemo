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

/** 语言切换 */
#define LANGUAGE_NOTIFY(...) [[NSNotificationCenter defaultCenter] addObserverForName:Notification_languageChange object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {\
__VA_ARGS__;\
}];
/** 夜景切换 */
#define SCENE_NOTIFY(...) [[NSNotificationCenter defaultCenter] addObserverForName:Notification_sceneChange object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {\
__VA_ARGS__;\
}];

/** 移除通知中心 */
#define REMOVE_NOTIFY_LANGUAGE [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_languageChange object:nil]
#define REMOVE_NOTIFY_SCENE [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_sceneChange object:nil]

#define REMOVE_NOTIFY_LANGUAGE_SCENE REMOVE_NOTIFY_LANGUAGE;\
REMOVE_NOTIFY_SCENE;

#define DEALLOC_REMOVE_NOTIFY_LANGUAGE_SCENE - (void)dealloc{ \
    REMOVE_NOTIFY_LANGUAGE_SCENE; \
}

/**
 Color的容器
 */
@interface WZColorContainer : NSObject

@property (nonatomic ,weak) id target;// 这里一定要用weak, 避免循环引用造成内存泄漏
@property (nonatomic ,strong) NSMutableArray * values;

- (instancetype)initWithTarget:(id)target;
- (void)addSelector:(SEL)sel object:(id)object, ... NS_REQUIRES_NIL_TERMINATION;

@end

@interface UIView (colorType)
@property (nonatomic ,assign) APPColorType backgroundColorType;
- (WZColorContainer *)colorContainer;
@end

@interface UILabel (colorType)
@property (nonatomic ,assign) APPColorType textColorType;
@end

@interface UIButton (colorType)
- (void)setTitleColorType:(APPColorType)type forState:(UIControlState)state;
- (void)setImageKey:(NSString *)key forState:(UIControlState)state;
@end

@interface UIImageView (colorType)
@property (nonatomic ,copy) NSString * imageKey;
- (void)setImageKey:(NSString *)imageKey stretchPoint:(CGPoint)strechPoint; // .9图
@end

@interface UITextField (colorType)
@property (nonatomic ,assign) APPColorType textColorType;
@end

@interface UITextView (colorType)
@property (nonatomic ,assign) APPColorType textColorType;
@end
