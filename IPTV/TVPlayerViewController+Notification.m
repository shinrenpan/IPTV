// TVPlayerViewController+Notification.m
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/12/01.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "TVOutViewController.h"
#import "TVPlayerViewController+Notification.h"


@implementation TVPlayerViewController (Notification)

#pragma mark - Public
- (void)notification_setup
{
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self
               selector:@selector(__IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification:)
                   name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:nil];
    
    [center addObserver:self
               selector:@selector(__IJKMPMoviePlayerLoadStateDidChangeNotification:)
                   name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
    
    [center addObserver:self
               selector:@selector(__IJKMPMoviePlayerPlaybackDidFinishNotification:)
                   name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    // 連接設備
    [center addObserver:self
               selector:@selector(__screenDidConnectNotification:)
                   name:UIScreenDidConnectNotification object:nil];
    
    // 移除連接
    [center addObserver:self
               selector:@selector(__screenDidDisconnectNotification:)
                   name:UIScreenDidDisconnectNotification object:nil];
}

- (void)notification_remove
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [UIApplication sharedApplication].idleTimerDisabled = NO;
}

#pragma mark - Private
- (void)__IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification:(NSNotification *)sender
{
    [self.player play];
}

- (void)__IJKMPMoviePlayerLoadStateDidChangeNotification:(NSNotification *)sender
{
    [self setupRightItem];
}

- (void)__IJKMPMoviePlayerPlaybackDidFinishNotification:(NSNotification *)sender
{
    NSInteger reason =
    [[sender.userInfo valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey]integerValue];
    
    if(reason != IJKMPMovieFinishReasonPlaybackEnded)
    {
        [self showAlertWithMessage:@"無法播放此頻道."];
    }
}

- (void)__screenDidConnectNotification:(NSNotification *)sender
{
    UIScreen *screen = sender.object;
    screen.overscanCompensation  = UIScreenOverscanCompensationInsetApplicationFrame;
    
    TVOutViewController *mvc = [[TVOutViewController alloc]init];
    mvc.view.frame           = screen.bounds;
    
    self.tvoutWindow.rootViewController = mvc;
    self.tvoutWindow.screen             = screen;
    self.tvoutWindow.hidden             = NO;
    
    UIView *playerView = [self.player view];
    playerView.frame   = screen.bounds;
    
    [mvc.view addSubview:playerView];
}

- (void)__screenDidDisconnectNotification:(NSNotification *)sender
{
    UIView *playerView = [self.player view];
    playerView.frame   = self.view.bounds;
    
    self.tvoutWindow.hidden             = YES;
    self.tvoutWindow.rootViewController = nil;

    [self.view insertSubview:playerView atIndex:1];
}

@end
