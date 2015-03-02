//
//  VILikedsViewController.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 24/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "VILikedsViewController.h"
#import "VIResponse.h"
#import "VIStorage.h"
#import "VIColor.h"
#import "VIServer.h"
#import "VIProductStore.h"
#import "VIProduct.h"
#import "VILikedProductCell.h"

@interface VILikedsViewController ()

@end

@implementation VILikedsViewController

//todo : botar para os produtos do like serem os do _arrayWithProducts

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *statusBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    statusBar.backgroundColor = [VIColor whiteVIColor];
    [self.view addSubview:statusBar];
    
    [self getLikeds];
    
//    //adicionar refresh control. para poder atualizar os likes pela table view
//    _refresh = [[UIRefreshControl alloc]init];
//    [_refresh addTarget:self action:@selector(getLikeds) forControlEvents:UIControlEventValueChanged];
//    [_collectionView addSubview:_refresh];
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

-(void) getLikeds
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_activityIndicator startAnimating];
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
            [_activityIndicator stopAnimating];
            [_refresh endRefreshing];
            
            //tratar algo se precisar
            if (response.status == VIRequestSuccess) {
                _arrayWithProducts = [NSArray arrayWithArray:response.value];
                [_collectionView reloadData];
            }
            else {
                UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Erro de conexao" message:@"Conecte-se a internet e tente novamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alerta show];
            }
            
        });
    });
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_arrayWithProducts count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VILikedProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VILikedProductCell" forIndexPath:indexPath];
    
    NSDictionary *dic = [_arrayWithProducts objectAtIndex:indexPath.row];
    VIProduct *product = [[VIProduct alloc]initWithProductFromServer:dic];
    [cell mountWithProduct:product];
    
    //BAIXAR A IMAGEM
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat dimension = self.view.frame.size.width/2;
    return CGSizeMake(dimension, dimension);
}
@end
