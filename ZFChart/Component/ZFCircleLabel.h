//
//  ZFCircleLabel.h
//  ZFChartDemo
//
//  Created by zhengxin  on 09/03/2018.
//  Copyright © 2018 zhengxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFConst.h"

@interface ZFCircleLabel : UIControl

#pragma mark - 以下属性可在点击后根据自身需求改动

/** 字体大小 */
@property (nonatomic, strong) UIFont * font;
/** 文本颜色 */
@property (nonatomic, strong) UIColor * textColor;
/** 是否带动画显示(默认为YES，带动画) */
@property (nonatomic, assign) BOOL isAnimated;


#pragma mark - 下列参数勿修改(Do not modify)

/** 文本内容 */
@property (nonatomic, copy) NSString * text;
/** 箭头方向 */
@property (nonatomic, assign) kPopoverLaberArrowsOrientation arrowsOrientation;
/** 样式 */
@property (nonatomic, assign) kPopoverLabelPattern pattern;
/** self所在第几组 */
@property (nonatomic, assign) NSInteger groupIndex;
/** self所在的位置下标 */
@property (nonatomic, assign) NSInteger labelIndex;
/** 记录数据是否超出上限 */
@property (nonatomic, assign) BOOL isOverrun;
/** 是否带阴影效果(默认为YES) */
@property (nonatomic, assign) BOOL isShadow;
/** label阴影颜色(默认为浅灰色) */
@property (nonatomic, strong) UIColor * shadowColor;


#pragma mark - public method

- (instancetype)initWithFrame:(CGRect)frame direction:(kAxisDirection)direction;

/**
 *  重绘
 */
- (void)strokePath;

@end
