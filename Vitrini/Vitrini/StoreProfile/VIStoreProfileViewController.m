//
//  VIStoreProfileViewController.m
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 2/3/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIStoreProfileViewController.h"
#import "VIProductsCollectionCell.h"
#import "VIStoreProfileHeaderCollectionReusableView.h"
#import "VIStoreShowProductViewController.h"
#import "VIServer.h"
#import "VIStorage.h"
#import "VIProduct.h"
#import "VICardInfoViewController.h"

#import <MapKit/MapKit.h>
@import AddressBook;

@interface VIStoreProfileViewController ()

@property (weak, nonatomic) IBOutlet UIView *statuBarBackground;
@property (nonatomic, weak) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) UIView *backgroundHeader;

@property (nonatomic) CGFloat lastContentOffset;

@property (nonatomic) VIStore *storeWithCompleteInfo;

@end

@implementation VIStoreProfileViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.statuBarBackground.frame.size.height, self.statuBarBackground.frame.size.width, 1)];
    [line setBackgroundColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.4f]];
    [line setAlpha:1.0f];
    [self.statuBarBackground addSubview:line];
    
    self.statuBarBackground.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.2f];
    self.statuBarBackground.alpha = 0.0f;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    _backgroundHeader = [[UIView alloc] initWithFrame:CGRectMake(0, -400, self.view.frame.size.width, 400)];
    [_backgroundHeader setBackgroundColor:[UIColor colorWithRed:22/255.0f green:22/255.0f blue:25/255.0f alpha:1.0f]];
    [_backgroundHeader setAlpha:1.0f];
    [self.collectionView addSubview:_backgroundHeader];
    
    //baixar a loja completa do server
    [self getCompleteStoreInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Back Button Pressed - dismiss ViewController

- (IBAction)backButtonPressed:(id)sender
{
    _backgroundHeader.alpha = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Get Complete Store Info

-(void) getCompleteStoreInfo
{
    //todo
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //[_activityIndicator startAnimating];
    //---------------------------------
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Call your function or whatever work that needs to be done
        //Code in this part is run on a background thread
        VIServer *server = [[VIServer alloc]init];
        VIResponse *response = [server getStoreWithID:self.actualStore.storeID andUserEmail:[VIStorage sharedStorage].user.email];
        VIResponse *response2 = [server getProductsOfStore:self.actualStore.storeID andPage:0]; //_actualStore.storeID
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            //Stop your activity indicator or anything else with the GUI
            //Code here is run on the main thread
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            //[_activityIndicator stopAnimating];
            
            //tratar algo se precisar
            if (response.status == VIRequestSuccess && response2.status == VIRequestSuccess) {
                //pegar dados da loja
                _storeWithCompleteInfo = [[VIStore alloc]initWithDictionary:response.value];
                
                //pegar os produtos
                _storeWithCompleteInfo.products = [[VIStorage sharedStorage] createProductsWithResponse:response2];
                
                //todo: jogar na tela as paradas
                [_collectionView reloadData];
                
                
                
            }
            else {
                UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Erro de conexao" message:@"Conecte-se a internet e tente novamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alerta show];
            }
            
        });
    });
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.storeWithCompleteInfo.products count];
}

#pragma mark UICollectionViewCell

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    VIProductsCollectionCell *cell = (VIProductsCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    VIProduct *product = [self.storeWithCompleteInfo.products objectAtIndex:indexPath.row];
    
    [cell mountWithProduct:product];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"CLICOU: %ld \n OBJETO: %@", (long)indexPath.row, [self.storeWithCompleteInfo.products objectAtIndex:indexPath.row]);
    [self goToStoreProduct: [self.storeWithCompleteInfo.products objectAtIndex:indexPath.row]];
}

#pragma mark Go To Store Product

- (void)goToStoreProduct:(VIProduct *)product
{
    UIStoryboard *cards = [UIStoryboard storyboardWithName:@"Cards" bundle:nil];
    VICardInfoViewController *info = [cards instantiateViewControllerWithIdentifier:@"VICardInfoViewControllerID"];
    info.product = product;
    [self presentViewController:info animated:YES completion:nil];
    
//    NSLog(@"goToStoreProduct");
//    
//    UIStoryboard *storeShowProduct = [UIStoryboard storyboardWithName:@"VIStoreShowProduct" bundle:nil];
//    VIStoreShowProductViewController *productVC = (VIStoreShowProductViewController *) [storeShowProduct instantiateViewControllerWithIdentifier:@"VIStoreShowProductViewControllerID"];
//   
//    productVC.infors = @{
//                         @"title" : @"Titulo do Produto", // add product.name
//                         @"price" : @"R$119,00", // product.price
//                         @"desc" : @"Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.", // product.descricao
//                         @"photos" : @[@"img3", @"img2", @"img4", @"img1"], // product.images
//                         };
//    
    //falta colocar os dados no servidor...
//    productVC.infors = @{
//                         @"title" : product.name,
//                         @"price" : [NSString stringWithFormat:@"R$%f.2", product.price],
//                         @"desc" : product.descricao,
//                         @"photos" : product.images,
//                         };
    
//    [self presentViewController:productVC animated:YES completion:nil];
}

