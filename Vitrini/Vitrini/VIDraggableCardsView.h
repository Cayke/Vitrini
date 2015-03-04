//
//  VIDraggableCardsView.h
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Vitrini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VICardView.h"
#import "VICardsViewController.h"

@interface VIDraggableCardsView : UIView <DraggableViewDelegate>

//methods called in DraggableView
-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@property (retain,nonatomic)NSArray* exampleCardPhotos; //%%% the labels the cards
@property (retain,nonatomic)NSMutableArray* allCards; //%%% the labels the cards

@property (nonatomic) BOOL clickIsAvailable;
@property (nonatomic) BOOL clickEvent;

@property (nonatomic) BOOL waitingNewProducts;

@property (nonatomic,weak) VICardsViewController *VICardsVC;

// metodos
-(VICardView*)presentedCard;
-(VICardView*)waitingCard;

-(void)reviewProduct:(VIProduct*)product withLiked:(BOOL)isLiked;

@end
