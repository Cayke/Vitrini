//
//  VILikedsViewController.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 24/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "VILikedsViewController.h"

#import "VIColor.h"

#import "VIProductStore.h"
#import "VIProduct.h"

@interface VILikedsViewController ()

@end

@implementation VILikedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *statusBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    statusBar.backgroundColor = [VIColor whiteViColor];
    [self.view addSubview:statusBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)itemMenuIcon{
    return [UIImage imageNamed:@"Icon_meuslikes_Menu"];
}

-(NSString *)itemMenuTitle{
    return @"Likeds";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewWillAppear:(BOOL)animated{
    [_collectionView reloadData];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[[VIProductStore sharedStore]likedProducts] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellCV" forIndexPath:indexPath];
    
    UIImageView *view = (UIImageView*)[cell viewWithTag:101];
    VIProduct *product = [[[VIProductStore sharedStore]likedProducts]objectAtIndex:indexPath.row];
    view.image = product.photo;
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat dimension = self.view.frame.size.width/2;
    return CGSizeMake(dimension, dimension);
}
@end
