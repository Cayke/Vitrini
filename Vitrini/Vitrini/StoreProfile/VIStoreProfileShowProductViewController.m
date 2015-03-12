//
//  VIStoreProfileShowProductViewController.m
//  Vitrini
//
//  Created by Paulo Magalhães on 3/11/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIStoreProfileShowProductViewController.h"

@interface VIStoreProfileShowProductViewController ()

@end

@implementation VIStoreProfileShowProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    /*
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 0, 70, 42); // custom frame
    [backButton setImage:[UIImage imageNamed:@"VIStoreProfileNavigationBarBackButton"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@" Voltar" forState:UIControlStateNormal];
    //set left barButtonItem to backButton
    //self.navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationBar addSubview:backButton];
    */
}

- (IBAction)backButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
