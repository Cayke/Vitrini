//
//  VIProduct.m
//  Vitrini
//
//  Created by Riheldo Melo Santos on 19/12/14.
//  Copyright (c) 2014 Willian Pinho. All rights reserved.
//

#import "VIProduct.h"
#import "VISymbolsPackage.h"

@implementation VIProduct


- (instancetype)initToCardWithDict:(NSDictionary*)pdict
{
    self = [super init];
    if (self) {
        _ID = [[pdict objectForKey:@"ID"]intValue];
        _gender = [pdict objectForKey:@"gender"];
        //_oldPrice = [[pdict objectForKey:@"oldPrice"]floatValue];
        //_price = [[pdict objectForKey:@"price"]floatValue];
        _resume = [pdict objectForKey:@"resume"];
        _images = [pdict objectForKey:@"photo"];
        
        _store = [[VIStore alloc]init];
        _store.imageName = [[pdict objectForKey:@"store"]objectForKey:@"image"];
        _store.name = [[pdict objectForKey:@"store"]objectForKey:@"name"];
        _store.address = [[pdict objectForKey:@"store"]objectForKey:@"address"];
        
        _brand = [[VIBrand alloc]init];
        _brand.imageName = [[pdict objectForKey:@"brand"]objectForKey:@"image"];
        _brand.name = [[pdict objectForKey:@"brand"]objectForKey:@"name"];
    }
    return self;
}

-(void)dealloc{
    NSLog(@"desalocou");
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
@end
