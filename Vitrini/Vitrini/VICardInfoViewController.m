//
//  VICardInfoViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 2/3/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VICardInfoViewController.h"
#import "VICardInfoContentViewController.h"
#import "VIColor.h"
#import "VIResponse.h"
#import "VIServer.h"
#import "VIProductNameAndPriceTableViewCell.h"
#import "VIProductTextViewTableViewCell.h"

@interface VICardInfoViewController ()

@end

@implementation VICardInfoViewController

-(instancetype)init
{
    @throw [NSException exceptionWithName:@"use outro init" reason:nil userInfo:nil];
}

- (instancetype)initWithProduct:(VIProduct *)product
{
    self = [super init];
    if (self) {
        _product = product;
    }
    return self;
}

- (IBAction)locationButton:(id)sender {
}

- (IBAction)shareButton:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _textViewHeight = 0;
    _tableHeaderHeight = self.view.frame.size.width;
    _pageViewControlllerHeight = _tableHeaderHeight + 37;

    
    //colocar botar para voltar na navigation bar
    UIBarButtonItem *concluido = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"VIStoreProfileNavigationBarBackButton.png"] style:UIBarButtonItemStylePlain target:self action:@selector(voltar)];
    [concluido setTintColor:[VIColor whiteVIColor]];
    self.navigationItem.leftBarButtonItem = concluido;
    
    //baixar produto
    [self getProductInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getProductInfo
{
    VIServer *server = [[VIServer alloc]init];
    VIResponse *response = [server getAllInfoFromProduct:self.product.idProduct];
    if (response.status == VIRequestSuccess) {
        VIProduct *product = [[VIProduct alloc]initToCardWithDict:response.value];
        _product = product;
            [self reloadInfo];
    }
}

-(void) handleGestureLeft:(id) sender
{
    //AVANCAR NA PAGECONTROLLER
    
    //pegar current index da current page
    VICardInfoContentViewController *theCurrentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
    int retreivedIndex = theCurrentViewController.pageIndex;
    
    //checar se nao e ultima view
    if (retreivedIndex < [_product.images count] - 1){
        
        //pegar proxima tela
        retreivedIndex ++;
        VICardInfoContentViewController *targetPageViewController = [self viewControllerAtIndex:retreivedIndex];
        

        NSArray *theViewControllers = [NSArray arrayWithObjects:targetPageViewController, nil];
        
        //add page view
        [self.pageViewController setViewControllers:theViewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        _pageControlNB.currentPage = retreivedIndex;
    }
}

-(void) handleGestureRight:(id) sender
{
    //VOLTAR NA PAGECONTROLLER
    //pegar current index da current page
    VICardInfoContentViewController *theCurrentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
    int retreivedIndex = theCurrentViewController.pageIndex;
    
    //check se nao e a primeira foto
    if (retreivedIndex > 0){
        retreivedIndex--;
        
        //pegar proxima tela
        VICardInfoContentViewController *targetPageViewController = [self viewControllerAtIndex:retreivedIndex];
        
        
        NSArray *theViewControllers = [NSArray arrayWithObjects:targetPageViewController, nil];
        
        //add page view
        [self.pageViewController setViewControllers:theViewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:NULL];
        
        _pageControlNB.currentPage = retreivedIndex;
        
    }
}


-(void) reloadInfo
{
    //ver o tamanho que ocupara a textView
    UILabel *textView = [[UILabel alloc]init];
    textView.numberOfLines = 100;
    textView.text = _product.resume;
    [textView setFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size:15.0]];
    
    CGSize size = [textView sizeThatFits:CGSizeMake(self.view.frame.size.width, FLT_MAX)];
    _textViewHeight = size.height;

    
    //criar o header da table view
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _tableHeaderHeight)];
    tableHeader.backgroundColor = [UIColor clearColor];
    
    //adicionar gesture a view
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleGestureLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [tableHeader addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleGestureRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [tableHeader addGestureRecognizer:swipeRight];
    
    
    //tableview
    self.tableView.tableHeaderView = tableHeader;
    
    //create pagevc
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UIPageViewControllerID"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    VICardInfoContentViewController *startingVC = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingVC];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 64, self.view.frame.size.width, _pageViewControlllerHeight);
    
    [self addChildViewController:_pageViewController];
    [self.view insertSubview:_pageViewController.view belowSubview:_tableView];
    [self.pageViewController didMoveToParentViewController:self];
    
    //todo
    //ver se a pessoa ja curtiu o produto ou nao
    //    if (_product.liked == NO) {
    //        UIBarButtonItem *like = [UIBarButtonItem alloc]initWithImage:<#(UIImage *)#> landscapeImagePhone:<#(UIImage *)#> style:<#(UIBarButtonItemStyle)#> target:<#(id)#> action:<#(SEL)#>];
    //        UIBarButtonItem *dislike = [UIBarButtonItem alloc]initWithImage:<#(UIImage *)#> landscapeImagePhone:<#(UIImage *)#> style:<#(UIBarButtonItemStyle)#> target:<#(id)#> action:<#(SEL)#>];
    //        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:like, dislike, nil];
    //    }
    
    self.customNavigationBar.items = [NSArray arrayWithObject:self.navigationItem];
    
//    //criar linha de baixo da navigation
//    CALayer *borderBotton = [CALayer layer];
//    borderBotton.borderColor = [VIColor whiteVIColor].CGColor;
//    borderBotton.borderWidth = 1;
//    borderBotton.frame = CGRectMake(0, _customNavigationBar.frame.size.height-1, self.view.frame.size.width, 1);
//    [_customNavigationBar.layer addSublayer:borderBotton];
    
    //esconder a pagecontrol do pageviewcontroller
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor clearColor];
    pageControl.currentPageIndicatorTintColor = [UIColor clearColor];
    pageControl.backgroundColor = [UIColor clearColor];
    
    //trocar cor da page control
    _pageControlNB.pageIndicatorTintColor = [VIColor grayVIColor];
    _pageControlNB.currentPageIndicatorTintColor = [VIColor whiteVIColor];
    _pageControlNB.backgroundColor = [UIColor clearColor];
    _pageControlNB.numberOfPages = [_product.images count];
    
    
    
    [_tableView reloadData];
}

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
    
    if (index >= [_product.images count]) {
        return nil;
    }
    
    index ++;
    
    return [self viewControllerAtIndex:index];
    
}

