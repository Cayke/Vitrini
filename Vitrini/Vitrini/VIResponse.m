//
//  VIResponse.m
//  Vitrini
//
//  Created by Cayke Prudente on 19/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIResponse.h"

@implementation VIResponse

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"wrong init" reason:@"use another init" userInfo:nil];
    return nil;
}

- (instancetype)initWithResponse:(NSData*)responsedata
{
    self = [super init];
    if (self) {
        NSError *error;
        NSDictionary *d = [NSJSONSerialization JSONObjectWithData:responsedata options:0 error:&error];
        
        if (error) {
            return nil;
        }
        
        if ([[d objectForKey:@"status"] isEqualToString:@"success"]) {
            _status = VIRequestSuccess;
        } else {
            _status = VIRequestError;
        }
        _responseType = [d objectForKey:@"response"];
        _value = [d objectForKey:@"value"];
    }
    return self;
}

@end
