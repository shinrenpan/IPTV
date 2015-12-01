// TVPlayerViewController.m
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/12/01.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "TVPlayerViewController.h"
#import "TVPlayerViewController+Notification.h"

@interface TVPlayerViewController ()

@property (nonatomic, weak) IBOutlet UITapGestureRecognizer *tapOnce;
@property (nonatomic, weak) IBOutlet UITapGestureRecognizer *tapTwice;

@property (nonatomic, strong) UIWindow *tvoutWindow;
@property (nonatomic, strong) id <IJKMediaPlayback> player;

@end


@implementation TVPlayerViewController

#pragma mark - LifeCycle
- (void)dealloc
{
    [self.player stop];
    [_player shutdown];
    [self notification_remove];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self __setup];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupRightItem];
    
    if(![_player isPlaying])
    {
        [_player prepareToPlay];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return self.navigationController.navigationBarHidden;
}

#pragma mark - IBAction
- (IBAction)tapGestureRecognizerTapOnce:(UITapGestureRecognizer *)sender
{
    self.navigationController.navigationBarHidden =
    !self.navigationController.navigationBarHidden;
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (IBAction)tapGestureRecognizerTapTwice:(UITapGestureRecognizer *)sender
{
    [self changePlayerScaleMode];
}

#pragma mark - Public
- (void)showAlertWithMessage:(NSString *)message
{
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"錯誤"
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OK =
    [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:OK];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)changePlayerScaleMode
{
    NSInteger scalingMode = [_player scalingMode];
    
    scalingMode++;
    
    if(scalingMode > IJKMPMovieScalingModeAspectFill)
    {
        scalingMode = IJKMPMovieScalingModeNone;
    }
    
    [_player setScalingMode:scalingMode];
}

- (void)setupRightItem
{
    UIBarButtonItem *item;
    
    IJKMPMovieLoadState state = [self.player loadState];
    
    if(state == IJKMPMovieLoadStatePlayable || state == IJKMPMovieLoadStateUnknown)
    {
        UIActivityIndicatorView *loading =
        [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        
        loading.color = [UIColor blueColor];
        item = [[UIBarButtonItem alloc]initWithCustomView:loading];
        
        [loading startAnimating];
    }
    else
    {
        item = [[UIBarButtonItem alloc]initWithTitle:@"縮放"
                                               style:UIBarButtonItemStyleDone
                                              target:self
                                              action:@selector(changePlayerScaleMode)];
    }
    
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - Private
- (void)__setup
{
    [_tapOnce requireGestureRecognizerToFail:_tapTwice];
    
    _tvoutWindow = [[UIWindow alloc]init];
    NSURL *URL   = [NSURL URLWithString:_urlString];
    _player      = [[IJKFFMoviePlayerController alloc]initWithContentURL:URL withOptions:nil];
    
    UIView *playerView          = [_player view];
    playerView.frame            = self.view.bounds;
    playerView.backgroundColor  = [UIColor blackColor];
    
    playerView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view insertSubview:playerView atIndex:1];
    [_player setScalingMode:IJKMPMovieScalingModeAspectFit];
    [self notification_setup];
}

@end
