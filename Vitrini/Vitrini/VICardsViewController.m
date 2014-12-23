//
//  VICardsViewController.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Vitrini. All rights reserved.
//

#import "VICardsViewController.h"
#import "VIDraggableCardsView.h"

@interface VICardsViewController ()
@end

@implementation VICardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    VIDraggableCardsView *draggableBackground = [[VIDraggableCardsView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:draggableBackground];
    
    //status bar e filtro
    [self setupStatusAndFilter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"Memory Warning");
}

-(void)setupStatusAndFilter{
    // filter
    CGFloat width = self.view.frame.size.width;
    CGFloat dimension = 78;
    
    UIView *filter = [[UIView alloc]initWithFrame:CGRectMake(width/2 - dimension/2, -(dimension/2)+10, dimension, dimension)];
    filter.backgroundColor = [UIColor colorWithRed:23.0f/255.0 green:48.0f/255.0f blue:71.0f/255.0f alpha:1.0];
    // deixar circular
    [filter.layer setCornerRadius:(dimension/2)];
    filter.layer.masksToBounds = NO;
    [self.view addSubview:filter];
    
    
    // status
    UIView *status = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    status.backgroundColor = [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0f];
    
    [self.view addSubview:status];
}

-(NSString *)itemMenuTitle{
    return @"Vitrini";
}

-(UIImage *)itemMenuIcon{
    return [UIImage imageNamed:@"img1.png"];
}
@end
