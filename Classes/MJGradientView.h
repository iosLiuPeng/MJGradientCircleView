//
//  MJGradientView.h
//  MJGradientView
//
//  Created by 刘鹏 on 2018/4/26.
//  Copyright © 2018年 musjoy. All rights reserved.
//  渐变色视图

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface MJGradientView : UIView
@property (nonatomic, strong) IBInspectable UIColor *beginColor;///< 开始颜色
@property (nonatomic, strong) IBInspectable UIColor *endColor;  ///< 结束颜色
@property (nonatomic, assign) IBInspectable NSInteger angle;    ///< 角度（默认0°，水平从左到右，角度变大时按逆时针方向旋转）

@property (nonatomic, strong) NSArray <UIColor *> *arrColors;///< 颜色数组（指定后，忽略前面的开始颜色、结束颜色）
@property (nonatomic, strong) NSArray <NSNumber *> *arrLocations;///< 颜色分隔数组（指定的每个颜色从什么位置开始分隔）
@end
