// TVPlayerViewController.h
// 
// Copyright (c) 2015年 Shinren Pan <shinren.pan@gmail.com>

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaFramework.h>

/// 利用 IJKMediaPlayer 客製化的播放器.
@interface TVPlayerViewController : UIViewController


///-----------------------------------------------------------------------------
/// @name Properties
///-----------------------------------------------------------------------------

/// TV out window.
@property (nonatomic, readonly) UIWindow *tvoutWindow;

/// 播放網址.
@property (nonatomic, strong) NSString *urlString;

/// 播放器.
@property (nonatomic, readonly) id <IJKMediaPlayback> player;


///-----------------------------------------------------------------------------
/// @name Public methods
///-----------------------------------------------------------------------------

/**
 *  顯示錯誤訊息.
 *
 *  @param message 錯誤訊息.
 */
- (void)showAlertWithMessage:(NSString *)message;

@end
