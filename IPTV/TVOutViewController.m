//  TVOutViewController.m
//
// Copyright (c) 2015年 Shinren Pan <shinren.pan@gmail.com>

#import "TVOutViewController.h"


@implementation TVOutViewController

#pragma mark - Rotate
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return ~UIInterfaceOrientationMaskAll;
}

@end
