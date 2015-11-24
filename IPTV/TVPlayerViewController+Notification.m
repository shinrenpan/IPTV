//  TVPlayerViewController+Notification.m
//
// Copyright (c) 2015年 Shinren Pan <shinren.pan@gmail.com>

#import "TVOutViewController.h"
#import "TVPlayerViewController+Notification.h"


@implementation TVPlayerViewController (Notification)

- (void)notification_setup
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(_IJKMediaPlaybackIsPreparedToPlayDidChangeNotification:)
                   name:IJKMediaPlaybackIsPreparedToPlayDidChangeNotification object:nil];
    
    [center addObserver:self selector:@selector(_IJKMoviePlayerLoadStateDidChangeNotification:)
                   name:IJKMoviePlayerLoadStateDidChangeNotification object:nil];
    
    [center addObserver:self selector:@selector(_IJKMoviePlayerPlaybackDidFinishNotification:)
                   name:IJKMoviePlayerPlaybackDidFinishNotification object:nil];
    
    // 連接設備
    [center addObserver:self selector:@selector(_screenDidConnectNotification:)
                   name:UIScreenDidConnectNotification object:nil];
    
    // 移除連接
    [center addObserver:self selector:@selector(_screenDidDisconnectNotification:)
                   name:UIScreenDidDisconnectNotification object:nil];
}

- (void)notification_remove
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - Private
- (void)_IJKMediaPlaybackIsPreparedToPlayDidChangeNotification:(NSNotification *)sender
{
    [self.player play];
}

- (void)_IJKMoviePlayerLoadStateDidChangeNotification:(NSNotification *)sender
{
    MPMovieLoadState state = [self.player loadState];
    
    // Buffering ???
    if(state == MPMovieLoadStateStalled)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    else
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

- (void)_IJKMoviePlayerPlaybackDidFinishNotification:(NSNotification *)sender
{
    NSInteger reason =
    [[sender.userInfo valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey]integerValue];
    
    if(reason != MPMovieFinishReasonPlaybackEnded)
    {
        [self showAlertWithMessage:@"無法播放此頻道."];
    }
}

- (void)_screenDidConnectNotification:(NSNotification *)sender
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

- (void)_screenDidDisconnectNotification:(NSNotification *)sender
{
    UIView *playerView = [self.player view];
    playerView.frame   = self.view.bounds;
    
    self.tvoutWindow.hidden             = YES;
    self.tvoutWindow.rootViewController = nil;

    [self.view insertSubview:playerView atIndex:1];
}

@end
