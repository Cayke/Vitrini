//
//  VICardView.h
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Vitrini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VISignView.h"
#import "VIProduct.h"

// protocolo para o delegate que vai receber essa classe
@protocol DraggableViewDelegate <NSObject>
@property (nonatomic)  BOOL clickIsAvailable;

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

-(void)swipingViewDistanceFromCenter:(CGPoint)point;
-(void)cancelSwiping;

-(void)resetBackCard;

@end


@interface VICardView : UIView

@property (weak) id <DraggableViewDelegate> delegate;
@property (nonatomic) VIProduct *product;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) CGPoint originalPoint;
@property (nonatomic,strong) VISignView *signView;

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) CGRect originalImageViewFrame;

- (instancetype)initWithFrame:(CGRect)frame andProduct:(VIProduct*)product;

-(void)leftClickAction;
-(void)rightClickAction;

// metodos
-(void)animationBeingSecondCardWithFirstCardFactor:(CGFloat)factor;
-(void)normalize;

@end
