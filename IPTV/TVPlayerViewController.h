// TVPlayerViewController.h
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/12/01.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaPlayer.h>

/**
 *  利用 IJKMediaPlayer 客製化的播放器.
 */
@interface TVPlayerViewController : UIViewController


///-----------------------------------------------------------------------------
/// @name Properties
///-----------------------------------------------------------------------------

/**
 *  連接外接設備的 Window.
 */
@property (nonatomic, readonly) UIWindow *tvoutWindow;

/**
 *  電視頻道 URL.
 */
@property (nonatomic, strong) NSString *urlString;

/**
 *  IJKMediaPlayer 播放器.
 */
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

/**
 *  改變播放器 Scale 模式.
 */
- (void)changePlayerScaleMode;

/**
 *  設置右上 BarButtonItem
 */
- (void)setupRightItem;

@end
