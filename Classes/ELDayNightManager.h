//
//  ELDayNightManager.h
//  DayNightDemo
//
//  Created by evol on 2018/9/10.
//  Copyright © 2018年 evol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELDayNightManager : NSObject<NSCopying>

+ (instancetype)defaultManager;

@property (nonatomic ,assign) BOOL isNight;

- (void)modify;

@end
