//
//  VIProductStore.h
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIDraggableCardsView.h"

@class VIProduct;

@interface VIProductStore : NSObject

@property (nonatomic) NSMutableArray *products;
@property (nonatomic, weak) VIDraggableCardsView *backgroundCardsView;
@property (nonatomic) BOOL loading;

+(instancetype)sharedStore;

-(NSArray*)likedProducts;
-(VIProduct*)nextProduct;

-(BOOL)loadCards;
-(void)reviewProductID:(int)productID withLiked:(BOOL)isLiked;
-(void) changeCategoryID:(int)newCategoryID;

@end
