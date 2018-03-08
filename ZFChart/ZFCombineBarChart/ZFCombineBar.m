//
//  ZFCombineBar.m
//  ZFChartDemo
//
//  Created by zhengxin  on 07/03/2018.
//  Copyright © 2018 zhengxin. All rights reserved.
//

#import "ZFCombineBar.h"

@interface ZFCombineBar()


/** 不填充矩形的线宽 */
@property (nonatomic, assign) CGFloat borderWidth;
/** bar高度上限 */
@property (nonatomic, assign) CGFloat barHeightLimit;
/** 动画时间 */
@property (nonatomic, assign) CGFloat animationDuration;

@end

@implementation ZFCombineBar

/**
 *  初始化默认变量
 */
- (void)commonInit{
    _barHeightLimit = self.frame.size.height;
    _percents = [NSArray new];
    _animationDuration = 0.5f;
    _isShadow = YES;
    _barPadding = ZFAxisLinePaddingForBarLength;
    _shadowColor = ZFLightGray;
    _borderWidth = 2.0f;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

#pragma mark - bar

/**
 *  未填充
 *
 *  @return UIBezierPath
 */
- (UIBezierPath *)noFill{
    UIBezierPath * bezier = [UIBezierPath bezierPathWithRect:CGRectMake(0, _barHeightLimit, self.frame.size.width, 0)];
    return bezier;
}

/**
 *  填充
 *
 *  @return UIBezierPath
 */
- (UIBezierPath *)fill{
    UIBezierPath * bezier = [UIBezierPath bezierPath];

    _endYPos = _barHeightLimit;
    for (NSInteger i = 0; i < self.percents.count; i++) {
        if ([self.percents[i] floatValue] == 0.0f) {
            continue;
        }
        CGFloat currentHeight = _barHeightLimit * [self.percents[i] floatValue] - _barPadding;
        _endYPos -= currentHeight;
        // 设定Bar最底部部分为不填充.其他为填充类型
        // TODO: 如需自定义,需要重新设置参数,推荐用delegate方式
        if (i == 0) {
            [bezier moveToPoint:CGPointMake(0, _endYPos)];
            [bezier addLineToPoint:CGPointMake(0, _endYPos + _borderWidth)];
            [bezier addLineToPoint:CGPointMake(self.frame.size.width, _endYPos + _borderWidth)];
            [bezier addLineToPoint:CGPointMake(self.frame.size.width, _endYPos)];
            [bezier addLineToPoint:CGPointMake(0, _endYPos)];
            
            [bezier moveToPoint:CGPointMake(0, _endYPos + _borderWidth)];
            [bezier addLineToPoint:CGPointMake(0, _endYPos + currentHeight)];
            [bezier addLineToPoint:CGPointMake(self.frame.size.width, _endYPos + currentHeight)];
            [bezier addLineToPoint:CGPointMake(self.frame.size.width, _endYPos + _borderWidth)];
            [bezier addLineToPoint:CGPointMake(self.frame.size.width - _borderWidth, _endYPos + _borderWidth)];
            [bezier addLineToPoint:CGPointMake(self.frame.size.width - _borderWidth, _endYPos + currentHeight - _borderWidth)];
            [bezier addLineToPoint:CGPointMake(_borderWidth, _endYPos + currentHeight - _borderWidth)];
            [bezier addLineToPoint:CGPointMake(_borderWidth, _endYPos + _borderWidth)];
            [bezier addLineToPoint:CGPointMake(0, _endYPos + _borderWidth)];
        } else {
            [bezier moveToPoint:CGPointMake(0, _endYPos)];
            [bezier addLineToPoint:CGPointMake(0, _endYPos + currentHeight)];
            [bezier addLineToPoint:CGPointMake(self.frame.size.width, _endYPos + currentHeight)];
            [bezier addLineToPoint:CGPointMake(self.frame.size.width, _endYPos)];
            [bezier addLineToPoint:CGPointMake(0, _endYPos)];
        }
        _endYPos -= _barPadding;
    }
    return bezier;
}

/**
 *  CAShapeLayer
 *
 *  @return CAShapeLayer
 */
- (CAShapeLayer *)shapeLayer{
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.fillColor = _barColor.CGColor;
    layer.lineCap = kCALineCapRound;
    layer.path = [self fill].CGPath;
    layer.opacity = _opacity;
    
    if (_isShadow) {
        layer.shadowOpacity = 0.5f;
        layer.shadowColor = _shadowColor.CGColor;
        layer.shadowOffset = CGSizeMake(2, 1);
    }
    
    if (_isAnimated) {
        CABasicAnimation * animation = [self animation];
        [layer addAnimation:animation forKey:nil];
    }
    
    return layer;
}

/**
 *  渐变色
 */
- (CALayer *)barGradientColor{
    CALayer * layer = [CALayer layer];
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    gradientLayer.colors = _gradientAttribute.colors;
    gradientLayer.locations = _gradientAttribute.locations;
    gradientLayer.startPoint = _gradientAttribute.startPoint;
    gradientLayer.endPoint = _gradientAttribute.endPoint;
    [layer addSublayer:gradientLayer];
    layer.mask = [self shapeLayer];
    
    return layer;
}

#pragma mark - 动画

/**
 *  填充动画过程
 *
 *  @return CABasicAnimation
 */
- (CABasicAnimation *)animation{
    CABasicAnimation * fillAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    fillAnimation.duration = _animationDuration;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.removedOnCompletion = NO;
    fillAnimation.fromValue = (__bridge id)([self noFill].CGPath);
    fillAnimation.toValue = (__bridge id)([self fill].CGPath);
    
    return fillAnimation;
}

/**
 *  清除之前所有subLayers
 */
- (void)removeAllLayer{
    NSArray * sublayers = [NSArray arrayWithArray:self.layer.sublayers];
    for (CALayer * layer in sublayers) {
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
    }
}

#pragma mark - public method

/**
 *  重绘
 */
- (void)strokePath{
    [self removeAllLayer];
    [self.layer addSublayer:[self shapeLayer]];
    
    if (_gradientAttribute) {
        [self.layer addSublayer:[self barGradientColor]];
    }
}

@end
