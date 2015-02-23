//
//  VIInitControl.m
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 12/16/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "VIInitControl.h"
#import "VIMainViewController.h"
#import "VILoginViewController.h"
#import "UserOnboardViewController.h"
#import "VIStorage.h"
#import "AppDelegate.h"

@implementation VIInitControl

+(void)start {
    if ([[VIStorage sharedStorage]initUserFromDevice]) {
        [self goToMainApp];
    }
    else
    {
        [self goToUserOnBoard];
    }
}

+ (void)goToMainApp
{
    VIMainViewController *mainTabBarVC = [[VIMainViewController alloc]init];
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDelegate.window setRootViewController:mainTabBarVC];
}

+ (void)goToUserOnBoard
{
    
    UIStoryboard *userOnboard = [UIStoryboard storyboardWithName:@"UserOnboard" bundle:nil];
    UserOnboardViewController *userOnboardViewController = (UserOnboardViewController *)[userOnboard instantiateViewControllerWithIdentifier:@"UserOnboardViewControllerID"];
    
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDelegate.window setRootViewController:userOnboardViewController];
}

+ (void)goToLogin
{
    UIStoryboard *login = [UIStoryboard storyboardWithName:@"VILoginStoryboard" bundle:nil];
    VILoginViewController *loginVC = (VILoginViewController *) [login instantiateInitialViewController];
    
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDelegate.window setRootViewController:loginVC];
    
}

@end
