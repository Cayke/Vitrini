//
//  VIStoreShowProductViewController.h
//  Vitrini
//
//  Created by Paulo Magalhães on 3/12/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIStoreProfileNavigationBar.h"

@interface VIStoreShowProductViewController : UIViewController <UIScrollViewDelegate> {
    
//    UIScrollView* scrollView;
//    UIPageControl* pageControl;
    BOOL pageControlBeingUsed;
}

@property (weak, nonatomic) IBOutlet VIStoreProfileNavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) NSDictionary *infors;
@property (weak, nonatomic) IBOutlet UITextField *tittleProduct;
@property (weak, nonatomic) IBOutlet UITextField *priceProduct;
@property (weak, nonatomic) IBOutlet UITextView *descProduct;


- (IBAction)changePage:(id)sender;

- (IBAction)likeButton:(id)sender;
- (IBAction)dislikeButton:(id)sender;
- (IBAction)locationButton:(id)sender;
- (IBAction)shareButton:(id)sender;

@end
