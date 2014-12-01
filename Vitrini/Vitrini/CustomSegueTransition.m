//
//  CustomSegueTransition.m
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 11/28/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "CustomSegueTransition.h"

@implementation CustomSegueTransition

- (void)perform
{
    UIView *sourceView = ((UIViewController *)self.sourceViewController).view;
    UIView *destinationView = ((UIViewController *)self.destinationViewController).view;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    destinationView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.05, 0.05), CGAffineTransformMakeRotation(180 * M_PI / 180));
    
    destinationView.center = CGPointMake(sourceView.center.x + sourceView.frame.size.width, destinationView.center.y);
    
    [window insertSubview:destinationView aboveSubview:sourceView];
    
    [UIView animateWithDuration:0.75
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         destinationView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 1.0), CGAffineTransformMakeRotation(0 * M_PI / 180));
                         destinationView.center = CGPointMake(sourceView.center.x, destinationView.center.y);
                         
                         
                         sourceView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.05, 0.05), CGAffineTransformMakeRotation(180 * M_PI / 180));
                         sourceView.center = CGPointMake(0 - sourceView.center.x, destinationView.center.y);
                     }
                     completion:^(BOOL finished){
                         [[self sourceViewController] presentViewController:[self destinationViewController] animated:NO completion:nil];
                     }];
    
    
    
}

@end
