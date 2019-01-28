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

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundDNTuple = fDNTupleMake(UIColorFromRGB(0xedeeef), UIColorFromRGB(0x3a3928));
    UIImageView * imageView = [[UIImageView alloc] init];
//    imageView.imageKey = @"mine_bg";
    imageView.imageTuple = fDNTupleMake(@"mine_bg", @"mine_bg_night");/** 以上两种方式都可以 */
    [imageView sizeToFit];
    [self.view addSubview:imageView];

    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(imageView.frame), 200, 30)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"这是一个 UILabel";
    label.textDNTuple = fDNTupleMake(UIColorFromRGB(0x222222), UIColorFromRGB(0xdcc787));
    [self.view addSubview:label];


    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundDNTuple = fDNTupleMake(UIColorFromRGB(0x7c936e), UIColorFromRGB(0x4b4a38));
    [button setFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 30, CGRectGetHeight(self.view.frame) - 100, 60, 30)];
    [button setTitle:@"Change" forState:UIControlStateNormal];
    [button setTitleDNTuple:fDNTupleMake([UIColor whiteColor], UIColorFromRGB(0xdcc787)) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(dayNightChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

- (void)dayNightChange:(UIButton *)button
{
    [[FDayNightManager defaultManager] toggle];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
