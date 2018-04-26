//
//  MJGradientCircleView.h
//  MJGradientCircleView
//
//  Created by 刘鹏 on 2018/4/26.
//  Copyright © 2018年 musjoy. All rights reserved.
//  渐变色圆环

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface MJGradientCircleView : UIView
/* 渐变色属性 */
@property (nonatomic, strong) IBInspectable UIColor *beginColor;        ///< 开始颜色
@property (nonatomic, strong) IBInspectable UIColor *endColor;          ///< 结束颜色
@property (nonatomic, assign) IBInspectable NSInteger colorAngle;       ///< 颜色渐变角度（默认0°，水平从左到右，角度变大时按逆时针方向旋转）
@property (nonatomic, strong) NSArray <UIColor *> *arrColors;           ///< 渐变色数组（指定后，忽略前面的开始颜色、结束颜色）
@property (nonatomic, strong) NSArray <NSNumber *> *arrLocations;       ///< 渐变色分隔数组（指定的每个颜色从什么位置开始分隔）

/* 圆环属性 */
@property (nonatomic, assign) IBInspectable CGFloat circleBorderWidth;  ///< 圆环宽度
@property (nonatomic, assign) IBInspectable NSInteger startAngle;       ///< 圆环的起始角度
@property (nonatomic, assign) IBInspectable NSInteger endAngle;         ///< 圆环的终止角度
@property (nonatomic, assign) IBInspectable BOOL clockwise;             ///< 是否顺时针
@property (nonatomic, assign) IBInspectable CGFloat progress;           ///< 进度

/// 动画的改变进度
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
@end
