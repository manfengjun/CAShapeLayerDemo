//
//  ViewController.m
//  CAShapeLayerDemo
//
//  Created by huwei on 2016/12/6.
//  Copyright © 2016年 JUN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, assign) CGFloat frequency;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAShapeLayer * waveSinLayer;
//波浪相关的参数
@property (nonatomic, assign) CGFloat waveWidth;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) CGFloat waveMid;
@property (nonatomic, assign) CGFloat maxAmplitude;

@property (nonatomic, assign) CGFloat phaseShift;
@property (nonatomic, assign) CGFloat phase;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view.layer addSublayer:[self createRegularTriangle]];
    UIBezierPath *circle2path = [[UIBezierPath alloc] init];
    [circle2path addArcWithCenter:CGPointMake(150, 100) radius:15 startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer * circle2ShapeLayer = [CAShapeLayer layer];
    circle2ShapeLayer.strokeColor = [UIColor colorWithRed:147/255.0 green:231/255.0 blue:182/255.0 alpha:1].CGColor;
    circle2ShapeLayer.fillColor = [UIColor blueColor].CGColor;
    circle2ShapeLayer.lineWidth = 1;
    circle2ShapeLayer.lineJoin = kCALineJoinRound;
    circle2ShapeLayer.lineCap = kCALineCapRound;
    circle2ShapeLayer.path = circle2path.CGPath;
    self.view.layer.mask = circle2ShapeLayer;
//    [self.view.layer addSublayer:circle2ShapeLayer];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark ------ 波浪动画
- (void)startLoading
{
    [_displayLink invalidate];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(updateWave:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                       forMode:NSRunLoopCommonModes];
}

- (void)updateWave:(CADisplayLink *)displayLink
{
    self.phase += 8;//逐渐累加初相
    self.waveSinLayer.path = [self createSinPath].CGPath;
}

- (UIBezierPath *)createSinPath
{
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    CGFloat endX = 0;
    for (CGFloat x = 0; x < self.waveWidth + 1; x += 1) {
        endX=x;
        CGFloat y = self.maxAmplitude * sinf(360.0 / _waveWidth * (x  * M_PI / 180) * self.frequency + self.phase * M_PI/ 180) + self.maxAmplitude;
        if (x == 0) {
            [wavePath moveToPoint:CGPointMake(x, y)];
        } else {
            [wavePath addLineToPoint:CGPointMake(x, y)];
        }
    }
    
    CGFloat endY = CGRectGetHeight(self.view.bounds) + 10;
    [wavePath addLineToPoint:CGPointMake(endX, endY)];
    [wavePath addLineToPoint:CGPointMake(0, endY)];
    
    return wavePath;
}
#pragma mark ------ 正三角(未实现)
- (CAShapeLayer *)createRegularTriangle
{
    UIBezierPath *circlepath = [[UIBezierPath alloc] init];
    [circlepath addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer * circleShapeLayer = [CAShapeLayer layer];
    circleShapeLayer.strokeColor = [UIColor colorWithRed:147/255.0 green:231/255.0 blue:182/255.0 alpha:1].CGColor;
    circleShapeLayer.fillColor = [UIColor clearColor].CGColor;
    circleShapeLayer.lineWidth = 1;
    circleShapeLayer.lineJoin = kCALineJoinRound;
    circleShapeLayer.lineCap = kCALineCapRound;
    circleShapeLayer.path = circlepath.CGPath;
    
    
    return circleShapeLayer;

}
#pragma mark ------ 火柴人
- (CAShapeLayer *)createHCR
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor colorWithRed:147/255.0 green:231/255.0 blue:182/255.0 alpha:1].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    return shapeLayer;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
