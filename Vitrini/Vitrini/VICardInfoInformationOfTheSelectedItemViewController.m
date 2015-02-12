//
//  VICardInfoInformationOfTheSelectedItemViewController.m
//  Vitrini
//
//  Created by Willian Pinho on 2/8/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VICardInfoInformationOfTheSelectedItemViewController.h"
#import "VIColor.h"

@interface VICardInfoInformationOfTheSelectedItemViewController ()

@end

@implementation VICardInfoInformationOfTheSelectedItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [back setTintColor:[VIColor blueVIColor]];
    self.navigationItem.leftBarButtonItem = back;
    self.navBar.items = [NSArray arrayWithObject:self.navigationItem];
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

-(void) back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
