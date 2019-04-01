//
//  GBGradientProgressView.m
//  MQGradientProgress
//
//  Created by Qiu on 2019/4/1.
//  Copyright © 2019 maqi. All rights reserved.
//

#import "GBGradientProgressView.h"

@interface GBGradientProgressView () <CAAnimationDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CABasicAnimation *basicAnimation;

/**
 是否展示 紧急横线
 */
@property (nonatomic, assign) BOOL emergency;

@end

@implementation GBGradientProgressView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _colorArr = @[(__bridge id)[UIColor colorWithRed:250./255. green:144./255. blue:109./255. alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:254./255. green:55./255. blue:87./255. alpha:1.0].CGColor];
        _backgroundProgressColor = [UIColor grayColor];
        _progress = 0.5;
        _emergency = NO;
        [self gbInitView];
    }
    return self;
}

- (void)addStripesEmergency {
    CGRect rect = self.gradientLayer.frame;
    CGFloat xStart = rect.size.height/2.0, height = rect.size.height, width = rect.size.height;
    while (xStart < rect.size.width - rect.size.height/2.0) {
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        // 初始化
        UIBezierPath* aPath = [UIBezierPath bezierPath];
        // 起始点
        [aPath moveToPoint:CGPointMake(xStart, 0)];
        // 画线
        [aPath addLineToPoint:CGPointMake(xStart + width * 0.25, height)]; // 第一点
        [aPath addLineToPoint:CGPointMake(xStart + width * 0.75, height)]; // 第二点
        [aPath addLineToPoint:CGPointMake(xStart + width * 0.50, 0)]; // 第三点
        //通过调用closePath方法得到的
        [aPath closePath];
        xStart += 1.5 * width;
        layer.path = aPath.CGPath;
        layer.fillColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
        [self.gradientLayer addSublayer:layer];
    }
}

#pragma mark - Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag && self.emergency) {
        [self addStripesEmergency];
    }
}

#pragma mark - InitAndLayout
- (void)gbInitView {
    [self addSubview:self.backView];
    [self.backView.layer addSublayer:self.gradientLayer];
}

#pragma mark - Setter
- (void)setColorArr:(NSArray *)colorArr {
    self.gradientLayer.colors = colorArr;
}

- (void)setProgress:(CGFloat)progress {
    self.gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width * progress, self.frame.size.height);
}

- (void)setProgress:(CGFloat)progress emergency:(BOOL)emergency {
    [self setProgress:progress];
    _emergency = emergency;
}

- (void)setBackgroundProgressColor:(UIColor *)backgroundProgressColor {
    self.backView.backgroundColor = backgroundProgressColor;
}

- (void)setAnimation:(BOOL)animation {
    if (animation) {
        self.basicAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, self.gradientLayer.frame.size.height)];
        self.basicAnimation.toValue = [NSValue valueWithCGRect:self.gradientLayer.frame];
        [self.gradientLayer addAnimation:self.basicAnimation forKey:@"gradientAnimaiton"];
    }
}

#pragma mark - Getter
- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.bounds = CGRectMake(0, 0, self.frame.size.width * self.progress, self.frame.size.height);
        _gradientLayer.startPoint = CGPointMake(0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1, 0);
        _gradientLayer.anchorPoint = CGPointMake(0, 0);
        _gradientLayer.colors = self.colorArr;
        _gradientLayer.cornerRadius = self.frame.size.height / 2.;
    }
    return _gradientLayer;
}

- (CABasicAnimation *)basicAnimation {
    if (!_basicAnimation) {
        _basicAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        _basicAnimation.duration = 1.0;
        _basicAnimation.fillMode = kCAFillModeForwards;
        _basicAnimation.repeatCount = 1.0;
        _basicAnimation.delegate = self;
        _basicAnimation.removedOnCompletion = NO;
        _basicAnimation.fillMode = kCAFillModeForwards;
        _basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    }
    return _basicAnimation;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _backView.backgroundColor = self.backgroundProgressColor;
        _backView.layer.cornerRadius = self.frame.size.height / 2.;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}

@end
