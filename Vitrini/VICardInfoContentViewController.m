//
//  VICardInfoContentViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 06/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VICardInfoContentViewController.h"

@interface VICardInfoContentViewController ()

@end

@implementation VICardInfoContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    _photoImageView.activityIndicatorStyle = UIActivityIndicatorViewStyleGray;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://107.170.189.125/vitrini/default/download/db/%@", _imageFile]];
    _photoImageView.imageURL = url;
    
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
