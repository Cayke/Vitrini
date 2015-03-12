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

@interface VICatalogViewController ()

@end

@implementation VICatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView.backgroundColor = [UIColor clearColor];
    
    //trocar a cor da searchbar
    [_searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    [_searchBar setScopeBarBackgroundImage:[UIImage imageWithCGImage:(__bridge CGImageRef)([UIColor clearColor])]];
    //[_searchBar setBackgroundImage:[UIImage imageWithCGImage:(__bridge CGImageRef)([UIColor clearColor])]];
    //[_searchBar setTintColor:[UIColor orangeColor]];
    //[_searchBar setBarTintColor:[UIColor orangeColor]];
    //[_searchBar setTranslucent:NO];
    
    //delegate table view
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //inicializar array com categorias
    _arrayCategorys = [[VIStorage sharedStorage]returnCategories];
    
    //botar status bar branca
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(UIImage *)itemMenuIcon
{
    return [UIImage imageNamed:@"Vitrini_catalogos_icon"];
}

-(NSString *)itemMenuTitle
{
    return @"Catálogo";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrayCategorys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VICatalogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VICatalogTableViewCell"];
    
    VICategory *cat = [_arrayCategorys objectAtIndex:indexPath.row];
    [cell mountWithCategory:cat];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *store = [UIStoryboard storyboardWithName:@"Catalog" bundle:nil];
    VIProductsFromCategoryViewController *products = (VIProductsFromCategoryViewController *) [store instantiateViewControllerWithIdentifier:@"VIProductsFromCategoryViewController"];
        products.category = [_arrayCategorys objectAtIndex:indexPath.row];
    [self presentViewController:products animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

@end