-(VICardInfoContentViewController *) viewControllerAtIndex:(int) index
{
    if (([_product.images count] == 0) || (index >= [_product.images count])) {
        return nil;
    }
    
    VICardInfoContentViewController *pageContentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VICardInfoContentViewControllerID"];
    pageContentVC.imageFile = _product.images[index];
    pageContentVC.pageIndex = index;
    
    return pageContentVC;
    
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return [_product.images count];
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

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        VIProductNameAndPriceTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"VIProductNameAndPriceTableViewCell"];
        [cell mountWithName:_product.name andPrice:_product.price];
        return cell;
    }
    else {
        VIProductTextViewTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"VIProductTextViewTableViewCell"];
        [cell mountWithDescription:_product.resume];
        return cell;
    }
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 55;
    }
    else
    {
        return _textViewHeight;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollOffset = scrollView.contentOffset.y;
    CGRect pageFrame = self.pageViewController.view.frame;
    
    if (scrollOffset < 0) {
        //puxou pra baixo
        NSLog(@"%f", scrollOffset);
        pageFrame.size.height = _pageViewControlllerHeight - scrollOffset; // - com - da +, na real estou somando o offset ao header height
    }
    else
    {
        //puxou pra cima
        NSLog(@"%f", scrollOffset);
        if (scrollOffset <= _pageViewControlllerHeight) {
                    pageFrame.size.height = _pageViewControlllerHeight - scrollOffset;
        }
    
    }
    
    self.pageViewController.view.frame = pageFrame;
}


@end
