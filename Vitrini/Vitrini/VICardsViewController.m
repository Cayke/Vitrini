//
//  VICardsViewController.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Vitrini. All rights reserved.
//

#import "VICardsViewController.h"
#import "VIDraggableCardsView.h"
#import "VIColor.h"

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
    filter.backgroundColor = [VIColor primaryColor];
    // deixar circular
    [filter.layer setCornerRadius:(dimension/2)];
    filter.layer.masksToBounds = NO;
    [self.view addSubview:filter];
    
    
    // status
    UIView *status = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    status.backgroundColor = [VIColor whiteViColor];
    
    [self.view addSubview:status];
}

-(NSString *)itemMenuTitle{
    return @"Vitrini";
}

-(UIImage *)itemMenuIcon{
    return [UIImage imageNamed:@"Vitrini.png"];
}
@end
