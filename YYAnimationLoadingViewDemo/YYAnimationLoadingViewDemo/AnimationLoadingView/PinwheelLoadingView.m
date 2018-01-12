//
//  PinwheelLoadingView.m
//  AnimationRectLoadingView
//
//  Created by ALittleNasty on 2018/1/9.
//  Copyright © 2018年 ALittleNasty. All rights reserved.
//

#import "PinwheelLoadingView.h"

typedef NS_ENUM(NSInteger, PinwheelSectorDirection) {
  
    PinwheelSectorDirectionTop = 0,
    PinwheelSectorDirectionLeft = 1,
    PinwheelSectorDirectionBottom = 2,
    PinwheelSectorDirectionRight = 3
};

static CGFloat const kSectorWidth = 20.f;
static CGFloat const kSectorHeight = 5.f;
static CGFloat const kPinwheelWidth = 100.f;
static NSTimeInterval const kAnimationDuration = 1.2;
static NSString *const kPinwheelRotationAnimationKey = @"pinwheelRotationAnimationKey";

@interface PinwheelLoadingView ()


@end

@implementation PinwheelLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSublayers];
    }
    return self;
}

- (void)initSublayers
{
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    [self layerWithDirection:PinwheelSectorDirectionTop withSuperViewCenter:center];
    [self layerWithDirection:PinwheelSectorDirectionLeft withSuperViewCenter:center];
    [self layerWithDirection:PinwheelSectorDirectionBottom withSuperViewCenter:center];
    [self layerWithDirection:PinwheelSectorDirectionRight withSuperViewCenter:center];
}

- (CAShapeLayer *)layerWithDirection:(PinwheelSectorDirection)direction withSuperViewCenter:(CGPoint)center
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    CGRect sectorRect = CGRectZero;
    switch (direction) {
        case PinwheelSectorDirectionTop: {
            sectorRect = CGRectMake(center.x, center.y - kSectorWidth, kSectorHeight, kSectorWidth);
            layer.backgroundColor = [UIColor colorWithRed:243.0 / 255.0 green:251.0 / 255.0 blue:15.0 / 255.0 alpha:1.0].CGColor;
            layer.fillColor = [UIColor colorWithRed:243.0 / 255.0 green:251.0 / 255.0 blue:15.0 / 255.0 alpha:1.0].CGColor;
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(center.x, center.y - kSectorWidth * 0.5)
                                                                radius:kSectorWidth * 0.5
                                                            startAngle:M_PI * 3 / 2
                                                              endAngle:M_PI_2
                                                             clockwise:YES];
            [path addLineToPoint:CGPointMake(center.x, center.y - kSectorWidth)];
            layer.path = path.CGPath;
            [self.layer addSublayer:layer];
        }
            break;
        case PinwheelSectorDirectionLeft: {
            sectorRect = CGRectMake(center.x - kSectorWidth, center.y - kSectorHeight, kSectorWidth, kSectorHeight);
            layer.backgroundColor = [UIColor colorWithRed:86.0 / 255.0 green:255.0 / 255.0 blue:236.0 / 255.0 alpha:1.0].CGColor;
            layer.fillColor = [UIColor colorWithRed:86.0 / 255.0 green:255.0 / 255.0 blue:236.0 / 255.0 alpha:1.0].CGColor;
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(center.x - kSectorWidth * 0.5, center.y)
                                                                radius:kSectorWidth * 0.5
                                                            startAngle:M_PI
                                                              endAngle:M_PI * 2
                                                             clockwise:YES];
            [path addLineToPoint:CGPointMake(center.x - kSectorWidth, center.y)];
            layer.path = path.CGPath;
            [self.layer addSublayer:layer];
        }
            break;
        case PinwheelSectorDirectionBottom: {
            sectorRect = CGRectMake(center.x - kSectorHeight, center.y, kSectorHeight, kSectorWidth);
            layer.backgroundColor = [UIColor colorWithRed: 15.0 / 255.0 green:30.0 / 255.0 blue:254.0 / 255.0 alpha:1.0].CGColor;
            layer.fillColor = [UIColor colorWithRed: 15.0 / 255.0 green:30.0 / 255.0 blue:254.0 / 255.0 alpha:1.0].CGColor;
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(center.x, center.y + kSectorWidth * 0.5)
                                                                radius:kSectorWidth * 0.5
                                                            startAngle:M_PI_2
                                                              endAngle:M_PI * 3 / 2
                                                             clockwise:YES];
            [path addLineToPoint:CGPointMake(center.x, center.y + kSectorWidth)];
            layer.path = path.CGPath;
            [self.layer addSublayer:layer];
        }
            break;
        case PinwheelSectorDirectionRight: {
            sectorRect = CGRectMake(center.x, center.y, kSectorWidth, kSectorHeight);
            layer.backgroundColor = [UIColor colorWithRed:244.0 / 255.0 green:0.0 / 255.0 blue:8.0 / 255.0 alpha:1.0].CGColor;
            layer.fillColor = [UIColor colorWithRed:244.0 / 255.0 green:0.0 / 255.0 blue:8.0 / 255.0 alpha:1.0].CGColor;
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(center.x + kSectorWidth * 0.5, center.y)
                                                                radius:kSectorWidth * 0.5
                                                            startAngle:0
                                                              endAngle:M_PI
                                                             clockwise:YES];
            [path addLineToPoint:CGPointMake(center.x + kSectorWidth, center.y)];
            layer.path = path.CGPath;
            [self.layer addSublayer:layer];
        }
            break;
        default:
            break;
    }
    return layer;
}

- (void)startAnimation
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animation];
    rotationAnimation.keyPath = @"transform.rotation";
    rotationAnimation.fromValue = @0;
    rotationAnimation.toValue = @(M_PI * 2);
    rotationAnimation.duration = kAnimationDuration;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:rotationAnimation forKey:kPinwheelRotationAnimationKey];
}

- (void)endAnimation
{
    [self.layer removeAnimationForKey:kPinwheelRotationAnimationKey];
}

#pragma mark - Public Interface

+ (instancetype)sharedLoadingView
{
    static PinwheelLoadingView *pinwheelLoadingView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pinwheelLoadingView = [[self alloc] initWithFrame:CGRectMake(0, 0, kPinwheelWidth, kPinwheelWidth)];
    });
    return pinwheelLoadingView;
}

+ (void)showAnimationLoading
{
    PinwheelLoadingView *loadingView = [PinwheelLoadingView sharedLoadingView];
    loadingView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - kPinwheelWidth) * 0.5,
                                   ([UIScreen mainScreen].bounds.size.height - kPinwheelWidth) * 0.5,
                                   kPinwheelWidth,
                                   kPinwheelWidth);
    [[UIApplication sharedApplication].keyWindow addSubview:loadingView];
    [loadingView startAnimation];
}

+ (void)dismissAnimationLoading
{
    PinwheelLoadingView *loadingView = [PinwheelLoadingView sharedLoadingView];
    [loadingView endAnimation];
    [loadingView removeFromSuperview];
}

@end
