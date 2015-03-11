//
//  VIStoreProfileNavigationBar.m
//  Vitrini
//
//  Created by Paulo Magalhães on 3/10/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIStoreProfileNavigationBar.h"

@interface VIStoreProfileNavigationBar ()
{
    UIView* _underlayView;
}

- (UIView*) underlayView;

@end

@implementation VIStoreProfileNavigationBar

- (void)didAddSubview:(UIView *)subview
{
    [super didAddSubview:subview];
    
    if(subview != _underlayView)
    {
        UIView* underlayView = [self underlayView];
        [underlayView removeFromSuperview];
        [self insertSubview:underlayView atIndex:1];
    }
}

- (void)teste
{
    NSLog(@"NICE NICE");
}

- (UIView*)underlayView
{
    if(_underlayView == nil)
    {
        const CGFloat statusBarHeight = 20;
        const CGSize selfSize = self.frame.size;
        
        _underlayView = [[UIView alloc] initWithFrame:CGRectMake(0, -statusBarHeight, selfSize.width, selfSize.height + statusBarHeight)];
        [_underlayView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [_underlayView setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.11f]];
        [_underlayView setAlpha:1.0f];
        [_underlayView setUserInteractionEnabled:NO];
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
        self.translucent = YES;
        
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, statusBarHeight + selfSize.height, selfSize.width, 1)];
        [line setBackgroundColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.2f]];
        [line setAlpha:1.0f];
        [_underlayView addSubview:line];        
    }
    
    return _underlayView;
}

/*
 // Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
