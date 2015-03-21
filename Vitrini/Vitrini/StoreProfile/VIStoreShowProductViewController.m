//
//  VIStoreShowProductViewController.m
//  Vitrini
//
//  Created by Paulo Magalhães on 3/12/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIStoreShowProductViewController.h"
#import "AsyncImageView.h"

@interface VIStoreShowProductViewController ()

@end

@implementation VIStoreShowProductViewController

//@synthesize scrollView, pageControl;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    pageControlBeingUsed = YES;
    
    self.tittleProduct.text = self.infors[@"title"];
    self.priceProduct.text = self.infors[@"price"];
    self.descProduct.text = self.infors[@"desc"];
    self.photos = self.infors[@"photos"];
    
    //solves the problem of TextView's appearance, programmatically.
    self.descProduct.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    self.descProduct.textColor = [UIColor whiteColor];
    self.descProduct.tintColor = [UIColor whiteColor];
    self.descProduct.scrollEnabled = YES;
    self.descProduct.pagingEnabled = NO;
    self.descProduct.editable = NO;
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.photos.count, self.scrollView.frame.size.height);
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.photos.count;
    
    for (int i = 0; i < self.photos.count; i++) {
        CGRect frame;
        frame.origin.x = self.view.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.view.frame.size;
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        [self.scrollView addSubview:subview];
        
        UIImage *myImage = [UIImage imageNamed:self.photos[i]];
        UIImageView *myImageView = [[UIImageView alloc] initWithImage:myImage];
        [myImageView setContentMode: UIViewContentModeScaleAspectFill];
        [myImageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.scrollView.frame.size.height)];
        myImageView.userInteractionEnabled = YES;
        [subview addSubview:myImageView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!pageControlBeingUsed) {
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

#pragma mark Change Page for ScrollView

- (IBAction)changePage:(id)sender
{
    // Update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    // Keep track of when scrolls happen in response to the page control
    // value changing. If we don't do this, a noticeable "flashing" occurs
    // as the the scroll delegate will temporarily switch back the page
    // number.
    pageControlBeingUsed = YES;
}

- (IBAction)likeButton:(id)sender
{
    //NSLog(@"Like Button");
}

- (IBAction)dislikeButton:(id)sender
{
    //NSLog(@"Dislike Button");
}

- (IBAction)locationButton:(id)sender
{
    //NSLog(@"Location Button");
}

- (IBAction)shareButton:(id)sender
{
    //NSLog(@"Share Button");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Back Button Pressed

- (IBAction)backButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIStatusBarStyle

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
