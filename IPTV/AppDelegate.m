// AppDelegate.m
//
// Created By Shinren Pan <shinnren.pan@gmail.com> on 2015/12/01.
// Copyright (c) 2015年 Shinren Pan. All rights reserved.

#import "AppDelegate.h"

NSString * const kIPTVDataBasePath = @"Documents/ChannelList.plist";


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self __checkDefaultChannelListExist];
    
    return YES;
}

#pragma mark - Private
- (void)__checkDefaultChannelListExist
{
    // 檢查 Documents 底下是否有 ChannelList.json
    // 沒有的話就 Copy 一份
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *copyPath =
    [NSHomeDirectory() stringByAppendingPathComponent:kIPTVDataBasePath];
    
    if([fileManager fileExistsAtPath:copyPath])
    {
        return;
    }
    
    NSString *defaultPath = [[NSBundle mainBundle]pathForResource:@"ChannelList" ofType:@"plist"];
    
    [fileManager copyItemAtPath:defaultPath toPath:copyPath error:nil];
}

@end
