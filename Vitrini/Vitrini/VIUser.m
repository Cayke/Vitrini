//
//  VIUser.m
//  Vitrini
//
//  Created by Cayke Prudente on 20/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIUser.h"

@implementation VIUser

-(instancetype)initWithDictionary:(NSDictionary *)dicUser
{
    self = [super init];
    if (self) {
        _name = [dicUser objectForKey:@"name"];
        _email = [dicUser objectForKey:@"email"];
        _gender = [dicUser objectForKey:@"gender"];
        _birthday = [dicUser objectForKey:@"birthday"];
        _city = [dicUser objectForKey:@"city"];
        _image = [dicUser objectForKey:@"image"];
    }
    return self;
}

-(NSDictionary *)getDictionary
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:_name forKey:@"name"];
    [dic setObject:_email forKey:@"email"];
    [dic setObject:_gender forKey:@"gender"];
    [dic setObject:_birthday forKey:@"birthday"];
    [dic setObject:_city forKey:@"city"];
    [dic setObject:_image forKey:@"image"];
    
    return [NSDictionary dictionaryWithDictionary:dic];
}



@end
