//
//  VILikesViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 03/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VILikesViewController.h"
#import "VIColor.h"
#import "VIServer.h"
#import "VIResponse.h"
#import "VIStorage.h"
#import "VILikesCollectionViewCell.h"
#import "VIFilterViewController.h"

@interface VILikesViewController ()

@end

@implementation VILikesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupStatusAndFilter];
}

-(void)viewWillAppear:(BOOL)animated{
    [self getLikesWithCategory:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    // status
    UIView *status = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    status.backgroundColor = [VIColor lightRedVIColor];
    
    [self.view addSubview:status];
    
}

-(void) filterTapDetected
{
    UIStoryboard *filter = [UIStoryboard storyboardWithName:@"Filter" bundle:nil];
    VIFilterViewController *filterVC = (VIFilterViewController *)[filter instantiateInitialViewController];
    filterVC.likesVC = self;
    
    //comando para botar a view por cima e poder ver a debaixo ainda...
    filterVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    //fade view
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4;
    transition.type = kCATransitionFade;
    
    [[[[self view]window]layer] addAnimation:transition forKey:kCATransitionFade];
    
    [self presentViewController:filterVC animated:NO completion:nil];
}

-(UIImage *)itemMenuIcon{
    return [UIImage imageNamed:@"Vitrini_meuslikes_icon"];
}

-(NSString *)itemMenuTitle{
    return @"Likeds";
}

-(void) getLikesWithCategory:(int) categoryID
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_activityIndicator startAnimating];
    //---------------------------------
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Call your function or whatever work that needs to be done
        //Code in this part is run on a background thread
        VIServer *server = [[VIServer alloc]init];
        VIResponse *response = [server getProductsLikedsForUser:[VIStorage sharedStorage].user.email withGender:@"M" andCategory:categoryID];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            //Stop your activity indicator or anything else with the GUI
            //Code here is run on the main thread
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [_activityIndicator stopAnimating];
            
            //tratar algo se precisar
            if (response.status == VIRequestSuccess) {
                _arrayWithProducts = [[VIStorage sharedStorage]createLikesProductsWithResponse:response];
                [_collectionVIew reloadData];
            }
            else {
                UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Erro de conexao" message:@"Conecte-se a internet e tente novamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alerta show];
            }
            
        });
    });
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_arrayWithProducts count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VILikesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VILikesCollectionViewCell" forIndexPath:indexPath];
    [cell mountCellWithProduct:[_arrayWithProducts objectAtIndex: indexPath.row ]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"clicou num produto dos likes");
}

@end
