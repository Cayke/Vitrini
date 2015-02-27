//
//  VIProduct.h
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VIStore.h"

@interface VIProduct : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *descricao;
@property (nonatomic) double Valor;
@property (nonatomic) NSArray *images;
@property (nonatomic) BOOL liked;
@property (nonatomic) VIStore *store;
@property (nonatomic) NSString *categoria;
@property (nonatomic) NSArray *tamanhos;
@property (nonatomic) BOOL genero;


//todo apagar (usar array images)
@property (nonatomic) UIImage *photo;

@end
