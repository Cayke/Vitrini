//
//  VIStoreProfileViewController.m
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 2/3/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIStoreProfileViewController.h"
#import "VIStoreProfileHeaderCollectionReusableView.h"
#import "VIProductsCollectionCell.h"

#import "VIServer.h"
#import "VIResponse.h"
#import "VIStorage.h"

@interface VIStoreProfileViewController ()

@property (weak, nonatomic) IBOutlet UIView *statuBarBackground;
@property (nonatomic, weak) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIView *backgroundHeader;
@property (nonatomic) BOOL firstTime;

@property (nonatomic) CGFloat lastContentOffset;

@end

@implementation VIStoreProfileViewController {
    NSDictionary *storeDict;
    BOOL getingProducts;
    int page;
    int getPage;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    _collectionView.hidden = YES;
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    _firstTime = YES;
    _dataArray = [[NSMutableArray alloc]init];
    getingProducts = NO;
    page = 0;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
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
    
    // Register cell classes
    //[self.collectionView registerClass:[VIProductsCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    // Do any additional setup after loading the view.
    //self.dataArray = [NSArray arrayWithObjects:@"tumbStore1", @"tumbStore2", @"tumbStore3", @"tumbStore4", @"tumbStore5", @"tumbStore6", @"tumbStore7", @"tumbStore8", @"tumbStore9", @"tumbStore10", @"tumbStore11", @"tumbStore12", @"tumbStore1", @"tumbStore2", @"tumbStore3", @"tumbStore4", @"tumbStore5", @"tumbStore6", @"tumbStore7", @"tumbStore8", @"tumbStore9", @"tumbStore10", @"tumbStore11", @"tumbStore12", nil];
    
    //self.navigationBar.topItem.title = @"Lojas Zara";
    
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    backButton.frame = CGRectMake(10, 0, 30, 42); // custom frame
//    [backButton setImage:[UIImage imageNamed:@"VIStoreProfileNavigationBarBackButton"] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [backButton setTitle:@" " forState:UIControlStateNormal];
//    //set left barButtonItem to backButton
//    //self.navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    [self.navigationBar addSubview:backButton];
    
    [self loadStore];
    [self mountProducts];
}

-(void)loadStore{
    //aqui botamos as coisas na tela
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //------- botar alerta com carregando
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Carregando..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.color = [UIColor orangeColor];
    [indicator startAnimating];
    [alertView setValue:indicator forKey:@"accessoryView"];
    [alertView show];
    //---------------------------------
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Call your function or whatever work that needs to be done
        //Code in this part is run on a background thread
        VIServer *server = [[VIServer alloc]init];
        VIResponse *response;
        
        @try {
            //response = [server getStoreWithID:_storeID andUserEmail:[VIStorage sharedStorage].user.email];
            response = [server getStoreWithID:_storeID andUserEmail:[VIStorage sharedStorage].user.email];
        }
        @catch (NSException *exception) {
            response = nil;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            //Stop your activity indicator or anything else with the GUI
            //Code here is run on the main thread
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
            if (!response) {
                NSLog(@"Erro de conexão");
            } else {
                storeDict = response.value;
                [self mountStore];
            }
            
        });
    });
}

-(void)mountStore{
    _collectionView.hidden = NO;
    self.navigationBar.topItem.title = [storeDict objectForKey:@"name"];
    [_collectionView reloadData];
}

-(void)mountProducts{
    if (!getingProducts) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            VIServer *server = [[VIServer alloc]init];
            VIResponse *response;
            
            @try {
                response = [server getProductsOfStore:_storeID andPage:page];
            } @catch (NSException *exception) {
                response = nil;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                //Stop your activity indicator or anything else with the GUI
                //Code here is run on the main thread
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
                if (!response) {
                    NSLog(@"Erro de conexão");
                } else {
                    NSArray *auxArray = response.value;
                    if (auxArray != nil && [auxArray count] != 0) {
                        [_dataArray addObjectsFromArray:response.value];
                        page++;
                        [_collectionView reloadData];
                    }
                }
                getingProducts = NO;
                
            });
        });
    }
}

- (IBAction)backButtonPressed:(id)sender
{
    _backgroundHeader.alpha = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate Methods

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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataArray count];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    VIStoreProfileHeaderCollectionReusableView* cellHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    
    if (storeDict) {
        cellHeader.backgroundLoja.image = [UIImage imageNamed:@"zaraBack.png"];
        
        AsyncImageView *storeLogo = cellHeader.logoLoja;
        
        NSString *imageName = [storeDict objectForKey:@"photo"];
        storeLogo.activityIndicatorStyle = UIActivityIndicatorViewStyleWhiteLarge;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://107.170.189.125/vitrini/default/download/db/%@", imageName]];
        storeLogo.imageURL = url;
        
        storeLogo.layer.cornerRadius = 62.0;
        storeLogo.clipsToBounds = YES;
        
        cellHeader.descricaoLoja.text = [storeDict objectForKey:@"resume"];
        cellHeader.descricaoLoja.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        cellHeader.descricaoLoja.font = [UIFont boldSystemFontOfSize:13];
        cellHeader.descricaoLoja.textColor = [UIColor whiteColor];
        cellHeader.descricaoLoja.tintColor = [UIColor whiteColor];
        
        cellHeader.descricaoLoja.scrollEnabled = NO;
        cellHeader.descricaoLoja.pagingEnabled = NO;
        cellHeader.descricaoLoja.editable = NO;
        
        if ([[storeDict objectForKey:@"following"]intValue] == 1) {
            [cellHeader.seguirLoja setTitle:@"Seguindo" forState:UIControlStateNormal];
        } else {
            [cellHeader.seguirLoja setTitle:@"Seguir" forState:UIControlStateNormal];
        }
    
        [cellHeader.seguirLoja addTarget:self action:@selector(seguirAction:) forControlEvents:UIControlEventTouchUpInside];
        [cellHeader.localizacaoLoja addTarget:self action:@selector(localizacaoAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cellHeader;
}

- (void)seguirAction:(UIButton *)botao
{
    NSLog(@"seguirAction");
    if ([[botao.titleLabel text] isEqual: @"Seguir"]) {
        [botao setTitle:@"Seguindo" forState:UIControlStateNormal];
    } else {
        [botao setTitle:@"Seguir" forState:UIControlStateNormal];
    }
}

- (void)localizacaoAction{
    NSLog(@"localizacaoAction");
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VIProductsCollectionCell *cell = (VIProductsCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDictionary *auxDict = [_dataArray objectAtIndex:indexPath.row];
    
    [cell mountWithDict:auxDict];
    
//    UIImageView *roupas = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,124,124)];
//    roupas.image = [UIImage imageNamed: [self.dataArray objectAtIndex:indexPath.row]];
//    roupas.tag = 202;
//
//    UILabel *foundLabelBackground = (UILabel *)[cell viewWithTag:202];
//    if (foundLabelBackground) [foundLabelBackground removeFromSuperview];
//
//    [cell addSubview:roupas];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

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

-(UIImage *)itemMenuIcon
{
    return [UIImage imageNamed:@"Icon_feed_Menu"];
}

-(NSString *)itemMenuTitle
{
    return @"Store";
}

@end
