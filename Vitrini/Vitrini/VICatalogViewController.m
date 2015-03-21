//
//  VICatalogViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 21/01/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VICatalogViewController.h"
#import "VICatalogTableViewCell.h"
#import "VIResponse.h"
#import "VIServer.h"
#import "VICategory.h"
#import "VIStorage.h"
#import "VIProductsFromCategoryViewController.h"
#import "VIStoreProfileViewController.h"

@interface VICatalogViewController ()

@end

@implementation VICatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView.backgroundColor = [UIColor clearColor];
    
    //trocar a cor da searchbar
    //[_searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    //[_searchBar setScopeBarBackgroundImage:[UIImage imageWithCGImage:(__bridge CGImageRef)([UIColor clearColor])]];
    //[_searchBar setBackgroundImage:[UIImage imageWithCGImage:(__bridge CGImageRef)([UIColor clearColor])]];
    //[_searchBar setTintColor:[UIColor orangeColor]];
    //[_searchBar setBarTintColor:[UIColor orangeColor]];
    //[_searchBar setTranslucent:NO];
    
    //delegate table view
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
    
    //inicializar array com categorias e as lojas
    [self initData];
    
    [self.segControl addTarget:self action:@selector(segmentControlChangeState:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initData
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Call your function or whatever work that needs to be done
        //Code in this part is run on a background thread
        
        //inicializar array com categorias e as lojas
        _arrayCategorys = [[VIStorage sharedStorage]returnCategories];
        _arrayStores = [[VIStorage sharedStorage]returnStoresWithPage:0];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            //Stop your activity indicator or anything else with the GUI
            //Code here is run on the main thread
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            if (_arrayCategorys && _arrayStores) {
                    [_tableView reloadData];
            }
            else
            {
                [self initData];
            }

            
        });
    });
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(UIImage *)itemMenuIcon
{
    return [UIImage imageNamed:@"icon-categorias-menu"];
}

-(NSString *)itemMenuTitle
{
    return @"Explorar";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_segControl.selectedSegmentIndex == 0) {
        return [_arrayCategorys count];
    }
    else if (_segControl.selectedSegmentIndex == 1) {
        return [_arrayStores count];
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VICatalogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VICatalogTableViewCell"];
    
    if (_segControl.selectedSegmentIndex == 0) {
        VICategory *cat = [_arrayCategorys objectAtIndex:indexPath.row];
        [cell mountWithCategory:cat];
    }
    else {
        VIStore *store = [_arrayStores objectAtIndex:indexPath.row];
        [cell mountWithStore:store];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segControl.selectedSegmentIndex == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Catalog" bundle:nil];
        VIProductsFromCategoryViewController *products = (VIProductsFromCategoryViewController *) [storyboard instantiateViewControllerWithIdentifier:@"VIProductsFromCategoryViewController"];
        products.category = [_arrayCategorys objectAtIndex:indexPath.row];
        [self presentViewController:products animated:YES completion:nil];
    }
    else if (_segControl.selectedSegmentIndex == 1) {
        UIStoryboard *storeSB = [UIStoryboard storyboardWithName:@"VIStoreProfile" bundle:nil];
        VIStoreProfileViewController *storeVC = (VIStoreProfileViewController *) [storeSB instantiateInitialViewController];
        storeVC.actualStore = [_arrayStores objectAtIndex:indexPath.row];
        
        [self presentViewController:storeVC animated:YES completion:nil];
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(void) segmentControlChangeState:(id)sender
{
    //    UISegmentedControl *segControl = sender;
    //    if (segControl.selectedSegmentIndex == 0) {
    //        NSLog(@"produtos");
    //    }
    //    else
    //    {
    //        NSLog(@"lojas");
    //    }
    [_tableView reloadData];
}

@end
