//
//  VIStorage.m
//  Vitrini
//
//  Created by Cayke Prudente on 20/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIStorage.h"
#import "VIServer.h"
#import "VIInitControl.h"
#import "VISymbolsPackage.h"
#import "VIProduct.h"

@implementation VIStorage
{
    VIServer *server;
    NSString *deviceLocation;
   // NSString *imagesLocation;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton error" reason:@"Use diferent initialization." userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        // inicia store
        server = [[VIServer alloc]init];
        deviceLocation = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
        
    }
    return self;
}

+(VIStorage *)sharedStorage{
    static VIStorage *store = nil;
    
    if (!store) {
        store = [[VIStorage alloc]initPrivate];
    }

    return store;
}

-(void)saveUser
{
    NSDictionary *userDic = [_user getDictionary];
    [self saveDictionary:userDic withFileName:@"user"];
}

-(BOOL)initUserFromDevice
{
    //ver se tem alguem logado no app...
    NSDictionary *userDic = [self loadDictionaryFileName:@"user"];
    if (userDic) {
        VIUser *user = [[VIUser alloc]initWithDictionary:userDic];
        self.user = user;
        return YES;
    }
    return NO;
}

-(void)setUser:(VIUser *)newUser
{
    _user = newUser;
}

-(VIUser *)getUser
{
    return _user;
}

-(void)logOutUser
{
    //apagar da storage
    self.user = nil;
    
    //apagar da plist
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/user.plist", deviceLocation] error:nil];
    
    
    //ir para useronboard
    [VIInitControl goToUserOnBoard];
}

-(void)initUserFromServer:(NSDictionary *)dicUser
{
    VIUser *user = [[VIUser alloc]initWithDictionary:dicUser];
    _user = user;
    [self saveUser];
}

/////////////////////////////////
//////// SAVES AND LOADS ////////
/////////////////////////////////

-(BOOL)saveDictionary:(NSDictionary*)dict withFileName:(NSString*)fileName{
    BOOL status = [dict writeToFile:[NSString stringWithFormat:@"%@/%@%@",deviceLocation,fileName,@".plist"] atomically:YES];
    return status;
}

-(NSDictionary*)loadDictionaryFileName:(NSString*)fileName{
    return [[NSDictionary alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@%@",deviceLocation,fileName,@".plist"]];
}

////////////////////////
//////  lIKES    ////////
////////////////////////
-(NSArray *)createLikesProductsWithResponse:(VIResponse *) response
{
    VISymbolsPackage *symbPack = [[VISymbolsPackage alloc]init];
    
    NSArray *arrayWithProducts = [response.value objectForKey:symbPack.products];
    
    NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in arrayWithProducts) {
        VIProduct *product = [[VIProduct alloc]initWithProductFromServer:dic];
        [returnArray addObject: product];
    }
    
    return [NSArray arrayWithArray:returnArray];
}




@end
