//
//  ELDayNightManager.m
//  DayNightDemo
//
//  Created by evol on 2018/9/10.
//  Copyright © 2018年 evol. All rights reserved.
//

#import "ELDayNightManager.h"
#import "Header.h"
#import "ELDayNight.h"

@interface ELDayNightManager ()
{
    NSMutableArray * _dayNightObjs;
}

@end

@implementation ELDayNightManager


- (void)modify
{
    self.isNight = !self.isNight;
    [ELDayNight setNight:self.isNight];
}


+ (instancetype)defaultManager
{
    static ELDayNightManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _setUp];
    }
    return self;
}

- (void)_setUp
{
    _dayNightObjs = [NSMutableArray array];
}


- (void)addDayNightTarget:(id)target
{
    [_dayNightObjs addObject:target];
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self defaultManager];
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[self class] defaultManager];
}

@end
