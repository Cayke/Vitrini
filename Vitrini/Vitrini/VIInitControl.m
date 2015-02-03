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

@implementation VIInitControl

-(void)start {
    [self goToUserOnboard];
}

- (void)goToMainApp
{
    VIMainViewController *mainTabBarVC = [[VIMainViewController alloc]init];
    [self.appDelegate.window setRootViewController:mainTabBarVC];
}

- (void)goToUserOnboard
{
    
    UIStoryboard *userOnboard = [UIStoryboard storyboardWithName:@"UserOnboard" bundle:nil];
    UserOnboardViewController *userOnboardViewController = (UserOnboardViewController *)[userOnboard instantiateViewControllerWithIdentifier:@"UserOnboardViewControllerID"];
    [self.appDelegate.window setRootViewController:userOnboardViewController];    
    userOnboardViewController.initiControl = self;
    
    NSLog(@"appDelegate > chama UserOnboardViewControllerID");
}

- (void)goToLogin
{
    UIStoryboard *login = [UIStoryboard storyboardWithName:@"VILoginStoryboard" bundle:nil];
    VILoginViewController *loginVC = (VILoginViewController *) [login instantiateInitialViewController];
    loginVC.initiControl = self;
    
    [self.appDelegate.window setRootViewController:loginVC];
    
}

@end
