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
#import "VIBrand.h"

@interface VIProduct : NSObject

@property (nonatomic) int ID;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *descricao;
@property (nonatomic) double Valor;
@property (nonatomic) NSArray *images;
@property (nonatomic) BOOL liked;
@property (nonatomic) VIStore *store;
@property (nonatomic) VIBrand *brand;
@property (nonatomic) NSString *categoria;
@property (nonatomic) NSArray *tamanhos;
@property (nonatomic) BOOL genero;
@property (nonatomic) int idProduct;
@property (nonatomic) NSString *gender;
@property (nonatomic) float oldPrice;
@property (nonatomic) float price;
@property (nonatomic) NSString *resume;

//todo apagar (usar array images)
@property (nonatomic) NSString *photoString;
@property (nonatomic) UIImage *photo;

-(instancetype) initWithProductFromServer:(NSDictionary *) dict;


- (instancetype)initToCardWithDict:(NSDictionary*)pdict;

-(NSURL*)addressToDownloadMainImage;

@end
