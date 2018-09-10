//
//  NSString+dayNight.m
//  DayNightDemo
//
//  Created by evol on 2018/9/10.
//  Copyright © 2018年 evol. All rights reserved.
//

#import "NSString+dayNight.h"
#import "ELDayNightManager.h"

@implementation NSString (dayNight)

- (NSString *)nightValue
{
    if ([ELDayNightManager defaultManager].isNight) {
        return [self stringByAppendingString:@"_night"];
    }
    return self;
}

@end
