//
//  MichasViewController.m
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 12/17/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "MichasViewController.h"

@interface MichasViewController ()

@end

@implementation MichasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)voltarFiltro:(id)sender {
    NSLog(@"voltei");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
