//
//  VIProductsFromCategoryViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 10/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIProductsFromCategoryViewController.h"
#import "VIResponse.h"
#import "VIServer.h"
#import "VIColor.h"
#import "VIStorage.h"
#import "VILikesCollectionViewCell.h"
#import "VIStoreShowProductViewController.h"
#import "VICardInfoViewController.h"

@interface VIProductsFromCategoryViewController ()

@end

@implementation VIProductsFromCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getProducts];
    
    // status
    UIView *status = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    status.backgroundColor = [VIColor lightRedVIColor];
    
    [self.view insertSubview:status belowSubview:_navBar];
    
    self.navBar.topItem.title = _category.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getProducts
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_activityIndicator startAnimating];
    //---------------------------------
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Call your function or whatever work that needs to be done
        //Code in this part is run on a background thread
        VIServer *server = [[VIServer alloc]init];
        
        //todo: usar funcao abaixo..
        VIResponse *response = [server getProductsFromCategoryID:_category.idCategory andPage:0];
        //VIResponse *response = [server getProductsLikedsForUser:[VIStorage sharedStorage].user.email withGender:@"M" andCategory:0];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            //Stop your activity indicator or anything else with the GUI
            //Code here is run on the main thread
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [_activityIndicator stopAnimating];
            
            //tratar algo se precisar
            if (response.status == VIRequestSuccess) {
                _arrayWithProducts = [[VIStorage sharedStorage]createProductsWithResponse:response];
                [_collectionView reloadData];
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
    [self getProductInfo:[_arrayWithProducts objectAtIndex:indexPath.row]];
}

-(void) getProductInfo:(VIProduct *) product
{
    //***********************************************
    //------- botar alerta com carregando
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Carregando..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.color = [VIColor blueVIColor];
    [indicator startAnimating];
    [alertView setValue:indicator forKey:@"accessoryView"];
    [alertView show];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Call your function or whatever work that needs to be done
        //Code in this part is run on a background thread
        
        VIServer *server = [[VIServer alloc]init];
        VIResponse *response = [server getAllInfoFromProduct:product.idProduct];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            //Stop your activity indicator or anything else with the GUI
            //Code here is run on the main thread
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
            //tratar algo se precisar
            if (response.status == VIRequestSuccess) {
                VIProduct *product = [[VIProduct alloc]initToCardWithDict:response.value];
                UIStoryboard *cards = [UIStoryboard storyboardWithName:@"Cards" bundle:nil];
                VICardInfoViewController *info = [cards instantiateViewControllerWithIdentifier:@"VICardInfoViewControllerID"];
                info.product = product;
                [self presentViewController:info animated:YES completion:nil];
            }
            else {
                UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Erro de conexao" message:@"Conecte-se a internet e tente novamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alerta show];
            }
        });
    });
    //****************************************************
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end