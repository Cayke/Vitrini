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
    const VIProductStore *store = nil;
    
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
}

@end
