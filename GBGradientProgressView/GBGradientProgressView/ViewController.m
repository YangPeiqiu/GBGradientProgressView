//
//  ViewController.m
//  GBGradientProgressView
//
//  Created by Qiu on 2019/4/1.
//  Copyright © 2019 Yang. All rights reserved.
//

#import "ViewController.h"
#import "GBGradientProgressView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GBGradientProgressView *progressView = [[GBGradientProgressView alloc] initWithFrame:CGRectMake(40, 150, 300, 10)];
    progressView.colorArr = @[(__bridge id)[UIColor orangeColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor];
    progressView.progress = 0.5;
    progressView.animation = YES;
    [self.view addSubview:progressView];
    
    progressView = [[GBGradientProgressView alloc] initWithFrame:CGRectMake(40, 180, 300, 10)];
    [progressView setProgress:0.9 emergency:YES];
    progressView.animation = YES;
    progressView.backgroundProgressColor = [UIColor blackColor];
    [self.view addSubview:progressView];
}


@end
