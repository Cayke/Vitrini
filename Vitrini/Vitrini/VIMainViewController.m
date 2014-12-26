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
#import "VILikedsViewController.h"

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
    _menuView.backgroundColor = [VIColor primaryColor];
    
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
    
    //VILikedsViewController *vc2 = [[VILikedsViewController alloc]init];
    UIStoryboard *likeds = [UIStoryboard storyboardWithName:@"Likeds" bundle:nil];
    VILikedsViewController *likedsVC = (VILikedsViewController*)[likeds instantiateInitialViewController];
    
    
//    UIViewController *vc2 = [[UIViewController alloc]init];
//    vc2.view.backgroundColor = [UIColor blueColor];
//    vc2.title = @"Meu Perfil";
//
////    UIViewController *vc3 = [ instantiateViewControllerWithIdentifier:@"gostei"];
////    vc3.title = @"Meus Likes";
//    
//    UIViewController *vc4 = [[UIViewController alloc]init];
//    vc4.view.backgroundColor = [UIColor purpleColor];
//    vc4.title = @"Novidades";
//    
//    UIViewController *vc5 = [[UIViewController alloc]init];
//    vc5.view.backgroundColor = [UIColor purpleColor];
//    vc5.title = @"Cátalogo";
//    
//    UIViewController *vc6 = [[UIViewController alloc]init];
//    vc6.view.backgroundColor = [UIColor purpleColor];
//    vc6.title = @"Vitrini";
    
    self.viewControllers = @[vc1, likedsVC];
}


@end