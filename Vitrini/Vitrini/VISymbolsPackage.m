//
//  VISymbolsPackage.m
//  Vitrini
//
//  Created by Cayke Prudente on 19/02/15.
//

#import "VISymbolsPackage.h"

@implementation VISymbolsPackage

- (instancetype)init
{
    self = [super init];
    if (self) {
        _ID 				= @"ID";
        _email 		    = @"email";
        _password	    = @"password";
        _facebookID	    = @"facebookID";
        _photo		    = @"photo";
        _cover 			= @"cover";
        _city		    = @"city";
        _name		    = @"name";
        _deviceToken     = @"deviceToken";
        _boostProductID  = @"boostProductID";
        _productID 		= @"productID";
        _productReviewLike = @"productReviewLike";
        _liked 			= @"liked";
        _notLiked		= @"notLiked";
        _code 			= @"code";
        _gender			= @"gender";
        _birthday		= @"birthday";
        _page 			= @"page";
        _branch			= @"branch";
        _brand 			= @"brand";
        _storeID			= @"storeID";
        _store 			= @"store";
        _categories		= @"categories";
        _category 		= @"category";
        _categoryID 		= @"categoryID";
        _tags			= @"tags";
        _title 			= @"title";
        _image			= @"image";
        _address			= @"address";
        _products 		= @"products";
        _price 			= @"price";
        _oldPrice 		= @"oldPrice";
        _resume 	= @"resume";
        _following 		= @"following";
        _follow 			= @"follow";
        _unfollow 		= @"unfollow";
    }
    return self;
}


@end
