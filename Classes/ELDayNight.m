//
//  WZPrivateView.m
//  gb_ios
//
//  Created by evol on 2018/9/3.
//  Copyright © 2018年 mingbai.fe All rights reserved.
//

#import "ELDayNight.h"
#import <objc/runtime.h>
#import "Header.h"
#import "NSString+dayNight.h"

static const int kColortContainerKey;

ELColorTuple ELMakeColorTuple(UIColor * dayColor, UIColor * nightColor) {
    return @[dayColor, nightColor];
}
UIColor * ELColorFromTuple(ELColorTuple colors) {
    return colors[[ELDayNight isNight]];
}

@implementation ELDayNight

static BOOL isNight = NO;

+ (void)setNight:(BOOL)night {
    isNight = night;
    [[NSNotificationCenter defaultCenter] postNotificationName:ELNotification_sceneChange object:nil];
}

+ (BOOL)isNight {
    return isNight;
}

@end

/**
 Color的容器
 */
@interface _ELColorContainer : NSObject

@property (nonatomic ,weak) id target;// 这里一定要用weak, 避免循环引用造成内存泄漏
@property (nonatomic ,strong) NSMutableArray * values;

- (instancetype)initWithTarget:(id)target;
- (void)addSelector:(SEL)sel object:(id)object, ... NS_REQUIRES_NIL_TERMINATION;

@end

@implementation _ELColorContainer

- (instancetype)initWithTarget:(id)target
{
    self = [super init];
    if (self) {
        /** 弱引用target */
        self.target = target;
        _values = [NSMutableArray array];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dayNightChange) name:ELNotification_sceneChange object:nil];
    }
    return self;
}

- (void)dayNightChange {
    for (NSDictionary * dict in self.values) {
        NSString * selector = dict[@"sel"];
        id obj = dict[@"obj"];
        SEL _sel = NSSelectorFromString(selector);
        NSMethodSignature * methodSignature = [[self.target class] instanceMethodSignatureForSelector:_sel];
        if(methodSignature == nil)
        {
            @throw [NSException exceptionWithName:@"抛异常错误" reason:@"没有这个方法，或者方法名字错误" userInfo:nil];
        }
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setTarget:self.target];
        [invocation setSelector:_sel];
        NSInteger argsCount = methodSignature.numberOfArguments - 2; // 参数里有 self, _cmd  所以-2
        NSInteger paramsCount = [obj count];
        if (paramsCount >= argsCount) {
            for (int i = 0; i < argsCount; i++) {
                id param = obj[i];
                [invocation setArgument:&param atIndex:i+2];
            }
            [invocation invoke];
        }
    }
}

- (void)addSelector:(SEL)sel object:(id)object, ... NS_REQUIRES_NIL_TERMINATION
{
    if (sel ==nil || object == nil) {
        return;
    }
    va_list args;
    id item;
    va_start(args, object);
    NSMutableArray * params = [NSMutableArray arrayWithObjects:object, nil];
    while ((item = va_arg(args, id))) {
        [params addObject:item];
    }
    va_end(args);
    [_values addObject:@{@"sel":NSStringFromSelector(sel), @"obj":params}];
}

@end

@implementation UIView (colorType)

- (void)setDnBackGroundColor:(ELColorTuple)dnBackGroundColor {
    self.backgroundColor = ELColorFromTuple(dnBackGroundColor);
    _ELColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setDnBackGroundColor:) object:dnBackGroundColor, nil];
}

- (void)_setDnBackGroundColor:(ELColorTuple)dnBackGroundColor {
    self.backgroundColor = ELColorFromTuple(dnBackGroundColor);
}

- (ELColorTuple)dnBackGroundColor
{
    return nil;
}

- (_ELColorContainer *)colorContainer
{
    _ELColorContainer * container = objc_getAssociatedObject(self, &kColortContainerKey);
    if (container == nil) {
        container = [[_ELColorContainer alloc] initWithTarget:self];
        objc_setAssociatedObject(self, &kColortContainerKey, container, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return container;
}

@end

@implementation UILabel (colorType)

- (ELColorTuple)dnTextColor {
    return nil;
}

- (void)setDnTextColor:(ELColorTuple)dnTextColor {
    self.textColor = ELColorFromTuple(dnTextColor);
    _ELColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setDnTextColor:) object:dnTextColor, nil];
}
- (void)_setDnTextColor:(ELColorTuple)dnTextColor {
    self.textColor = ELColorFromTuple(dnTextColor);
}

@end

@implementation UIButton (colorType)

- (void)setDnTitleColor:(ELColorTuple)colorTuple forState:(UIControlState)state {
    [self setTitleColor:ELColorFromTuple(colorTuple) forState:state];
    _ELColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setDnTitleColor:forState:) object:colorTuple, @(state), nil];
}

- (void)_setDnTitleColor:(ELColorTuple)colorTuple forState:(id)state {
    [self setTitleColor:ELColorFromTuple(colorTuple) forState:(UIControlState)[state integerValue]];
}

/** 按钮 设置图片 */
- (void)setImageKey:(NSString *)key forState:(UIControlState)state
{
    [self setImage:[UIImage imageNamed:key.nightValue] forState:UIControlStateNormal];
    _ELColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setImageKey:forState:) object:key, @(state), nil];
}
- (void)_setImageKey:(NSString *)key forState:(id)state
{
    [self setImage:[UIImage imageNamed:key.nightValue] forState:(UIControlState)[state integerValue]];
}

@end

@implementation UIImageView (colorType)

- (NSString *)imageKey
{
    return nil;
}
- (void)setImageKey:(NSString *)imageKey
{
    self.image = [UIImage imageNamed:imageKey.nightValue];
    _ELColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setImageKey:) object:imageKey, nil];
}
- (void)_setImageKey:(NSString *)imageKey
{
    self.image = [UIImage imageNamed:imageKey.nightValue];
}

- (void)setImageKey:(NSString *)imageKey stretchPoint:(CGPoint)strechPoint
{
    self.image = [[UIImage imageNamed:imageKey.nightValue] stretchableImageWithLeftCapWidth:strechPoint.x topCapHeight:strechPoint.y];
    _ELColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setImageKey:stretchPoint:) object:imageKey,[NSValue valueWithCGPoint:strechPoint],nil];

}
- (void)_setImageKey:(NSString *)imageKey stretchPoint:(NSValue *)strechPoint
{
    CGPoint offset = strechPoint.CGPointValue;
    self.image = [[UIImage imageNamed:imageKey.nightValue] stretchableImageWithLeftCapWidth:offset.x topCapHeight:offset.y];
}

@end

@implementation UITextField (colorType)

- (ELColorTuple)dnTextColor {
    return nil;
}

- (void)setDnTextColor:(ELColorTuple)dnTextColor {
    self.textColor = ELColorFromTuple(dnTextColor);
    _ELColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setDnTextColor:) object:dnTextColor, nil];

}

- (void)_setDnTextColor:(ELColorTuple)dnTextColor {
    self.textColor = ELColorFromTuple(dnTextColor);
}
@end

@implementation UITextView (colorType)

- (ELColorTuple)dnTextColor {
    return nil;
}

- (void)setDnTextColor:(ELColorTuple)dnTextColor {
    self.textColor = ELColorFromTuple(dnTextColor);
    _ELColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setDnTextColor:) object:dnTextColor, nil];
    
}

- (void)_setDnTextColor:(ELColorTuple)dnTextColor {
    self.textColor = ELColorFromTuple(dnTextColor);
}

@end

