// AppDelegate.h
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/12/01.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import <UIKit/UIKit.h>

extern NSString * const kIPTVDataBasePath;

/**
 *  App 進入點
 */
@interface AppDelegate : UIResponder <UIApplicationDelegate>


///-----------------------------------------------------------------------------
/// @name  Properties
///-----------------------------------------------------------------------------

/**
 *  主視窗
 */
@property (strong, nonatomic) UIWindow *window;

@end

