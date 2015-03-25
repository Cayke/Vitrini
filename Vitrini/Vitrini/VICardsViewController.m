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
#import "VIFilterViewController.h"
#import "VIAllocFilterIcon.h"
#import "VIProductStore.h"

@interface VICardsViewController ()
@end

@implementation VICardsViewController{
    VIDraggableCardsView *draggableBackground;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [VIColor whiteVIColor];
    
    draggableBackground = [[VIDraggableCardsView alloc]initWithFrame:self.view.frame];
    draggableBackground.VICardsVC = self;
    [self.view addSubview:draggableBackground];
    
    //status bar e filtro
    [self setupStatusAndFilter];
}

-(void)viewWillAppear:(BOOL)animated{
    [draggableBackground viewWillAppear];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //NSLog(@"Memory Warning");
}

-(void)setupStatusAndFilter{
    // filter
    CGFloat width = self.view.frame.size.width;
    CGFloat dimension = 78;
    
    UIView *filter = [[UIView alloc]initWithFrame:CGRectMake(width/2 - dimension/2, -(dimension/2)+10, dimension, dimension)];
    filter.backgroundColor = [VIColor lightRedVIColor];
    // deixar circular
    [filter.layer setCornerRadius:(dimension/2)];
    filter.layer.masksToBounds = NO;
    [self.view addSubview:filter];
    //adicionar gesure recognizer na view
    UITapGestureRecognizer *singleTapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filterTapDetected)];
    singleTapView.numberOfTapsRequired = 1;
    [filter setUserInteractionEnabled:YES];
    [filter addGestureRecognizer:singleTapView];
    
    [VIAllocFilterIcon chargeIconOnView:filter];
    
    // status
    UIView *status = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    status.backgroundColor = [VIColor lightRedVIColor];
    
    [self.view addSubview:status];
    
}

-(NSString *)itemMenuTitle{
    return @"Vitrini";
}

-(UIImage *)itemMenuIcon{
    return [UIImage imageNamed:@"Vitrini_Vitrini_icon.png"];
}

-(void) filterTapDetected
{
    UIStoryboard *filter = [UIStoryboard storyboardWithName:@"Filter" bundle:nil];
    VIFilterViewController *filterVC = (VIFilterViewController *)[filter instantiateInitialViewController];
    filterVC.categoryOnFilter =  [VIProductStore sharedStore].category_id;
    filterVC.vcDelegate = draggableBackground;
    
    //comando para botar a view por cima e poder ver a debaixo ainda...
    filterVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    //fade view
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4;
    transition.type = kCATransitionFade;
    
    [[[[self view]window]layer] addAnimation:transition forKey:kCATransitionFade];
    
    [self presentViewController:filterVC animated:NO completion:nil];
}
@end
