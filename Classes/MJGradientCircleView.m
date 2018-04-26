//
//  MJGradientCircleView.m
//  MJGradientCircleView
//
//  Created by 刘鹏 on 2018/4/26.
//  Copyright © 2018年 musjoy. All rights reserved.
//

#import "MJGradientCircleView.h"
#import "MJGradientView.h"

@interface MJGradientCircleView ()
@property (nonatomic, strong) MJGradientView *gradientView;     ///< 渐变色视图
@property (nonatomic, strong) CAShapeLayer *layerGradientMask;  ///< 渐变色蒙版图层
@property (nonatomic, strong) CAShapeLayer *layerMask;          ///< 整个视图蒙版图层
@end

@implementation MJGradientCircleView
#pragma mark - Life Circle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultConfig];
        [self viewConfig];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self defaultConfig];
        [self viewConfig];
    }
    return self;
}

#pragma mark - Subjoin
- (void)defaultConfig
{
    // 设置默认值
    _circleBorderWidth = 10;                    // 圆环宽度
    _startAngle = 0;                            // 起始角度
    _endAngle = -1;                             // 起始角度
    _clockwise = YES;                           // 是否顺时针
}

- (void)viewConfig
{
    // 渐变层
    _gradientView = [[MJGradientView alloc] initWithFrame:self.bounds];
    [self addSubview:_gradientView];
    
    // 蒙版层
    _layerGradientMask = [self createCircleLayer];
    _layerMask = [self createCircleLayer];
    
    self.layer.mask = _layerMask;
    _gradientView.layer.mask = _layerGradientMask;
}

/// 绘制圆环路径
- (void)drawCirclePath
{
    _layerGradientMask.path = [self createCirclePathWithRect:_gradientView.bounds].CGPath;
    _layerMask.path = [self createCirclePathWithRect:self.bounds].CGPath;
}

#pragma mark - Private
/// 创建圆环路径
- (UIBezierPath *)createCirclePathWithRect:(CGRect)rect
{
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    CGFloat radius = (MIN(rect.size.width, rect.size.height) - _circleBorderWidth) / 2.0;
    
    CGFloat startAngle = (_startAngle % 360) / 180.0 * M_PI;
    CGFloat endAngle = (_endAngle % 360) / 180.0 * M_PI;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:_clockwise];
    return path;
}

/// 创建圆环层
- (CAShapeLayer *)createCircleLayer
{
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.lineCap = kCALineCapRound;
    layer.lineWidth = _circleBorderWidth;
    return layer;
}

#pragma mark - OverWrite
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = MIN(self.bounds.size.width, self.bounds.size.height);
    _gradientView.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    _gradientView.bounds = CGRectMake(0, 0, width, width);
    
    _layerGradientMask.frame = _gradientView.bounds;
    _layerMask.frame = self.bounds;
    [self drawCirclePath];
}

#pragma mark - Public
/// 动画的改变进度
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    if (animated) {
        [CATransaction begin];
        [CATransaction setDisableActions:!animated];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [CATransaction setAnimationDuration:1];
        self.progress = progress;
        [CATransaction commit];
    } else {
        self.progress = progress;
    }
}

#pragma mark - Set & Get
- (void)setCircleBorderWidth:(CGFloat)circleBorderWidth
{
    _circleBorderWidth = circleBorderWidth;
    
    _layerGradientMask.lineWidth = circleBorderWidth;
    _layerMask.lineWidth = circleBorderWidth;
    [self drawCirclePath];
}

- (void)setStartAngle:(NSInteger)startAngle
{
    _startAngle = startAngle;
    [self drawCirclePath];
}

- (void)setEndAngle:(NSInteger)endAngle
{
    _endAngle = endAngle;
    [self drawCirclePath];
}

- (void)setClockwise:(BOOL)clockwise
{
    _clockwise = clockwise;
    [self drawCirclePath];
}

/// 进度
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    if (progress >= 0 && progress <= 1) {
        _layerGradientMask.strokeStart = 0;
        _layerGradientMask.strokeEnd = progress;
    }
}

- (void)setBeginColor:(UIColor *)beginColor
{
    _beginColor = beginColor;
    _gradientView.beginColor = beginColor;
}

- (void)setEndColor:(UIColor *)endColor
{
    _endColor = endColor;
    _gradientView.endColor = endColor;
}

- (void)setColorAngle:(NSInteger)colorAngle
{
    _colorAngle = colorAngle;
    _gradientView.angle = colorAngle;
}

- (void)setArrColors:(NSArray<UIColor *> *)arrColors
{
    _arrColors = arrColors;
    _gradientView.arrColors = arrColors;
}

- (void)setArrLocations:(NSArray<NSNumber *> *)arrLocations
{
    _arrLocations = arrLocations;
    _gradientView.arrLocations = arrLocations;
}



@end
