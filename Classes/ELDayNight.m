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

@implementation WZColorContainer

- (instancetype)initWithTarget:(id)target
{
    self = [super init];
    if (self) {
        /** 弱引用target */
        self.target = target;
        _values = [NSMutableArray array];
        WS(ws);
        [[NSNotificationCenter defaultCenter] addObserverForName:Notification_sceneChange object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            __strong __typeof (ws) sself = ws;
            if (!sself) return;
            for (NSDictionary * dict in sself.values) {
                NSString * selector = dict[@"sel"];
                id obj = dict[@"obj"];
                SEL _sel = NSSelectorFromString(selector);
                NSMethodSignature * methodSignature = [[ws.target class] instanceMethodSignatureForSelector:_sel];
                if(methodSignature == nil)
                {
                    @throw [NSException exceptionWithName:@"抛异常错误" reason:@"没有这个方法，或者方法名字错误" userInfo:nil];
                }
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
                [invocation setTarget:ws.target];
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
        }];
    }
    return self;
}

- (void)dealloc
{
    REMOVE_NOTIFY_SCENE;
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

- (APPColorType)backgroundColorType
{
    return APPColorTypeNone;
}
- (void)setBackgroundColorType:(APPColorType)backgroundColorType
{
    self.backgroundColor = [UIColor colorWithType:backgroundColorType];
    WZColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setBackgroundColorType:) object:@(backgroundColorType), nil];
}


- (void)_setBackgroundColorType:(id)type
{
    self.backgroundColor = [UIColor colorWithType:[type integerValue]];
}


- (WZColorContainer *)colorContainer
{
    WZColorContainer * container = objc_getAssociatedObject(self, &kColortContainerKey);
    if (container == nil) {
        container = [[WZColorContainer alloc] initWithTarget:self];
        objc_setAssociatedObject(self, &kColortContainerKey, container, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return container;
}

@end

@implementation UILabel (colorType)

- (APPColorType)textColorType
{
    return APPColorTypeNone;
}
- (void)setTextColorType:(APPColorType)type
{
    self.textColor = [UIColor colorWithType:type];
    WZColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setTextColorType:) object:@(type), nil];
}
- (void)_setTextColorType:(id)type
{
    self.textColor = [UIColor colorWithType:[type integerValue]];
}

@end

@implementation UIButton (colorType)

- (void)setTitleColorType:(APPColorType)type forState:(UIControlState)state
{
    [self setTitleColor:[UIColor colorWithType:type] forState:state];
    WZColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setTitleColorType:state:) object:@(type), @(state), nil];
}
- (void)_setTitleColorType:(id)type state:(id)state
{
    [self setTitleColor:[UIColor colorWithType:[type integerValue]] forState:(UIControlState)[state integerValue]];
}

/** 按钮 设置图片 */
- (void)setImageKey:(NSString *)key forState:(UIControlState)state
{
    [self setImage:[UIImage imageNamed:key.nightValue] forState:UIControlStateNormal];
    WZColorContainer * container = self.colorContainer;
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
    WZColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setImageKey:) object:imageKey, nil];
}
- (void)_setImageKey:(NSString *)imageKey
{
    self.image = [UIImage imageNamed:imageKey.nightValue];
}

- (void)setImageKey:(NSString *)imageKey stretchPoint:(CGPoint)strechPoint
{
    self.image = [[UIImage imageNamed:imageKey.nightValue] stretchableImageWithLeftCapWidth:strechPoint.x topCapHeight:strechPoint.y];
    WZColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setImageKey:stretchPoint:) object:imageKey,[NSValue valueWithCGPoint:strechPoint],nil];

}
- (void)_setImageKey:(NSString *)imageKey stretchPoint:(NSValue *)strechPoint
{
    CGPoint offset = strechPoint.CGPointValue;
    self.image = [[UIImage imageNamed:imageKey.nightValue] stretchableImageWithLeftCapWidth:offset.x topCapHeight:offset.y];
}

@end

@implementation UITextField (colorType)

- (APPColorType)textColorType
{
    return APPColorTypeNone;
}
- (void)setTextColorType:(APPColorType)type
{
    self.textColor = [UIColor colorWithType:type];
    WZColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setTextColorType:) object:@(type), nil];
}
- (void)_setTextColorType:(id)type
{
    self.textColor = [UIColor colorWithType:[type integerValue]];
}

@end

@implementation UITextView (colorType)

- (APPColorType)textColorType
{
    return APPColorTypeNone;
}
- (void)setTextColorType:(APPColorType)type
{
    self.textColor = [UIColor colorWithType:type];
    WZColorContainer * container = self.colorContainer;
    [container addSelector:@selector(_setTextColorType:) object:@(type), nil];
}
- (void)_setTextColorType:(id)type
{
    self.textColor = [UIColor colorWithType:[type integerValue]];
}

@end

