//
//  ZFGenericChart.m
//  ZFChartView
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZFGenericChart.h"
#import "ZFColor.h"

@interface ZFGenericChart()
@property (nonatomic, readwrite) BOOL isShowHorScreen;

@end

@implementation ZFGenericChart {
    CGRect lastFrame;
    UIView *superView;
}

/**
 *  初始化变量
 */
- (void)commonInit{
    _isShowHorScreen = NO;
    _isAnimated = YES;
    _isShadowForValueLabel = YES;
    _opacity = 1.f;
    _valueOnChartFont = [UIFont systemFontOfSize:10.f];
    _xLineNameLabelToXAxisLinePadding = 0.f;
    _valueLabelPattern = kPopoverLabelPatternPopover;
    _valueType = kValueTypeInteger;
    _isShowAxisLineValue = YES;
    _isShowAxisArrows = YES;
    _numberOfDecimal = 1;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    
    return self;
}

- (void)setUp{
    //标题Label
    self.topicLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, TOPIC_HEIGHT)];
    self.topicLabel.font = [UIFont boldSystemFontOfSize:18.f];
    self.topicLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.topicLabel];
}

#pragma mark - 重写setter,getter方法

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.topicLabel.frame = CGRectMake(CGRectGetMinX(self.topicLabel.frame), CGRectGetMinY(self.topicLabel.frame), self.frame.size.width, CGRectGetHeight(self.topicLabel.frame));
}

/**
 *  重绘(每次更新数据后都需要再调一次此方法)
 *  子类实现功能,父类为空方法
 */
- (void)strokePath{
}

#pragma mark - 横屏显示

- (void)showHorScreen{
    if (_isShowHorScreen) return;
    
    // 更改状态,保存先前的数据
    _isShowHorScreen = YES;
    superView = self.superview;
    lastFrame = self.frame;
    
    // 重绘全屏界面
    [self removeFromSuperview];
    CGFloat x = 0;
    CGFloat y = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat width = [UIApplication sharedApplication].delegate.window.frame.size.height - y;
    CGFloat height = [UIApplication sharedApplication].delegate.window.frame.size.width;
    self.frame = CGRectMake(x, y, width, height);
    [self strokePath];
    [[UIApplication sharedApplication].delegate.window addSubview:self];

    /*
     横屏翻转
     */
    self.center = [UIApplication sharedApplication].delegate.window.center;
    self.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void)dismissHorScreen{
    if (!_isShowHorScreen) return;
    
    // 更改状态
    _isShowHorScreen = NO;

    // 还原横屏旋转
    [self removeFromSuperview];
    self.transform = CGAffineTransformMakeRotation(0);

    // 重绘原始界面
    self.frame = lastFrame;
    [self strokePath];
    [superView addSubview:self];
}

@end
