//
//  UserOnboardContentViewController.m
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 11/28/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "UserOnboardContentViewController.h"
#import "VIColor.h"

@interface UserOnboardContentViewController ()

@end

@implementation UserOnboardContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [VIColor lightGrayVIColor];
    pageControl.currentPageIndicatorTintColor = [VIColor blackVIColor];
    pageControl.backgroundColor = [VIColor whiteVIColor];
    
//    _imageView.backgroundColor = [UIColor blackColor];
    self.imageView.image = [UIImage imageNamed:self.imageName];
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
