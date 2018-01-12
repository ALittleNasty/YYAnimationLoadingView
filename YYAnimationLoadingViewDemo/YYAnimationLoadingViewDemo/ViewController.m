//
//  ViewController.m
//  YYAnimationLoadingViewDemo
//
//  Created by ALittleNasty on 2018/1/12.
//  Copyright © 2018年 ALittleNasty. All rights reserved.
//

#import "ViewController.h"
#import "PinwheelLoadingView.h" 
#import "AnimationRectLoadingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)pinwheelButtonAction
{
    [PinwheelLoadingView showAnimationLoading];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PinwheelLoadingView dismissAnimationLoading];
    });
}

- (IBAction)rectButtonAction
{
    [AnimationRectLoadingView showAnimationLoading];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AnimationRectLoadingView dismissAnimationLoading];
    });
}

@end
