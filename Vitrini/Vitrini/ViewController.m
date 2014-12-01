//
//  ViewController.m
//  Vitrini
//
//  Created by Willian Pinho on 11/28/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self goToUserOnboard];
}

- (IBAction)goToUserOnboard
{
    UIStoryboard *userOnboard = [UIStoryboard storyboardWithName:@"UserOnboard" bundle:nil];
    UIViewController *userOnboardViewController = [userOnboard instantiateViewControllerWithIdentifier:@"UserOnboardViewControllerID"];
    [self presentViewController:userOnboardViewController animated:YES completion:nil];
    NSLog(@"UserOnboardViewControllerID");
}

@end