//  AppDelegate.m
//
// Copyright (c) 2015年 Shinren Pan <shinren.pan@gmail.com>

#import "AppDelegate.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self __checkDefaultChannelListExist];
    
    return YES;
}

- (void)__checkDefaultChannelListExist
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *copyPath         = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ChannelList.json"];
    
    if([fileManager fileExistsAtPath:copyPath]) { return; }
    
    NSString *defaultPath = [[NSBundle mainBundle]pathForResource:@"ChannelList" ofType:@"json"];
    
    [fileManager copyItemAtPath:defaultPath toPath:copyPath error:nil];
}

@end
