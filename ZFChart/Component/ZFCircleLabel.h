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

/** 是否带动画显示(默认为YES，带动画) */
@property (nonatomic, assign) BOOL isAnimated;


#pragma mark - 下列参数勿修改(Do not modify)

/** self所在第几组 */
@property (nonatomic, assign) NSInteger groupIndex;
/** self所在的位置下标 */
@property (nonatomic, assign) NSInteger labelIndex;
/** 记录数据是否超出上限 */
@property (nonatomic, assign) BOOL isOverrun;

#pragma mark - public method

- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  重绘
 */
- (void)strokePath;

@end
