//
//  VICardInfoViewController.m
//  Vitrini
//
//  Created by Willian Pinho on 2/3/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VICardInfoViewController.h"
#import "VICardInfoContentViewController.h"
#import "VIColor.h"

@interface VICardInfoViewController ()

@end

@implementation VICardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //todo : botar as informacoes a partir do objeto _product
    
    _pageImages = [[NSArray alloc]initWithObjects:@"img1",@"img2",@"img3",@"img4", nil];
    
    //create pagevc
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UIPageViewControllerID"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    VICardInfoContentViewController *startingVC = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingVC];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width + 37);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    //colocar botar para voltar na navigation bar
    UIBarButtonItem *concluido = [[UIBarButtonItem alloc]initWithTitle:@"Concluído" style:UIBarButtonItemStylePlain target:self action:@selector(voltar)];
    [concluido setTintColor:[VIColor blueVIColor]];
    self.navigationItem.leftBarButtonItem = concluido;
    //todo
    //ver se a pessoa ja curtiu o produto ou nao
//    if (_product.liked == NO) {
//        UIBarButtonItem *like = [UIBarButtonItem alloc]initWithImage:<#(UIImage *)#> landscapeImagePhone:<#(UIImage *)#> style:<#(UIBarButtonItemStyle)#> target:<#(id)#> action:<#(SEL)#>];
//        UIBarButtonItem *dislike = [UIBarButtonItem alloc]initWithImage:<#(UIImage *)#> landscapeImagePhone:<#(UIImage *)#> style:<#(UIBarButtonItemStyle)#> target:<#(id)#> action:<#(SEL)#>];
//        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:like, dislike, nil];
//    }
    self.customNavigationBar.items = [NSArray arrayWithObject:self.navigationItem];
    
    //criar linha de baixo
    CALayer *borderBotton = [CALayer layer];
    borderBotton.borderColor = [VIColor blueVIColor].CGColor;
    borderBotton.borderWidth = 1;
    borderBotton.frame = CGRectMake(0, _customNavigationBar.frame.size.height-1, self.view.frame.size.width, 1);
    [_customNavigationBar.layer addSublayer:borderBotton];
    
    //esconder a pagecontrol do pageviewcontroller
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor clearColor];
    pageControl.currentPageIndicatorTintColor = [UIColor clearColor];
    pageControl.backgroundColor = [UIColor clearColor];
    
    //trocar cor da page control
    _pageControlNB.pageIndicatorTintColor = [VIColor lightGrayVIColor];
    _pageControlNB.currentPageIndicatorTintColor = [VIColor blueVIColor];
    _pageControlNB.backgroundColor = [UIColor clearColor];
    
    _pageControlNB.numberOfPages = [_pageImages count];
    
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

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    int index = ((VICardInfoContentViewController*) viewController).pageIndex;
    
    if (index == 0) {
        return nil;
    }
    
    index --;

    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    int index = ((VICardInfoContentViewController*) viewController).pageIndex;
    
    if (index >= [_pageImages count]) {
        return nil;
    }
    
    index ++;
    
    return [self viewControllerAtIndex:index];
    
}

-(VICardInfoContentViewController *) viewControllerAtIndex:(int) index
{
    if (([self.pageImages count] == 0) || (index >= [self.pageImages count])) {
        return nil;
    }
    
    VICardInfoContentViewController *pageContentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VICardInfoContentViewControllerID"];
    pageContentVC.imageFile = self.pageImages[index];
    pageContentVC.pageIndex = index;
    
    return pageContentVC;
    
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return [self.pageImages count];
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

-(void) voltar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    VICardInfoContentViewController *actualPage = [pageViewController.viewControllers objectAtIndex:0];
    [_pageControlNB setCurrentPage:actualPage.pageIndex];
}

@end
