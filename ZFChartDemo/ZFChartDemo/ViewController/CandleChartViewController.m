//
//  CandleChartViewController.m
//  ZFChartDemo
//
//  Created by zhengxin  on 2017/9/4.
//  Copyright © 2017年 zhengxin. All rights reserved.
//

#import "CandleChartViewController.h"
#import "ZFChart.h"

@interface CandleChartViewController ()<ZFGenericChartDataSource, ZFCandleChartDelegate>

@property (nonatomic, strong) ZFCandleChart * candleChart;

@property (nonatomic, assign) CGFloat height;

@end

@implementation CandleChartViewController

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
    
    self.candleChart = [[ZFCandleChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _height)];
    self.candleChart.dataSource = self;
    self.candleChart.delegate = self;
    self.candleChart.topicLabel.text = @"xx小学各年级男女人数";
    self.candleChart.unit = @"人";
    self.candleChart.topicLabel.textColor = ZFPurple;
    self.candleChart.isResetAxisLineMinValue = YES;
//        self.candleChart.isAnimated = NO;
//        self.candleChart.valueLabelPattern = kPopoverLabelPatternBlank;
    self.candleChart.isShowXLineSeparate = YES;
    self.candleChart.isShowYLineSeparate = YES;
    //    self.candleChart.isShowAxisLineValue = NO;
    //    self.candleChart.valueCenterToCircleCenterPadding = 0;
    [self.view addSubview:self.candleChart];
    [self.candleChart strokePath];
}

#pragma mark - ZFGenericChartDataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@"123", @"256", @"-157", @"350", @"490", @"236",
             @"123", @"256", @"-157", @"350", @"490", @"236",
             @"123", @"256", @"-157", @"350", @"490", @"236",
             @"123", @"256", @"-157", @"350", @"490", @"236"];
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@"一年级", @"二年级", @"三年级", @"四年级", @"五年级", @"六年级",
             @"一年级", @"二年级", @"三年级", @"四年级", @"五年级", @"六年级",
             @"一年级", @"二年级", @"三年级", @"四年级", @"五年级", @"六年级",
             @"一年级", @"二年级", @"三年级", @"四年级", @"五年级", @"六年级"];
}

- (NSArray *)maxValueArrayInCandleChart:(ZFGenericChart *)chart{
    return @[@"130", @"270", @"-100", @"400", @"500", @"336",
             @"130", @"270", @"-100", @"400", @"500", @"336",
             @"130", @"270", @"-100", @"400", @"500", @"336",
             @"130", @"270", @"-100", @"400", @"500", @"336"];
}

- (NSArray *)minValueArrayInCandleChart:(ZFGenericChart *)chart{
    return @[@"100", @"240", @"-170", @"320", @"450", @"206",
             @"100", @"240", @"-170", @"320", @"450", @"206",
             @"100", @"240", @"-170", @"320", @"450", @"206",
             @"100", @"240", @"-170", @"320", @"450", @"206"];
}

- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
    return @[ZFSkyBlue];
}

- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart{
    return 500;
}

//- (CGFloat)axisLineMinValueInGenericChart:(ZFGenericChart *)chart{
//    return -200;
//}

- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
    return 10;
}

//- (NSInteger)axisLineStartToDisplayValueAtIndex:(ZFGenericChart *)chart{
//    return -7;
//}

//- (void)genericChartDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"当前偏移量 ------ %f", scrollView.contentOffset.x);
//}

#pragma mark - ZFLineChartDelegate

//- (CGFloat)groupWidthInCandleChart:(ZFCandleChart *)candleChart{
//    return 25.f;
//}
//
//- (CGFloat)paddingForGroupsInCandleChart:(ZFCandleChart *)candleChart{
//    return 20.f;
//}
//
//- (CGFloat)circleRadiusInCandleChart:(ZFCandleChart *)candleChart{
//    return 5.f;
//}
//
//- (CGFloat)candleWidthInCandleChart:(ZFCandleChart *)candleChart{
//    return 2.f;
//}
//
//- (NSArray *)valuePositionInCandleChart:(ZFCandleChart *)candleChart{
//    return @[@(kChartValuePositionOnTop)];
//}

- (void)candleChart:(ZFCandleChart *)candleChart didSelectCircleAtCandleIndex:(NSInteger)candleIndex circleIndex:(NSInteger)circleIndex circle:(ZFCircle *)circle popoverLabel:(ZFPopoverLabel *)popoverLabel{
    NSLog(@"第%ld个", (long)circleIndex);
    
    //可在此处进行circle被点击后的自身部分属性设置,可修改的属性查看ZFCircle.h
        circle.circleColor = ZFRed;
        circle.isAnimated = YES;
        circle.opacity = 0.5;
        [circle strokePath];
    
    //可将isShowAxisLineValue设置为NO，然后执行下句代码进行点击才显示数值
        popoverLabel.hidden = NO;
}

- (void)candleChart:(ZFCandleChart *)candleChart didSelectPopoverLabelAtCandleIndex:(NSInteger)candleIndex circleIndex:(NSInteger)circleIndex popoverLabel:(ZFPopoverLabel *)popoverLabel{
    NSLog(@"第%ld个" ,(long)circleIndex);
    
    //可在此处进行popoverLabel被点击后的自身部分属性设置
    //    popoverLabel.textColor = ZFGold;
    //    [popoverLabel strokePath];
}

#pragma mark - 横竖屏适配(若需要同时横屏,竖屏适配，则添加以下代码，反之不需添加)

/**
 *  PS：size为控制器self.view的size，若图表不是直接添加self.view上，则修改以下的frame值
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator NS_AVAILABLE_IOS(8_0){
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        self.candleChart.frame = CGRectMake(0, 0, size.width, size.height - NAVIGATIONBAR_HEIGHT * 0.5);
    }else{
        self.candleChart.frame = CGRectMake(0, 0, size.width, size.height + NAVIGATIONBAR_HEIGHT * 0.5);
    }
    
    [self.candleChart strokePath];
}


@end
