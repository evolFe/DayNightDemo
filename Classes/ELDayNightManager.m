//
//  ELDayNightManager.m
//  DayNightDemo
//
//  Created by evol on 2018/9/10.
//  Copyright © 2018年 evol. All rights reserved.
//

#import "ELDayNightManager.h"
#import "Header.h"

@implementation ELDayNightManager


- (void)modify
{
    self.isNight = !self.isNight;
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_sceneChange object:nil];
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

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self defaultManager];
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[self class] defaultManager];
}

@end
