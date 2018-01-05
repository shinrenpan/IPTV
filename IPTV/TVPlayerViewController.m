//
//  Copyright (c) 2018年 shinren.pan@gmail.com All rights reserved.
//

#import "TVPlayerViewController.h"

@interface TVPlayerViewController ()<SRPPlayerViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITapGestureRecognizer *tapOnce;
@property (nonatomic, weak) IBOutlet UITapGestureRecognizer *tapTwice;
@property (nonatomic, weak) IBOutlet UILabel *tvConnectedLabel;

@end


@implementation TVPlayerViewController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [_tapOnce requireGestureRecognizerToFail:_tapTwice];
    
    self.navigationItem.rightBarButtonItem = [self __loadingItem];
    self.delegate = self;
    _tvConnectedLabel.hidden = !self.isTVConnected;
}

- (BOOL)prefersStatusBarHidden
{
    return self.navigationController.navigationBarHidden;
}

#pragma mark - IBAction
- (IBAction)tapGestureRecognizerTapOnce:(UITapGestureRecognizer *)sender
{
    self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (IBAction)tapGestureRecognizerTapTwice:(UITapGestureRecognizer *)sender
{
    self.scalingMode++;
}

#pragma mark - SRPPlayerViewControllerDelegate
- (void)playerControllerTVConnected
{
    _tvConnectedLabel.hidden = NO;
}

- (void)playerControllerTVDisconnected
{
    _tvConnectedLabel.hidden = YES;
}

- (void)playerController:(SRPPlayerViewController *)playerController finishReason:(IJKMPMovieFinishReason)reason
{
    if(reason == IJKMPMovieFinishReasonPlaybackError)
    {
        NSString *title   = NSLocalizedString(@"Error!", @"錯誤!");
        NSString *message = NSLocalizedString(@"Channel is not available.", @"無法播放頻道.");
        
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:title
                                            message:message
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        title = NSLocalizedString(@"OK", @"確定");
        
        void (^callback)(UIAlertAction *) = ^(UIAlertAction *action){
            [self.navigationController popViewControllerAnimated:YES];
        };
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:title
                                                     style:UIAlertActionStyleCancel
                                                   handler:callback];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)playerController:(SRPPlayerViewController *)playerController playbackStateChanged:(IJKMPMoviePlaybackState)state
{
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - Private
- (UIBarButtonItem *)__loadingItem
{
    UIActivityIndicatorView *loadingView =
    [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    loadingView.color = [UIColor blueColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:loadingView];
    
    [loadingView startAnimating];
    
    return item;
}

@end
