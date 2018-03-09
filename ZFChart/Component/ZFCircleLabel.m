//
//  ZFCircleLabel.m
//  ZFChartDemo
//
//  Created by zhengxin  on 09/03/2018.
//  Copyright © 2018 zhengxin. All rights reserved.
//

#import "ZFCircleLabel.h"
#import "UIView+Zirkfied.h"

#define TriAngleHalfLength 2

@interface ZFCircleLabel()

@property (nonatomic, strong) UIImageView * imgview;
/** 动画时间 */
@property (nonatomic, assign) CGFloat animationDuration;

@end

@implementation ZFCircleLabel

/**
 *  初始化变量
 */
- (void)commonInit{
    self.alpha = 0.f;
    _animationDuration = 1.f;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.backgroundColor = ZFClear;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = ZFCircleLabelDiameter / 2.f;
    self.imgview = [[UIImageView alloc] initWithFrame:CGRectMake(ZFCircleLabelDiameter / 4.f, ZFCircleLabelDiameter / 4.f, ZFCircleLabelDiameter / 2.f, ZFCircleLabelDiameter / 2.f)];
    self.imgview.image = [UIImage imageNamed:@"detail"];
    self.imgview.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imgview];
}

#pragma mark - public method

/**
 *  重绘
 */
- (void)strokePath{
    //动画渐现
    if (_isAnimated) {
        [UIView animateWithDuration:_animationDuration animations:^{
            self.alpha = 1.f;
        }];
    }else{
        self.alpha = 1.f;
    }
}

@end
