// TVPlayerViewController+Notification.h
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/12/01.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "TVPlayerViewController.h"

/**
 *  TVPlayerViewController Cateogry.
 *
 *  處理 TVPlayerViewController Notification handle 的 Categoty.
 */
@interface TVPlayerViewController (Notification)


///-----------------------------------------------------------------------------
/// @name Category methods.
///-----------------------------------------------------------------------------

/**
 *  設置 Notification.
 */
- (void)notification_setup;

/**
 *  移除 Notification.
 */
- (void)notification_remove;

@end
