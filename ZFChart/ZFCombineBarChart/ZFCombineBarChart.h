//
//  ZFCombineBarChart.h
//  ZFChartDemo
//
//  Created by zhengxin  on 07/03/2018.
//  Copyright © 2018 zhengxin. All rights reserved.
//

#import "ZFGenericChart.h"
#import "ZFCombineBar.h"
#import "ZFCircleLabel.h"
#import "ZFConst.h"

@class ZFCombineBarChart;

/*********************  ZFCombineBarChartDelegate(ZFCombineBarChart协议方法)  *********************/
@protocol ZFCombineBarChartDelegate <NSObject>

@optional
/**
 *  bar宽度(若不设置，默认为25.f)
 */
- (CGFloat)barWidthInBarChart:(ZFCombineBarChart *)barChart;

/**
 *  组与组之间的间距(若不设置,默认为20.f)
 */
- (CGFloat)paddingForGroupsInBarChart:(ZFCombineBarChart *)barChart;

/**
 *  每组里面，bar与bar之间的间距(若不设置，默认为5.f)(当只有一组数组时，此方法无效)
 */
- (CGFloat)paddingForBarInBarChart:(ZFCombineBarChart *)barChart;

/**
 *  x轴value文本颜色数组(若不设置，则全部返回黑色)
 *
 *  @return 返回UIColor或者NSArray
 *          eg: ①return ZFRed;  若返回UIColor,则全部value文本颜色为红色,当只有一组数据时,只允许返回UIColor
 *              ②return @[ZFRed, ZFOrange, ZFBlue];  若返回数组,则不同类别的bar上的value文本颜色为数组对应下标的颜色
 *
 *          样式看Github文档
 *
 */
- (id)valueTextColorArrayInBarChart:(ZFCombineBarChart *)barChart;

/**
 *  bar渐变色
 *
 *  (PS: 此方法 与 父类代理方法 - (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart 二选一。若同时实现了这两个方法，则会优先执行渐变色)
 *
 *  @return NSArray必须存储ZFGradientAttribute类型
 */
- (NSArray<ZFGradientAttribute *> *)gradientColorArrayInBarChart:(ZFCombineBarChart *)barChart;

/**
 *  用于编写点击bar后需要执行后续代码
 *
 *  @param groupIndex   点击的bar在第几组
 *  @param barIndex     点击的bar在该组的下标
 *  @param bar          当前点击的bar对象
 *  @param circleLabel 当前点击的bar对应的popoverLabel对象
 */
- (void)barChart:(ZFCombineBarChart *)barChart didSelectBarAtGroupIndex:(NSInteger)groupIndex barIndex:(NSInteger)barIndex bar:(ZFCombineBar *)bar circleLabel:(ZFCircleLabel *)circleLabel;

/**
 *  用于编写点击x轴valueLabel后需要执行后续代码
 *
 *  @param groupIndex   点击的label在第几组
 *  @param labelIndex   点击的label在该组的下标
 *  @param circleLabel 当前点击的popoverLabel对象
 */
- (void)barChart:(ZFCombineBarChart *)barChart didSelectPopoverLabelAtGroupIndex:(NSInteger)groupIndex labelIndex:(NSInteger)labelIndex circleLabel:(ZFCircleLabel *)circleLabel;

@end

@interface ZFCombineBarChart : ZFGenericChart

@property (nonatomic, weak) id<ZFCombineBarChartDelegate> delegate;
/** 是否带阴影效果(默认为YES) */
@property (nonatomic, assign) BOOL isShadow;
/** 超过y轴显示最大值时柱状条bar颜色(默认为红色) */
@property (nonatomic, strong) UIColor * overMaxValueBarColor;
/** 在只有一组数据的情况下，bar是否开启独立颜色(默认为NO，该属性只在singleBarChart情况下有效) */
@property (nonatomic, assign) BOOL isMultipleColorInSingleBarChart;


#pragma mark - public method

/**
 *  重绘(每次更新数据后都需要再调一次此方法)
 */
- (void)strokePath;

@end
