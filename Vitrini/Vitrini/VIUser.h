//
//  VIUser.h
//  Vitrini
//
//  Created by Cayke Prudente on 20/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VIUser : NSObject

//dados do user: foto, nome, email, genero, nascimento, cidade
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *gender;
@property (nonatomic) NSString *birthday;
@property (nonatomic) NSString *city;
@property (nonatomic) NSData *image;

-(NSDictionary *) getDictionary;
-(instancetype) initWithDictionary:(NSDictionary *)dicUser;


@end
