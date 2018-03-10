//
//  CombineBarChartViewController.m
//  ZFChartDemo
//
//  Created by zhengxin  on 07/03/2018.
//  Copyright © 2018 zhengxin. All rights reserved.
//

#import "CombineBarChartViewController.h"
#import "ZFCombineBarChart.h"

@interface CombineBarChartViewController ()<ZFGenericChartDataSource, ZFCombineBarChartDelegate>

@property (nonatomic, strong) ZFCombineBarChart * barChart;

@property (nonatomic, assign) CGFloat height;

@end

@implementation CombineBarChartViewController

- (void)setUp{
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        //首次进入控制器为横屏时
        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT * 0.5;
        
    }else{
        //首次进入控制器为竖屏时
        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    
    self.view.backgroundColor = ZFColor(29, 26, 75, 0.75);
    
    self.barChart = [[ZFCombineBarChart alloc] initWithFrame:CGRectMake(0.f, 25.f, SCREEN_WIDTH, _height / 2.f - 50.f)];
    self.barChart.backgroundColor = ZFClear;
    self.barChart.dataSource = self;
    self.barChart.delegate = self;
    //    self.barChart.topicLabel.text = @"xx小学各年级人数";
    //    self.barChart.unit = @"人";
    //    self.barChart.isAnimated = NO;
    //    self.barChart.isResetAxisLineMinValue = YES;
    self.barChart.isResetAxisLineMaxValue = YES;
    //    self.barChart.isShowAxisLineValue = NO;
    //    self.barChart.isShowXLineSeparate = YES;
    self.barChart.isShowYLineSeparate = YES;
    //    self.barChart.topicLabel.textColor = ZFWhite;
    //    self.barChart.unitColor = ZFWhite;
    //    self.barChart.xAxisColor = ZFWhite;
    //    self.barChart.yAxisColor = ZFWhite;
    self.barChart.xAxisColor = ZFClear;
    self.barChart.yAxisColor = ZFClear;
    self.barChart.axisLineNameColor = ZFWhite;
    //    self.barChart.axisLineValueColor = ZFWhite;
    //    self.barChart.backgroundColor = ZFPurple;
    self.barChart.isShowAxisArrows = NO;
    self.barChart.isShowYAxis = NO;
    self.barChart.isShadow = NO;
    self.barChart.isAnimated = YES;
    self.barChart.separateLineStyle = kLineStyleDashLine;
    self.barChart.opacity = 0.2f;
//    self.barChart.axisLineSelectNameFont = [UIFont systemFontOfSize:16.f];
    //    self.barChart.isMultipleColorInSingleBarChart = YES;
    //    self.barChart.separateLineDashPhase = 0.f;
    //    self.barChart.separateLineDashPattern = @[@(5), @(5)];
    
    [self.view addSubview:self.barChart];
    [self.barChart strokePath];
    
    //    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    //    doubleTap.numberOfTouchesRequired = 1;
    //    doubleTap.numberOfTapsRequired = 2;
    //    [self.barChart addGestureRecognizer:doubleTap];
    
}

//- (void)handleDoubleTap:(UITapGestureRecognizer *)tap {
//    if (!self.barChart.isShowHorScreen) {
//        [self.barChart showHorScreen];
//    }
//    else {
//        [self.barChart dismissHorScreen];
//    }
//}

#pragma mark - ZFGenericChartDataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@[@"123", @"0", @"800", @"0", @"490", @"236", @"123", @"0", @"800", @"0", @"490", @"236", @"123", @"0", @"800", @"0", @"490", @"236"],
//             @[@"123", @"256", @"283", @"123", @"256", @"283", @"123", @"256", @"283", @"123", @"256", @"283", @"123", @"256", @"283", @"123", @"256", @"283"],
             @[@"123", @"300", @"300", @"283", @"490", @"236", @"123", @"300", @"300", @"283", @"490", @"236", @"123", @"300", @"300", @"283", @"490", @"236"]];
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@"12月1日", @"12月2日", @"12月17日", @"12月18日", @"12月19日", @"12月20日", @"12月2日", @"2月2日", @"12月23日", @"12月24日", @"12月25日", @"12月26日", @"12月27日", @"12月28日", @"12月29日", @"12月30日", @"12月31日", @"1月1日" ];
}

//- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
//    return @[ZFMagenta];
//
////    return @[ZFRandom, ZFRandom, ZFRandom, ZFRandom, ZFRandom, ZFRandom];
//}

- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart{
    return 800;
}

//- (CGFloat)axisLineMinValueInGenericChart:(ZFGenericChart *)chart{
//    return 50;
//}

- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
    return 3;
}

//- (NSInteger)axisLineStartToDisplayValueAtIndex:(ZFGenericChart *)chart{
//    return -7;
//}

- (void)genericChartDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"当前偏移量 ------ %f", scrollView.contentOffset.x);
}

#pragma mark - ZFCombineBarChartDelegate

//- (CGFloat)barWidthInBarChart:(ZFBarChart *)barChart{
//    return 40.f;
//}

//- (CGFloat)paddingForGroupsInBarChart:(ZFBarChart *)barChart{
//    return 40.f;
//}

//- (id)valueTextColorArrayInBarChart:(ZFGenericChart *)barChart{
//    return ZFBlue;
//}

- (NSArray *)gradientColorArrayInBarChart:(ZFCombineBarChart *)barChart{
    ZFGradientAttribute * gradientAttribute = [[ZFGradientAttribute alloc] init];
    gradientAttribute.colors = @[(id)ZFColor(64, 92, 255, 1).CGColor, (id)ZFColor(0, 255, 249, 1).CGColor];
    gradientAttribute.locations = @[@(0.01), @(0.99)];
    
    return [NSArray arrayWithObjects:gradientAttribute, nil];
}

- (void)barChart:(ZFCombineBarChart *)barChart didSelectBarAtGroupIndex:(NSInteger)groupIndex barIndex:(NSInteger)barIndex bar:(ZFCombineBar *)bar circleLabel:(ZFCircleLabel *)circleLabel{
    NSLog(@"第%ld组========第%ld个",(long)groupIndex,(long)barIndex);
    
    //可在此处进行bar被点击后的自身部分属性设置,可修改的属性查看ZFBar.h
    bar.barColor = ZFGold;
    bar.isAnimated = YES;
    //    bar.opacity = 0.5;
    [bar strokePath];
    
    //可将isShowAxisLineValue设置为NO，然后执行下句代码进行点击才显示数值
    //    popoverLabel.hidden = NO;
}

- (void)barChart:(ZFCombineBarChart *)barChart didSelectPopoverLabelAtGroupIndex:(NSInteger)groupIndex labelIndex:(NSInteger)labelIndex circleLabel:(ZFCircleLabel *)circleLabel{
    NSLog(@"第%ld组========第%ld个",(long)groupIndex,(long)labelIndex);
    
    //可在此处进行popoverLabel被点击后的自身部分属性设置
    //    popoverLabel.textColor = ZFSkyBlue;
    //    [popoverLabel strokePath];
}

#pragma mark - 横竖屏适配(若需要同时横屏,竖屏适配，则添加以下代码，反之不需添加)

/**
 *  PS：size为控制器self.view的size，若图表不是直接添加self.view上，则修改以下的frame值
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator{
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        self.barChart.frame = CGRectMake(0, 0, size.width, size.height - NAVIGATIONBAR_HEIGHT * 0.5);
    }else{
        self.barChart.frame = CGRectMake(0, 0, size.width, size.height + NAVIGATIONBAR_HEIGHT * 0.5);
    }
    
    [self.barChart strokePath];
}

@end