#pragma mark UICollectionReusableView

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    VIStoreProfileHeaderCollectionReusableView* cellHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    
    self.navigationBar.topItem.title = _storeWithCompleteInfo.name;
    
    cellHeader.backgroundLoja.activityIndicatorStyle = UIActivityIndicatorViewStyleWhiteLarge;
    cellHeader.backgroundLoja.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://107.170.189.125/vitrini/default/download/db/%@", _storeWithCompleteInfo.imageName]];
    
    cellHeader.logoLoja.activityIndicatorStyle = UIActivityIndicatorViewStyleWhiteLarge;
    cellHeader.logoLoja.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://107.170.189.125/vitrini/default/download/db/%@", _storeWithCompleteInfo.imageName]];
    cellHeader.logoLoja.clipsToBounds = YES;
    cellHeader.logoLoja.layer.cornerRadius = 62.0f;
    
    cellHeader.descricaoLoja.text = _storeWithCompleteInfo.resume;
    cellHeader.descricaoLoja.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    cellHeader.descricaoLoja.font = [UIFont boldSystemFontOfSize:13];
    cellHeader.descricaoLoja.textColor = [UIColor whiteColor];
    cellHeader.descricaoLoja.tintColor = [UIColor whiteColor];
    cellHeader.descricaoLoja.scrollEnabled = NO;
    cellHeader.descricaoLoja.pagingEnabled = NO;
    cellHeader.descricaoLoja.editable = NO;
    
    if (_storeWithCompleteInfo.isFollowing) {
        NSLog(@"Estou Seguindo a Loja");
        [cellHeader.seguirLoja setTitle:@"Seguindo" forState:UIControlStateNormal];
    } else {
        NSLog(@">> NÃO estou seguindo a loja");
        [cellHeader.seguirLoja setTitle:@"Seguir" forState:UIControlStateNormal];
    }
    
    [cellHeader.seguirLoja addTarget:self action:@selector(seguirAction:) forControlEvents:UIControlEventTouchUpInside];
    [cellHeader.localizacaoLoja addTarget:self action:@selector(localizacaoAction) forControlEvents:UIControlEventTouchUpInside];
    
    return cellHeader;
}

#pragma mark Follow Action Button

- (void)seguirAction:(UIButton *)botao
{
    if ([[botao.titleLabel text] isEqual: @"Seguir"]) {
        [self goFollow:YES];
        [botao setTitle:@"Seguindo" forState:UIControlStateNormal];
    } else {
        [self goFollow:NO];
        [botao setTitle:@"Seguir" forState:UIControlStateNormal];
    }
}

-(void)goFollow:(BOOL)boolToFollow{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        VIServer *server = [[VIServer alloc]init];
        VIResponse *response;
        @try {
            response = [server user:[VIStorage sharedStorage].user.email willFollow:boolToFollow store:_actualStore.storeID];
        }
        @catch (NSException *exception) {
            NSLog(@"Erro de conexão");
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            if (response.status == VIRequestSuccess) {
                NSLog(@"operacao feita com sucesso");
            }
            
        });
    });
}

#pragma mark Location Action Button

- (void)localizacaoAction{
    NSLog(@"localizacaoAction");
    
    if (_storeWithCompleteInfo) {
        if (_storeWithCompleteInfo.latitude == 0 && _storeWithCompleteInfo.longitude == 0) {
            NSString *addr = [NSString stringWithFormat:@"https://www.google.com.br/maps/search/%@",_storeWithCompleteInfo.address];
            NSURL *URL = [NSURL URLWithString:addr];
            [[UIApplication sharedApplication] openURL:URL];
        } else {
            CLLocationCoordinate2D cordinate = CLLocationCoordinate2DMake(_storeWithCompleteInfo.latitude, _storeWithCompleteInfo.longitude);
            MKPlacemark *placemark = [[MKPlacemark alloc]initWithCoordinate:cordinate
                                                          addressDictionary:@{
                                                                              [NSString stringWithFormat:@"%@",kABPersonAddressStreetKey]: _storeWithCompleteInfo.address
                                                                              }];
            MKMapItem *mapApp = [[MKMapItem alloc]initWithPlacemark:placemark];
            [mapApp openInMapsWithLaunchOptions:nil];
        }
    }
}

#pragma mark  UICollectionViewDelegate Extra Methods

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
 return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 
 }
 */

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.lastContentOffset = scrollView.contentOffset.y;
}

- (void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > self.lastContentOffset) {
        
        [UIView animateWithDuration:0.2
                              delay: 0.0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.navigationBar.alpha = 0.0;
                             self.statuBarBackground.alpha = 1.0;
                         }
                         completion:nil];
        
    } else{
        [UIView animateWithDuration:0.3
                              delay: 0.0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.navigationBar.alpha = 1.0;
                             self.statuBarBackground.alpha = 0.0;
                         }
                         completion:nil];
    }
}

#pragma mark UIStatusBarStyle

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark Global Menu

-(UIImage *)itemMenuIcon
{
    return [UIImage imageNamed:@"Icon_feed_Menu"];
}

-(NSString *)itemMenuTitle
{
    return @"Store";
}

@end
