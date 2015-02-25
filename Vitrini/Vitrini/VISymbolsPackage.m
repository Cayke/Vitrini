//
//  VISymbolsPackage.m
//  Vitrini
//
//  Created by Cayke Prudente on 19/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VISymbolsPackage.h"

@implementation VISymbolsPackage

- (instancetype)init
{
    self = [super init];
    if (self) {
        _email 		    = @"email",
        _password	    = @"password",
        _facebookID	    = @"facebookID",
        _photo		    = @"photo",
        _city		    = @"city",
        _name		    = @"name",
        _deviceToken     = @"deviceToken",
        _boostProductID  = @"boostProductID",
        _productID 		= @"productID",
        _productReviewLike = @"productReviewLike",
        _liked 			= @"like",
        _notLiked		= @"notLike",
        _code = @"code";
        _gender = @"gender";
        _birthday = @"birthday";
        _image = @"image";
    }
    return self;
}


@end
