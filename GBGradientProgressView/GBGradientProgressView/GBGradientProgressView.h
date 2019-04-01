//
//  GBGradientProgressView.h
//  MQGradientProgress
//
//  Created by Qiu on 2019/4/1.
//  Copyright © 2019 maqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GBGradientProgressView : UIView

/**
 *  进度条背景颜色  默认是 灰色
 */
@property (nonatomic, strong) UIColor *backgroundProgressColor;

/**
 *  进度条渐变颜色数组，颜色个数>=2
    默认格式是：@[(__bridge id)[UIColor orangeColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor];
 */
@property (nonatomic, strong) NSArray *colorArr;

/**
 *  进度 默认是 0.5
 */
@property (nonatomic, assign) CGFloat progress;

/**
 需要动画展示啵，默认不需要
 */
@property (nonatomic, assign) BOOL animation;

/**
 展示

 @param progress 进度
 @param emergency 是否有那个紧急
 */
- (void)setProgress:(CGFloat)progress emergency:(BOOL)emergency;

@end

NS_ASSUME_NONNULL_END
