//
//  AnimationRectLoadingView.m
//  AnimationRectLoadingView
//
//  Created by ALittleNasty on 2018/1/8.
//  Copyright © 2018年 ALittleNasty. All rights reserved.
//

#import "AnimationRectLoadingView.h"

static CGFloat const kRectWidth = 20.f;
static CGFloat const kLoadingWidth = 80.f;
static NSTimeInterval const kAnimationDuration = 2.5f;
static NSString *const kFirstRectAnimationKey = @"firstRectGroupAnimation";
static NSString *const kSecondRectAnimationKey = @"secondRectGroupAnimation";
#define kDefaultBackgroundColor [UIColor blackColor];

@interface AnimationRectLoadingView ()

/** first rect */
@property (nonatomic, strong) UIView  *firstRect;

/** second rect */
@property (nonatomic, strong) UIView  *secondRect;

@end

@implementation AnimationRectLoadingView

#pragma mark - Private Interface

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    _firstRect = [[UIView alloc] init];
    _firstRect.backgroundColor = kDefaultBackgroundColor;
    _firstRect.frame = CGRectMake(0, 0, kRectWidth, kRectWidth);
    [self addSubview:_firstRect]; 
    
    _secondRect = [[UIView alloc] init];
    _secondRect.backgroundColor = kDefaultBackgroundColor;
    _secondRect.frame = CGRectMake(self.bounds.size.width-kRectWidth, self.bounds.size.height-kRectWidth, kRectWidth, kRectWidth);
    [self addSubview:_secondRect];
}

- (void)startAnimation
{
    // 1 if you want to start the loading animation, you must end the previous animation
    [self endAnimation];
    
    // 2 reset frame
    [self resetRectFrame];
    
    
    // 3 first rect's animation
    // 3.1 configure position animation
    CAKeyframeAnimation *f_PositionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *pv0 = [NSValue valueWithCGPoint:CGPointMake(kRectWidth * 0.5, kRectWidth * 0.5)];
    NSValue *pv1 = [NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width - kRectWidth * 0.5, kRectWidth * 0.5)];
    NSValue *pv2 = [NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width - kRectWidth * 0.5, self.bounds.size.height - kRectWidth * 0.5)];
    NSValue *pv3 = [NSValue valueWithCGPoint:CGPointMake(kRectWidth * 0.5, self.bounds.size.height - kRectWidth * 0.5)];
    NSValue *pv4 = [NSValue valueWithCGPoint:CGPointMake(kRectWidth * 0.5, kRectWidth * 0.5)];
    f_PositionAnimation.values = @[pv0, pv1, pv2, pv3, pv4];
    
    // 3.2 configure rotation animation
    CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.values = @[@0, @(M_PI_2), @(M_PI), @(M_PI_2 * 3), @(M_PI * 2)];
    
    // 3.3 configure scale animation
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values = @[@(1.0), @(1.5), @(1.0), @(1.5), @(1.0)]; 
    
    // 3.4 create animation group
    CAAnimationGroup *f_GroupAnimation = [CAAnimationGroup animation];
    f_GroupAnimation.animations = @[f_PositionAnimation, rotationAnimation, scaleAnimation];
    f_GroupAnimation.duration = kAnimationDuration;
    f_GroupAnimation.fillMode = kCAFillModeForwards;
    f_GroupAnimation.removedOnCompletion = NO;
    f_GroupAnimation.repeatCount = MAXFLOAT;
    
    // 3.5 add animation
    [_firstRect.layer addAnimation:f_GroupAnimation forKey:kFirstRectAnimationKey];
    
    // 4 second rect's animation
    CAKeyframeAnimation *s_PositionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    s_PositionAnimation.values = @[pv2, pv3, pv4, pv1, pv2];
    
    CAAnimationGroup *s_GroupAnimation = [CAAnimationGroup animation];
    s_GroupAnimation.animations = @[s_PositionAnimation, rotationAnimation, scaleAnimation];
    s_GroupAnimation.duration = kAnimationDuration;
    s_GroupAnimation.fillMode = kCAFillModeForwards;
    s_GroupAnimation.removedOnCompletion = NO;
    s_GroupAnimation.repeatCount = MAXFLOAT;
    
    [_secondRect.layer addAnimation:s_GroupAnimation forKey:kSecondRectAnimationKey];
}

- (void)endAnimation
{
    [_firstRect.layer removeAnimationForKey:kFirstRectAnimationKey];
    [_secondRect.layer removeAnimationForKey:kSecondRectAnimationKey];
}

- (void)resetRectFrame
{
    _firstRect.frame = CGRectMake(0, 0, kRectWidth, kRectWidth);
    _secondRect.frame = CGRectMake(self.bounds.size.width-kRectWidth, self.bounds.size.height-kRectWidth, kRectWidth, kRectWidth);
}

#pragma mark - Public Interface

+ (instancetype)sharedLoadingView
{
    static AnimationRectLoadingView *loadingView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loadingView = [[self alloc] initWithFrame:CGRectMake(0, 0, kLoadingWidth, kLoadingWidth)];
    });
    return loadingView;
}

+ (void)showAnimationLoading
{
    AnimationRectLoadingView *loadingView = [AnimationRectLoadingView sharedLoadingView];
    loadingView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - kLoadingWidth) * 0.5,
                                   ([UIScreen mainScreen].bounds.size.height - kLoadingWidth) * 0.5,
                                   kLoadingWidth,
                                   kLoadingWidth);
    [[UIApplication sharedApplication].keyWindow addSubview:loadingView];
    [loadingView startAnimation];
}

+ (void)dismissAnimationLoading
{
    AnimationRectLoadingView *loadingView = [AnimationRectLoadingView sharedLoadingView];
    [loadingView endAnimation];
    [loadingView removeFromSuperview];
}

@end
