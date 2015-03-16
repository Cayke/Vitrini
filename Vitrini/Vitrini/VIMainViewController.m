//
//  VIMainViewController.m
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 12/16/14.
//  Copyright (c) 2014 Vitrini. All rights reserved.
//

#import "VIMainViewController.h"
#import "VIColor.h"

#import "VICardsViewController.h"
#import "VILikesViewController.h"
#import "VICatalogViewController.h"
#import "VIFeedViewController.h"
#import "VIProfileTableViewController.h"

@implementation VIMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // inicializar views controllers
    [self initViewControllers];
    [self setupMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clicou{
    // subir menu
    if (_mainMenu.hidden) {
        [_mainMenu showMenu];
        
    } else {
        [_mainMenu hideMenu];
    }
}

-(void)changeVCtoIndex:(NSUInteger)index{
    self.selectedViewController = self.viewControllers[index];
}

-(void)setupMenu{
    self.tabBar.hidden = YES;
    
    
    // adicionar o menu principal
    _mainMenu = [[VIMainMenu alloc]initWithVITabBarVC:self andFrame:self.view.layer.bounds];
    
    [self.view addSubview:_mainMenu];
    
    
    // botao da view
    CGFloat bottom = self.view.bounds.size.height;
    CGFloat width = self.view.bounds.size.width;
    
    int btnWidth = 120;
    int btnHeight = 120;
    
    _menuView = [[UIView alloc]initWithFrame:CGRectMake(width/2-(btnWidth/2), bottom-(btnHeight/2), btnWidth, btnHeight)];
    _menuView.backgroundColor = [VIColor blueVIColor];
    
    // deixar circular
    [_menuView.layer setCornerRadius:(btnWidth/2)];
    _menuView.layer.masksToBounds = NO;
    
    // adicionar na subview
    [self.view addSubview:_menuView];
    
    // adicionar icone no circulo
    [_mainMenu installIconsOnMenu];
    
    
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicou)];
    [_menuView addGestureRecognizer:click];
}

- (void)initViewControllers
{
    ////
    ////
    //// IMPORTANTE - IMPORTANTE - IMPORTANTE - IMPORTANTE
    ////
    //// Um contrato foi definido para as viewControllers que irão aparecer no menu seguirem
    //// Caso o contrato nao for implementado, o app nao funciona
    ////
    //// O protocolo <VIViewControllerMenuItemProtocol> tem que funcionar
    //// Está dentro da classe VIProtocol.h
    ////
    ////
    
    
    
    VICardsViewController *vc1 = [[VICardsViewController alloc]init];
    
    UIStoryboard *likes = [UIStoryboard storyboardWithName:@"Likes" bundle:nil];
    VILikesViewController *likesVC = (VILikesViewController*)[likes instantiateInitialViewController];
    
    UIStoryboard *catalog = [UIStoryboard storyboardWithName:@"Catalog" bundle:nil];
    VICatalogViewController *catalogVC = (VICatalogViewController *) [catalog instantiateInitialViewController];
    
    UIStoryboard *feed = [UIStoryboard storyboardWithName:@"Feed" bundle:nil];
    VIFeedViewController *feedVC = (VIFeedViewController *) [feed instantiateInitialViewController];
    
    UIStoryboard *profile = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    VIProfileTableViewController *profileVC = (VIProfileTableViewController *) [profile instantiateInitialViewController];
    
    self.viewControllers = @[vc1, likesVC, catalogVC, feedVC, profileVC];
}

@end
