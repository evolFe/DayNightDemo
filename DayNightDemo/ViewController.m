//
//  ViewController.m
//  DayNightDemo
//
//  Created by evol on 2018/9/10.
//  Copyright © 2018年 evol. All rights reserved.
//

#import "ViewController.h"
#import "ELDayNight.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.view.backgroundColorType = AppColorBackgroundDark;
    self.view.dnBackGroundColor = ELMakeColorTuple(UIColorFromRGB(0xedeeef), UIColorFromRGB(0x3a3928));
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.imageKey = @"mine_bg";
    [imageView sizeToFit];
    [self.view addSubview:imageView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(imageView.frame), 200, 30)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"这是一个 UILabel";
    label.dnTextColor = ELMakeColorTuple(UIColorFromRGB(0x222222), UIColorFromRGB(0xdcc787));
    [self.view addSubview:label];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.dnBackGroundColor = ELMakeColorTuple(UIColorFromRGB(0x7c936e), UIColorFromRGB(0x4b4a38));
    [button setFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 30, CGRectGetHeight(self.view.frame) - 100, 60, 30)];
    [button setTitle:@"Change" forState:UIControlStateNormal];
    [button setDnTitleColor:ELMakeColorTuple([UIColor whiteColor], UIColorFromRGB(0xdcc787)) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(dayNightChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)dayNightChange:(UIButton *)button
{
    [[ELDayNightManager defaultManager] modify];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
