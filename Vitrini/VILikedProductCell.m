//
//  VILikedProductCell.m
//  Vitrini
//
//  Created by Cayke Prudente on 02/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VILikedProductCell.h"

@implementation VILikedProductCell

-(void)mountWithProduct:(VIProduct *)product{
    //TODO: MOSTRAR IMAGEM (baixar do server)
    _imageView.image = [UIImage imageNamed:@"img1"];
}

@end
