//
//  VIProfileTableViewController.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 14/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIProfileTableViewController.h"

#import "VIColor.h"
#import "VIStorage.h"

@interface VIProfileTableViewController ()

@end

@implementation VIProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *statusBarColor = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, 20)];
    statusBarColor.backgroundColor = [VIColor whiteVIColor];
    [self.view addSubview:statusBarColor];
    
    VIUser *user = [VIStorage sharedStorage].user;
    if (!user) {
        @throw [NSException exceptionWithName:@"User" reason:@"Nao tem usuario aqui na tbvc" userInfo:nil];
    } else {
        _label1.text = user.name;
        _label2.text = user.email;
        _label3.text = user.birthday;
        _label4.text = user.city;
        
        _photo.hidden = YES;
    }
    
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backView.image = [UIImage imageNamed:@"viewBackground"];
    [self.view insertSubview:backView atIndex:0];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [_segmentControll setSelectedSegmentIndex:0];
    if (![[VIStorage sharedStorage].user.filterGender isEqualToString:@"M"]) {
        [_segmentControll setSelectedSegmentIndex:1];
    }
}

-(UIImage *)itemMenuIcon {
    return [UIImage imageNamed:@"iconProfile"];
}

-(NSString *)itemMenuTitle {
    return @"Perfil";
}

- (IBAction)genderChanged:(UISegmentedControl *)sender {
    if ([[VIStorage sharedStorage].user.filterGender isEqual:@"M"]) {
        [VIStorage sharedStorage].user.filterGender = @"F";
    } else {
        [VIStorage sharedStorage].user.filterGender = @"M";
    }
}

@end
