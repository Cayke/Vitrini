//
//  VIMainViewController.m
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 12/16/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "VIMainViewController.h"

@interface VIMainViewController ()

@property (nonatomic, strong) UIView *menuView;

@end

@implementation VIMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    _menuView.backgroundColor = [UIColor colorWithRed:25.0f/255.0f
                                                green:47.0f/255.0f
                                                 blue:70.0f/255.0f
                                                alpha:0.0f];
    
    // deixar circular
    [_menuView.layer setCornerRadius:(btnWidth/2)];
    _menuView.layer.masksToBounds = NO;
    
    // adicionar na subview
    [self.view addSubview:_menuView];
    
    
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicou)];
    [_menuView addGestureRecognizer:click];
    
    [self organizeViewControllers];
    
    [self initWithViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)clicou{
    // subir menu
    if (_mainMenu.hidden) {
        [_mainMenu showMenu];
        _menuView.backgroundColor = [UIColor colorWithRed:25.0f/255.0f
                                                    green:47.0f/255.0f
                                                     blue:70.0f/255.0f
                                                    alpha:1.0f];
    } else {
        [_mainMenu hideMenu];
        _menuView.backgroundColor = [UIColor colorWithRed:25.0f/255.0f
                                                    green:47.0f/255.0f
                                                     blue:70.0f/255.0f
                                                    alpha:0.0f];
    }
}

-(void)changeVCtoIndex:(NSUInteger)index{
    self.selectedViewController = self.viewControllers[index];

    [self organizeViewControllers];
    
    NSLog(@"%lu",(unsigned long)index);
    
    
    NSLog(@"%@",    self.selectedViewController.title );
    _menuView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f
                                                green:0.0f/255.0f
                                                 blue:70.0f/255.0f
                                                alpha:0.0f];
}

-(void)organizeViewControllers{
    //    NSMutableArray *newVCsArray = [[NSMutableArray alloc]init];
    //    [newVCsArray addObject:self.viewControllers[self.selectedIndex]];
    //
    //    for (UIViewController *vc in self.viewControllers) {
    //        if (vc != self.selectedViewController) {
    //            [newVCsArray addObject:vc];
    //        }
    //    }
    //
    //    self.viewControllers = [NSArray arrayWithArray:newVCsArray];
}

- (void)initWithViewControllers
{
    UIViewController *vc1;
//    vc1.view.backgroundColor = [UIColor yellowColor];
    
    UIStoryboard *userOnboard = [UIStoryboard storyboardWithName:@"michas" bundle:nil];
    vc1 = [userOnboard instantiateViewControllerWithIdentifier:@"vitrini"];
//    [self.appDelegate.window setRootViewController:userOnboardViewController];//[self presentViewController:userOnboardViewController animated:YES completion:nil];
    vc1.title = @"Configuracoes";
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.view.backgroundColor = [UIColor blueColor];
    vc2.title = @"Meu Perfil";
    
    UIViewController *vc3 = [userOnboard instantiateViewControllerWithIdentifier:@"gostei"];
    vc3.title = @"Meus Likes";
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc4.view.backgroundColor = [UIColor purpleColor];
    vc4.title = @"Novidades";
    
    UIViewController *vc5 = [[UIViewController alloc]init];
    vc5.view.backgroundColor = [UIColor purpleColor];
    vc5.title = @"Cátalogo";
    
    UIViewController *vc6 = [[UIViewController alloc]init];
    vc6.view.backgroundColor = [UIColor purpleColor];
    vc6.title = @"Vitrini";
    
    self.viewControllers = @[vc1, vc2, vc3, vc4, vc5, vc6];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
