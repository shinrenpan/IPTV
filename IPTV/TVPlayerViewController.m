// TVPlayerViewController.m
// 
// Copyright (c) 2015年 Shinren Pan <shinren.pan@gmail.com>

#import "TVPlayerViewController.h"
#import "TVPlayerViewController+Notification.h"

@interface TVPlayerViewController ()

@property (nonatomic, strong) UIWindow *tvoutWindow;
@property (nonatomic, strong) id <IJKMediaPlayback> player;

@end


@implementation TVPlayerViewController

#pragma mark - LifeCycle
- (void)dealloc
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [UIApplication sharedApplication].idleTimerDisabled = NO;
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
- (IBAction)tapScreenOnce:(UITapGestureRecognizer *)sender
{
    self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (IBAction)rightItemClicked:(UIBarButtonItem *)sender
{
    NSInteger scalingMode = [_player scalingMode];
    scalingMode++;
    
    if(scalingMode > MPMovieScalingModeFill) { scalingMode = MPMovieScalingModeNone ;}
    
    [_player setScalingMode:scalingMode];
}

#pragma mark - Public
- (void)showAlertWithMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"錯誤"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:OK];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Private
- (void)__setup
{
    _tvoutWindow = [[UIWindow alloc]init];
    NSURL *URL   = [NSURL URLWithString:_urlString];
    _player      = [[IJKFFMoviePlayerController alloc]initWithContentURL:URL withOptions:nil];
    
    UIView *playerView          = [_player view];
    playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    playerView.frame            = self.view.bounds;
    playerView.backgroundColor  = [UIColor blackColor];
    
    [self.view insertSubview:playerView atIndex:1];
    [_player setScalingMode:MPMovieScalingModeAspectFit];
    [self notification_setup];
}

@end
