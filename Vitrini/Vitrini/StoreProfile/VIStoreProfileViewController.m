//
//  VIStoreProfileViewController.m
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 2/3/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIStoreProfileViewController.h"
#import "VIStoreProfileHeaderCollectionReusableView.h"
#import "VIStoreProfileShowProductViewController.h"

@interface VIStoreProfileViewController ()

@property (weak, nonatomic) IBOutlet UIView *statuBarBackground;
@property (nonatomic, weak) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UIView *backgroundHeader;
@property (nonatomic) BOOL firstTime;

@property (nonatomic) CGFloat lastContentOffset;

@end

@implementation VIStoreProfileViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    _firstTime = YES;
    
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
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.dataArray = [NSArray arrayWithObjects:@"tumbStore1", @"tumbStore2", @"tumbStore3", @"tumbStore4", @"tumbStore5", @"tumbStore6", @"tumbStore7", @"tumbStore8", @"tumbStore9", @"tumbStore10", @"tumbStore11", @"tumbStore12", @"tumbStore1", @"tumbStore2", @"tumbStore3", @"tumbStore4", @"tumbStore5", @"tumbStore6", @"tumbStore7", @"tumbStore8", @"tumbStore9", @"tumbStore10", @"tumbStore11", @"tumbStore12", nil];
    
    self.navigationBar.topItem.title = @"Lojas Zara";
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
    return [self.dataArray count];
}

#pragma mark UICollectionViewCell

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *roupas = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,124,124)];
    roupas.image = [UIImage imageNamed: [self.dataArray objectAtIndex:indexPath.row]];
    
    [cell addSubview:roupas];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 124, 124)];
    [button setBackgroundColor: [UIColor clearColor]];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = indexPath.row;
    [cell addSubview:button];
    
    return cell;
}

- (void)buttonPressed:(UIButton *)button
{
    [self performSegueWithIdentifier: @"showProductOnStoreProfile" sender:[self.dataArray objectAtIndex:button.tag]];
    NSLog(@"ImageOfArray: %ld\n%@", (long)button.tag, [self.dataArray objectAtIndex:button.tag]);
}

#pragma mark prepareForSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showProductOnStoreProfile"])
    {
        __unused VIStoreProfileShowProductViewController *controller = [segue destinationViewController];
        controller.view.backgroundColor = [UIColor redColor];
        controller.navigationBar.topItem.title = sender;
        NSLog(@"---->>> sender: %@", sender);
        
//        UIImage *image = [UIImage imageNamed:sender];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        [controller.view addSubview:imageView];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return YES;
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

#pragma mark UICollectionReusableView

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    VIStoreProfileHeaderCollectionReusableView* cellHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    
    if (_firstTime) {
        NSLog(@"_firstTime YES YES YES");
        
        cellHeader.backgroundLoja.image = [UIImage imageNamed:@"zaraBack.png"];
        cellHeader.logoLoja.image = [UIImage imageNamed:@"zaraLogo.png"];
        
        cellHeader.descricaoLoja.text = @"Zara is a Spanish clothing and accessories retailer based in Arteixo, Galicia.";
        cellHeader.descricaoLoja.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        cellHeader.descricaoLoja.font = [UIFont boldSystemFontOfSize:13];
        cellHeader.descricaoLoja.textColor = [UIColor whiteColor];
        cellHeader.descricaoLoja.tintColor = [UIColor whiteColor];
        
        cellHeader.descricaoLoja.scrollEnabled = NO;
        cellHeader.descricaoLoja.pagingEnabled = NO;
        cellHeader.descricaoLoja.editable = NO;
        
        if ([[cellHeader.seguirLoja.titleLabel text] isEqual: @"Seguindo"]) {
            NSLog(@"Estou Seguindo a Loja");
        }
        
        [cellHeader.seguirLoja addTarget:self action:@selector(seguirAction:) forControlEvents:UIControlEventTouchUpInside];
        [cellHeader.localizacaoLoja addTarget:self action:@selector(localizacaoAction) forControlEvents:UIControlEventTouchUpInside];
        
        _firstTime = NO;
    }
    return cellHeader;
}

#pragma mark Follow Action Button

- (void)seguirAction:(UIButton *)botao
{
    NSLog(@"seguirAction");
    if ([[botao.titleLabel text] isEqual: @"Seguir"]) {
        [botao setTitle:@"Seguindo" forState:UIControlStateNormal];
    } else {
        [botao setTitle:@"Seguir" forState:UIControlStateNormal];
    }
}

#pragma mark Location Action Button

- (void)localizacaoAction{
    NSLog(@"localizacaoAction");
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
