//
//  VIUser.m
//  Vitrini
//
//  Created by Cayke Prudente on 20/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VISymbolsPackage.h"
#import "VIUser.h"
#import <UIKit/UIKit.h>

@implementation VIUser

-(instancetype)initWithDictionary:(NSDictionary *)dicUser
{
    self = [super init];
    if (self) {
        VISymbolsPackage *symbPack = [[VISymbolsPackage alloc]init];
        _name = [dicUser objectForKey:symbPack.name];
        _email = [dicUser objectForKey:symbPack.email];
        _gender = [dicUser objectForKey:symbPack.gender];
        _birthday = [dicUser objectForKey:symbPack.birthday];
        _city = [dicUser objectForKey:symbPack.city];
        _image = [dicUser objectForKey:symbPack.image];
        
        if (!_image)
        {
            _image = UIImagePNGRepresentation([UIImage imageNamed:@"user_create"]);
        }
        
        [self mountFilterGender];
    }
    return self;
}

-(NSDictionary *)getDictionary
{
    VISymbolsPackage *symbPack = [[VISymbolsPackage alloc]init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:_name forKey:symbPack.name];
    [dic setObject:_email forKey:symbPack.email];
    [dic setObject:_gender forKey:symbPack.gender];
    [dic setObject:_birthday forKey:symbPack.birthday];
    [dic setObject:_city forKey:symbPack.city];
    [dic setObject:_image forKey:symbPack.image];
    
    return [NSDictionary dictionaryWithDictionary:dic];
}

- (instancetype)initWithName:(NSString *)name andEmail:(NSString *)email andGender:(NSString *)gender andBirthday:(NSString *)birthday andCity:(NSString *)city andPass:(NSString *)pass andImage:(NSData *)image{
    self = [super init];
    if (self) {
        self.name = name;
        self.email = email;
        self.gender = gender;
        self.birthday = birthday;
        self.city = city;
        self.pass = pass;
        self.image = image;
        
        [self mountFilterGender];
    }
    return self;
}

-(void)mountFilterGender{
    if ([_gender isEqualToString:@"male"] || [_gender isEqualToString:@"M"]) {
        _filterGender = @"M";
    } else{
        _filterGender = @"F";
    }
}

@end
