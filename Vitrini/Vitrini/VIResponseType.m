//
//  VIResponseType.m
//  Vitrini
//
//  Created by Cayke Prudente on 19/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIResponseType.h"

@implementation VIResponseType

- (instancetype)init
{
    self = [super init];
    if (self) {
        _accessDenied 		= @"access_denied";
        _serverError			= @"server_error";
        _emailAlreadyExist 	= @"email_already_exist";
        _registerUserWithSuccess = @"register_success";
        _cadastreNotFound	= @"cadastre_of_client_not_found";
        _passwordDoesntMatch = @"password_doesnt_match";
        _userInfosChanged	= @"infos_of_user_changed";
        _tokenSaved			= @"token_saved";
        _productReviewed		= @"product_reviewed";
    }
    return self;
}


@end
