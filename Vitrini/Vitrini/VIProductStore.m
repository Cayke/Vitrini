//
//  VIProductStore.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "VIProductStore.h"
#import "VIProduct.h"

@implementation VIProductStore

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
        _products = [[NSMutableArray alloc]init];
    }
    return self;
}

+(instancetype)sharedStore{
    static VIProductStore *store = nil;
    
    if (!store) {
        // inicializar loja
        store = [[VIProductStore alloc]initPrivate];
        
        [store mountForTest];
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
    for (int i = 8; i < 13; i++) {
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
    for (int i = 8; i < 13; i++) {
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
    static NSUInteger productIndex = 0;
    if (productIndex >= [_products count]) {
        return nil;
    }
    productIndex++;
    return _products[productIndex-1];
}

@end
