//
//  MJGradientView.m
//  MJGradientView
//
//  Created by 刘鹏 on 2018/4/26.
//  Copyright © 2018年 musjoy. All rights reserved.
//

#import "MJGradientView.h"

@implementation MJGradientView
#pragma mark - Life Circle
+(Class)layerClass
{
    return [CAGradientLayer class];
}

#pragma mark - Private
- (void)configColors
{
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    
    NSArray *colors = [[NSMutableArray alloc] init];
    if (_arrColors.count) {
        colors = _arrColors;
    } else {
        colors = @[(_beginColor? _beginColor: [UIColor clearColor]), (_endColor? _endColor: [UIColor clearColor])];
    }
    
    NSMutableArray *idColors = [[NSMutableArray alloc] initWithCapacity:colors.count];
    for (UIColor *aColor in colors) {
        [idColors addObject:(id)aColor.CGColor];
    }
    layer.colors = idColors;
    
    if (_arrLocations.count == idColors.count) {
        layer.locations = _arrLocations;
    }
}

#pragma mark - Public
- (void)setAngle:(NSInteger)angle
{
    _angle = angle;
    
    angle = angle % 360;
    if (angle < 0) {
        angle += 360;
    }
    
    // 算法一 （更准确）
    CGPoint end = [self pointForAngle:angle];
    CGPoint start = CGPointMake(-end.x, -end.y);
    CGPoint startPoint = [self transformToGradientSpace:start];
    CGPoint endPoint = [self transformToGradientSpace:end];
    
    //    // 算法二
    //    CGFloat startX = [self pointWithAngle:angle + 0];
    //    CGFloat startY = [self pointWithAngle:angle + 90];
    //    CGFloat endX = [self pointWithAngle:angle + 180];
    //    CGFloat endY = [self pointWithAngle:angle + 270];
    //    CGPoint startPoint = CGPointMake(startX, startY);
    //    CGPoint endPoint = CGPointMake(endX, endY);
    
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
}

#pragma mark - 算法一
- (CGPoint)pointForAngle:(NSInteger)angle
{
    CGFloat radians = angle / 180.0 * M_PI;
    CGFloat x = cos(radians);
    CGFloat y = sin(radians);
    
    if (fabs(x) > fabs(y)) {
        x = x > 0 ? 1 : -1;
        y = x * tan(radians);
    } else {
        y = y > 0 ? 1 : -1;
        x = y / tan(radians);
    }
    return CGPointMake(x, y);
}

- (CGPoint)transformToGradientSpace:(CGPoint)point
{
    CGFloat x = (point.x + 1) * 0.5;
    CGFloat y = 1.0 - (point.y + 1) * 0.5;
    x = [self precisionProcessing:x];
    y = [self precisionProcessing:y];
    return CGPointMake(x, y);
}

/// 精度处理
- (CGFloat)precisionProcessing:(CGFloat)aFloat
{
    NSString *strFloat = [NSString stringWithFormat:@"%.5f", aFloat];
    return [strFloat doubleValue];
}

#pragma mark - 算法二
- (CGFloat)pointWithAngle:(NSInteger)angle
{
    // 由于下面的公式的结果略有偏差，所以这里对45°角做调整，保证45°整数倍的结果都是正确的
    if (angle % 180 == 45) {
        angle -= 45;
    } else if (angle % 180 == 135) {
        angle += 45;
    }
    
    if (angle % 360 == 0) {
        return 0;
    } else {
        return pow(sin(angle / 360.0 * M_PI), 2);
    }
}

#pragma mark - Set & Get
- (void)setBeginColor:(UIColor *)beginColor
{
    _beginColor = beginColor;
    [self configColors];
}

- (void)setEndColor:(UIColor *)endColor
{
    _endColor = endColor;
    [self configColors];
}

- (void)setArrColors:(NSArray<UIColor *> *)arrColors
{
    _arrColors = arrColors;
    [self configColors];
}

- (void)setArrLocations:(NSArray<NSNumber *> *)arrLocations
{
    _arrLocations = arrLocations;
    [self configColors];
}

@end
