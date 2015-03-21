//
//  VIProduct.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "VIProduct.h"
#import "VISymbolsPackage.h"
#import "VIServer.h"

@implementation VIProduct


- (instancetype)initToCardWithDict:(NSDictionary*)pdict
{
    self = [super init];
    if (self) {
        _idProduct = [[pdict objectForKey:@"ID"]intValue];
        _gender = [pdict objectForKey:@"gender"];
        //_oldPrice = [[pdict objectForKey:@"oldPrice"]floatValue];
        _price = [[pdict objectForKey:@"price"]floatValue];
        _resume = [pdict objectForKey:@"resume"];
        _images = [pdict objectForKey:@"photo"];
        _name = [pdict objectForKey:@"name"];
        
        _store = [[VIStore alloc]init];
        _store.imageName = [[pdict objectForKey:@"store"]objectForKey:@"photo"];
        _store.name = [[pdict objectForKey:@"store"]objectForKey:@"name"];
        _store.storeID = [[[pdict objectForKey:@"store"]objectForKey:@"storeID"]intValue];
        
        _brand = [[VIBrand alloc]init];
        _brand.imageName = [[pdict objectForKey:@"brand"]objectForKey:@"image"];
        _brand.name = [[pdict objectForKey:@"brand"]objectForKey:@"name"];
    }
    return self;
}

-(void)dealloc{
    //NSLog(@"desalocou");
}

-(instancetype)initWithProductFromServer:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        VISymbolsPackage *symbPack = [[VISymbolsPackage alloc]init];
        _idProduct = [[dict objectForKey:symbPack.ID]intValue];
        _name = [dict objectForKey:symbPack.name];
        _photoString = [dict objectForKey:symbPack.photo];
    }
    return self;
}

-(NSURL *)addressToDownloadMainImage{
    VIServer *serverConnection = [[VIServer alloc]init];
    return [serverConnection urlToDownloadImageName:_images[0]];
}

@end
