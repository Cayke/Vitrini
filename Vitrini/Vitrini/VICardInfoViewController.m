//
//  VICardInfoViewController.m
//  Vitrini
//
//  Created by Willian Pinho on 2/3/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VICardInfoViewController.h"
#import "VICardInfoContentViewController.h"

@interface VICardInfoViewController ()

@end

@implementation VICardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pageImages = [[NSArray alloc]initWithObjects:@"img1",@"img2",@"img3",@"img4", nil];
    
    //create pagevc
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UIPageViewControllerID"];
    self.pageViewController.dataSource = self;
    
    VICardInfoContentViewController *startingVC = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingVC];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.width); //arrumar para tela ficar bonitinha, com labels embaixo e talz
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    //troca cor dos indicators
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    
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
    NSUInteger index = ((VICardInfoContentViewController*) viewController).pageIndex;
    
    if ((index == 0)||(index == NSNotFound)) {
        return nil;
    }
    
    index --;
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((VICardInfoContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index ++;
    
    return [self viewControllerAtIndex:index];
    
}

-(VICardInfoContentViewController *) viewControllerAtIndex:(NSUInteger) index
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


@end
