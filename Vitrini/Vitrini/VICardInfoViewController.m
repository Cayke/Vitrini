//
//  VICardInfoViewController.m
//  Vitrini
//
//  Created by Willian Pinho on 2/3/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VICardInfoViewController.h"

@interface VICardInfoViewController ()

@end

@implementation VICardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.photoProduct.image = [UIImage imageNamed:self.imageFile];

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

- (IBAction)back:(id)sender {
    
}
@end
