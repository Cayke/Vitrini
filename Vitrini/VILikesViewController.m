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

@interface VILikesViewController ()

@end

@implementation VILikesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *statusBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    statusBar.backgroundColor = [VIColor lightRedVIColor];
    [self.view addSubview:statusBar];
    
    [self getLikes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)itemMenuIcon{
    return [UIImage imageNamed:@"Vitrini_meuslikes_icon"];
}

-(NSString *)itemMenuTitle{
    return @"Likeds";
}

-(void) getLikes
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //[_activityIndicator startAnimating];
    //---------------------------------
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Call your function or whatever work that needs to be done
        //Code in this part is run on a background thread
        VIServer *server = [[VIServer alloc]init];
        VIResponse *response = [server getProductsLikedsForUser:[VIStorage sharedStorage].user.email withGender:@"M" andCategory:0];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            //Stop your activity indicator or anything else with the GUI
            //Code here is run on the main thread
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//            [_activityIndicator stopAnimating];
            
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
