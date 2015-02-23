//
//  VIStoreProfileViewController.m
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 2/3/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIStoreProfileViewController.h"
#import "VIStoreProfileHeaderCollectionReusableView.h"

@interface VIStoreProfileViewController ()

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation VIStoreProfileViewController 

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.dataArray = [NSArray arrayWithObjects:@"Vitrini_Login__0008_BG.png", @"backgroundFilter.png", @"Vitrini_Login__0008_BG.png", @"backgroundFilter.png", @"Vitrini_Login__0008_BG.png", @"backgroundFilter.png", @"Vitrini_Login__0008_BG.png", @"backgroundFilter.png", @"Vitrini_Login__0008_BG.png", @"backgroundFilter.png", @"Vitrini_Login__0008_BG.png", @"backgroundFilter.png", @"Vitrini_Login__0008_BG.png", @"backgroundFilter.png", @"Vitrini_Login__0008_BG.png", @"backgroundFilter.png", @"Vitrini_Login__0008_BG.png", @"backgroundFilter.png", nil];
    
    self.navigationBar.topItem.title = @"";
    self.navigationBar.topItem.leftBarButtonItem.title = @"Back";
    self.navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(btnClicked:)];
    
    [UIView animateWithDuration:2.0
                          delay: 1.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.navigationBar.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:3.0 animations:^{
                             self.navigationBar.alpha = 1.0;
                         }];
                     }];

//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow.png"]
//                                                                   style:UIBarButtonItemStyleBordered
//                                                                  target:self
//                                                                  action:@selector(backAction)];
//    self.navigationBar.topItem.leftBarButtonItem = backButton;
}


- (void)btnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    VIStoreProfileHeaderCollectionReusableView* cellHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    
    cellHeader.backgroundLoja.image = [UIImage imageNamed:@"Vitrini_Login__0008_BG.png"];
    cellHeader.logoLoja.image = [UIImage imageNamed:@"Vitrini_Login__0002_Icom.png"];
    cellHeader.nomeLoja.text = @"Lojas - Vitrini";
    cellHeader.descricaoLoja.text = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    [cellHeader.seguirLoja addTarget:self action:@selector(seguirAction) forControlEvents:UIControlEventTouchUpInside];
    [cellHeader.localizacaoLoja addTarget:self action:@selector(localizacaoAction) forControlEvents:UIControlEventTouchUpInside];
    
    return cellHeader;
}

- (void)seguirAction{
    NSLog(@"seguirAction");
}

- (void)localizacaoAction{
    NSLog(@"localizacaoAction");
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *roupas =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,110,110)];
    roupas.image = [UIImage imageNamed: [self.dataArray objectAtIndex:indexPath.row]];
    roupas.tag = 202;

    UILabel *foundLabelBackground = (UILabel *)[cell viewWithTag:202];
    if (foundLabelBackground) [foundLabelBackground removeFromSuperview];

    [cell addSubview:roupas];
    
//    }
//    CGPoint translation = [collectionView.panGestureRecognizer translationInView:collectionView.superview];
//    if (translation.y > 0) {
//        NSLog(@"DOWN");
//        
//        [UIView animateWithDuration: 0.5
//                              delay: 0.0
//                            options: UIViewAnimationOptionCurveLinear
//                         animations: ^{
//                             //                             self.profileView.alpha = 1.0;
//                             //                             self.profileView.frame.origin.y = -300.0f;
//                             self.profileView.frame = CGRectMake (self.profileView.frame.origin.x,
//                                                                  20,
//                                                                  self.profileView.frame.size.width,
//                                                                  self.profileView.frame.size.height);
//                             
//                             self.collectionView.frame = CGRectMake (self.collectionView.frame.origin.x,
//                                                                     self.profileView.frame.size.height + 30,
//                                                                     self.collectionView.frame.size.width,
//                                                                     self.collectionView.frame.size.height);
//                             
//                         }
//                         completion:nil];
//        
//    } else {
//        NSLog(@"UP");
//        
//        [UIView animateWithDuration: 0.5
//                              delay: 0.0
//                            options: UIViewAnimationOptionCurveLinear
//                         animations: ^{
//                             //                             self.profileView.alpha = 1.0;
//                             //                             self.profileView.frame.origin.y = -300.0f;
//                             self.profileView.frame = CGRectMake (self.profileView.frame.origin.x,
//                                                                  -self.profileView.frame.size.height,
//                                                                  self.profileView.frame.size.width,
//                                                                  self.profileView.frame.size.height);
//                             
//                             self.collectionView.frame = CGRectMake (self.collectionView.frame.origin.x,
//                                                                  164,
//                                                                  self.collectionView.frame.size.width,
//                                                                  self.collectionView.frame.size.height);
//                             
//                         }
//                         completion:nil];
//        
//        
//    }
    
//    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, 21)];
//    title.text = [self.dataArray objectAtIndex:indexPath.row];
//    cell.tag = 200;

//    [cell addSubview:title];

    
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
