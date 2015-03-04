//
//  VIProductStore.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "VIProductStore.h"
#import "VIProduct.h"
#import "VIServer.h"
#import "VIStorage.h"

#define MAX_COUNTER_INCREMENT 10

@implementation VIProductStore {
    int counterRN;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Initialization error!" reason:@"Use SharedStore" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        // inicializar coisas aqui
        _loading = NO;
        _products = [[NSMutableArray alloc]init];
        counterRN = 0;
    }
    return self;
}

+(instancetype)sharedStore{
    static VIProductStore *store = nil;
    
    if (!store) {
        // inicializar loja
        store = [[VIProductStore alloc]initPrivate];
        
    }
    
    return store;
}

-(void)mountForTest{
    VIProduct *product;
    for (int i = 1; i < 6; i++) {
        product = [[VIProduct alloc]init];
        product.photo = [UIImage imageNamed:[NSString stringWithFormat:@"img%d.png",i]];
        [_products addObject:product];
    }
    for (int i = 6; i < 8; i++) {
        product = [[VIProduct alloc]init];
        product.photo = [UIImage imageNamed:[NSString stringWithFormat:@"img%d.jpg",i]];
        [_products addObject:product];
    }
    for (int i = 8; i < 12; i++) {
        product = [[VIProduct alloc]init];
        product.photo = [UIImage imageNamed:[NSString stringWithFormat:@"img%d.png",i]];
        [_products addObject:product];
    }
    for (int i = 1; i < 6; i++) {
        product = [[VIProduct alloc]init];
        product.photo = [UIImage imageNamed:[NSString stringWithFormat:@"img%d.png",i]];
        [_products addObject:product];
    }
    for (int i = 6; i < 8; i++) {
        product = [[VIProduct alloc]init];
        product.photo = [UIImage imageNamed:[NSString stringWithFormat:@"img%d.jpg",i]];
        [_products addObject:product];
    }
    for (int i = 8; i < 12; i++) {
        product = [[VIProduct alloc]init];
        product.photo = [UIImage imageNamed:[NSString stringWithFormat:@"img%d.png",i]];
        [_products addObject:product];
    }
}

-(NSArray *)likedProducts{
    NSMutableArray *mutArray = [[NSMutableArray alloc]init];
    
    for (VIProduct *p in _products) {
        if (p.liked) {
            [mutArray addObject:p];
        }
    }
    
    NSArray *a =  [NSArray arrayWithArray:mutArray];
    return a;
}

-(VIProduct *)nextProduct{
    VIProduct *auxNext = nil;
    if ([_products count] > 0) {
        auxNext = _products[0];
        [_products removeObjectAtIndex:0];
    }
    return auxNext;
}

-(void)restartCounter{
    counterRN = 0;
}
-(void)incrementCounter{
    counterRN++;
}

-(BOOL)loadCards{
    VIServer *server = [[VIServer alloc]init];
    VIResponse *response = [server productsToReviewWithEmail:[VIStorage sharedStorage].user.email andCategoryID:0 andGender:@"M"];
    
    NSDictionary *productsDictionaryFromJSON = [response.value objectForKey:@"products"];
    if ([productsDictionaryFromJSON count] == 0) {
        [self incrementCounter];
        if (counterRN > MAX_COUNTER_INCREMENT) {
            @throw [NSException exceptionWithName:@"MAX_COUNTER_INCREMENT" reason:@"nao tem mais produto" userInfo:nil];
        }
        return NO;
    }
    
    VIProduct *auxProduct;
    for (NSDictionary *pdict in productsDictionaryFromJSON) {
        auxProduct = [[VIProduct alloc]initToCardWithDict:pdict];
        [_products addObject:auxProduct];
    }
    return YES;
}

-(void)reviewProductID:(int)productID withLiked:(BOOL)isLiked{
    VIServer *server = [[VIServer alloc]init];
    [server product:productID wasLiked:isLiked byUser:[VIStorage sharedStorage].user.email];
}

@end
