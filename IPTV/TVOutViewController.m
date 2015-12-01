// TVOutViewController.m
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/12/01.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "TVOutViewController.h"


@implementation TVOutViewController

#pragma mark - UIViewController
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return ~UIInterfaceOrientationMaskAll;
}

@end
