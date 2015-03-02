//
//  VIServer.m
//  Vitrini
//
//  Created by Cayke Prudente on 19/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIServer.h"
#import "VISymbolsPackage.h"
#import "VIResponse.h"
#import "VIResponseType.h"


@implementation VIServer
{
    VISymbolsPackage *symbPack;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        symbPack = [[VISymbolsPackage alloc]init];
    }
    return self;
}



//////////////////////////
//////// PRIVADOS ////////
//////////////////////////


-(NSString*)accessCode{
    return @"najsbuygaysutf78oyafsiluhljha";
}

-(NSString*)serverAddress{
    return @"http://107.170.189.125/vitrini/vitrini_api";
}

-(NSData*)makeRequest:(NSMutableURLRequest*)request withPost:(NSString*)post{
    [request setTimeoutInterval:20];
    
    // Encode the post string using NSASCIIStringEncoding and also the post string you need to send in NSData format.
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    // You need to send the actual length of your data. Calculate the length of the post string.
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    // set http method
    [request setHTTPMethod:@"POST"];
    // Set HTTP header field with length of the post data.
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    // Also set the Encoded value for HTTP header Field.
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    // Set the HTTPBody of the urlrequest with postData.
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *error;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error) {
        @throw [NSException exceptionWithName:@"erro de conexão" reason:@"conexao falha" userInfo:nil];
        //@throw error;
    }
    
    return data;
}

-(void)incrementPost:(NSString**)post
            WithName:(NSString*)name
            andValue:(NSString*)value
{
    if (!value) {
        return;
    }
    if (!*post) {
        *post = [NSString stringWithFormat:@"&%@=%@",symbPack.code,[self accessCode]];
    }
    *post = [NSString stringWithFormat:@"%@&%@=%@",*post,name,value];
}

-(VIResponse*)createResponseFromData:(NSData*)data{
    return [[VIResponse alloc]initWithResponse:data];
}


//////////////////////////
//////// PUBLICOS ////////
//////////////////////////

/////////////////////////////////////////////////////////////////
//
// USAR O PADRAO ABAIXO PARA CRIAR OS REQUESTS
//
/////////////////////////////////////////////////////////////////
-(VIResponse *) requestName{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/REQUESTNAME",[self serverAddress]]]];
    
    // CRIAR STRING DE DADOS PARA REALIZAR POST
    NSString *post;
    [self incrementPost:&post WithName:symbPack.name andValue:symbPack.name];
    
    // REALIZAR CONEXÃO
    return [self createResponseFromData:[self makeRequest:request withPost:post]];
}

/////////////////////////////////////////////////////////////////
//
//    CADASTRO DE USUARIO
//
/////////////////////////////////////////////////////////////////
-(VIResponse *)registerWithEmail:(NSString *)email andPassword:(NSString *)pass andFacebookID:(NSString *)fbID andName:(NSString *)name andCity:(NSString *)city andBirthday:(NSString *)birthday andGender:(NSString *)gender
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/register",[self serverAddress]]]];
    
    // CRIAR STRING DE DADOS PARA REALIZAR POST
    NSString *post;
    [self incrementPost:&post WithName:symbPack.email andValue:email];
    [self incrementPost:&post WithName:symbPack.password andValue:pass];
    [self incrementPost:&post WithName:symbPack.facebookID andValue:fbID];
    [self incrementPost:&post WithName:symbPack.name andValue:name];
    [self incrementPost:&post WithName:symbPack.city andValue:city];
    [self incrementPost:&post WithName:symbPack.birthday andValue:birthday];
    if ([gender isEqual:@"male"]) {
            [self incrementPost:&post WithName:symbPack.gender andValue:@"M"];
    }
    else
    {
            [self incrementPost:&post WithName:symbPack.gender andValue:@"F"];
    }
    
    // REALIZAR CONEXÃO
    return [self createResponseFromData:[self makeRequest:request withPost:post]];
    
}

/////////////////////////////////////////////////////////////////
//
//   logar user
//
/////////////////////////////////////////////////////////////////
-(VIResponse *)loginWithEmail:(NSString *)email andPassword:(NSString *)pass andFacebookID:(NSString *)facebookID
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/login",[self serverAddress]]]];
    
    // CRIAR STRING DE DADOS PARA REALIZAR POST
    NSString *post;
    [self incrementPost:&post WithName:symbPack.email andValue:email];
    [self incrementPost:&post WithName:symbPack.password andValue:pass];
    [self incrementPost:&post WithName:symbPack.facebookID andValue:facebookID];
    
    
    // REALIZAR CONEXÃO
    return [self createResponseFromData:[self makeRequest:request withPost:post]];
    
}

/////////////////////////////////////////////////////////////////
//
//   editar os dados do user
//
/////////////////////////////////////////////////////////////////
-(VIResponse *)editUserWithEmail:(NSString *)email andName:(NSString *)name andCity:(NSString *)city andBirthday:(NSString *)birthday andGender:(NSString *)gender
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/rewriteInfos",[self serverAddress]]]];
    
    // CRIAR STRING DE DADOS PARA REALIZAR POST
    NSString *post;
    [self incrementPost:&post WithName:symbPack.email andValue:email];
    [self incrementPost:&post WithName:symbPack.name andValue:name];
    [self incrementPost:&post WithName:symbPack.city andValue:city];
    [self incrementPost:&post WithName:symbPack.birthday andValue:birthday];
    [self incrementPost:&post WithName:symbPack.gender andValue:gender];
    
    
    // REALIZAR CONEXÃO
    return [self createResponseFromData:[self makeRequest:request withPost:post]];
    
}

/////////////////////////////////////////////////////////////////
//
//   LIKE OU DESLIKE NUM PRODUTO
//
/////////////////////////////////////////////////////////////////
-(VIResponse *)product:(int)productID wasLiked:(BOOL)likes byUser:(NSString *)email
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/reviewProduct",[self serverAddress]]]];
    
    // CRIAR STRING DE DADOS PARA REALIZAR POST
    NSString *post;
    [self incrementPost:&post WithName:symbPack.email andValue:email];
    [self incrementPost:&post WithName:symbPack.productID andValue:[NSString stringWithFormat:@"%d", productID]];
    
    if (likes) {
        [self incrementPost:&post WithName:symbPack.productReviewLike andValue:symbPack.liked];
    }
    else {
        [self incrementPost:&post WithName:symbPack.productReviewLike andValue:symbPack.notLiked];
    }
    
    // REALIZAR CONEXÃO
    return [self createResponseFromData:[self makeRequest:request withPost:post]];
    
}

/////////////////////////////////////////////////////////////////
//
//        PEGAR OS LIKES DE UM USER
//
/////////////////////////////////////////////////////////////////
-(VIResponse *)getProductsLikedsForUser:(NSString *)email withGender:(NSString *)gender andCategory:(int)categoryID
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getLikes",[self serverAddress]]]];
    
    // CRIAR STRING DE DADOS PARA REALIZAR POST
    NSString *post;
    [self incrementPost:&post WithName:symbPack.email andValue:email];
    [self incrementPost:&post WithName:symbPack.gender andValue:gender];
    if (categoryID != 0) {
        [self incrementPost:&post WithName:symbPack.categoryID andValue:[NSString stringWithFormat:@"%d", categoryID]];
    }
    [self incrementPost:&post WithName:symbPack.page andValue:[NSString stringWithFormat:@"%d", 0]];
    
    // REALIZAR CONEXÃO
    return [self createResponseFromData:[self makeRequest:request withPost:post]];
    
}

/////////////////////////////////////////////////////////////////
//
//        PEGAR AS INFOS DE UM PRODUTO
//
/////////////////////////////////////////////////////////////////
-(VIResponse *)getAllInfoFromProduct:(int)productID
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getProduct",[self serverAddress]]]];
    
    // CRIAR STRING DE DADOS PARA REALIZAR POST
    NSString *post;
    
    [self incrementPost:&post WithName:symbPack.productID andValue:[NSString stringWithFormat:@"%d", productID]];
    
    // REALIZAR CONEXÃO
    return [self createResponseFromData:[self makeRequest:request withPost:post]];
    
}

/////////////////////////////////////////////////////////////////
//
//        PEGAR UMA STORE
//
/////////////////////////////////////////////////////////////////
-(VIResponse *)getStoreWithID:(int)storeID
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getStore",[self serverAddress]]]];
    
    // CRIAR STRING DE DADOS PARA REALIZAR POST
    NSString *post;
    
    [self incrementPost:&post WithName:symbPack.storeID andValue:[NSString stringWithFormat:@"%d", storeID]];
    
    // REALIZAR CONEXÃO
    return [self createResponseFromData:[self makeRequest:request withPost:post]];
    
}

/////////////////////////////////////////////////////////////////
//
//        PEGAR OS PRODUTOS DE UMA LOJA
//
/////////////////////////////////////////////////////////////////
-(VIResponse *)getProductsOfStore:(int)storeID andPage:(int)page
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getProductsOfStore",[self serverAddress]]]];
    
    // CRIAR STRING DE DADOS PARA REALIZAR POST
    NSString *post;
    [self incrementPost:&post WithName:symbPack.storeID andValue:[NSString stringWithFormat:@"%d", storeID]];
    [self incrementPost:&post WithName:symbPack.page andValue:[NSString stringWithFormat:@"%d", page]];
    
    // REALIZAR CONEXÃO
    return [self createResponseFromData:[self makeRequest:request withPost:post]];
    
}

/////////////////////////////////////////////////////////////////
//
//        PEGAR PRODUTOS DOS CARTOES
//
/////////////////////////////////////////////////////////////////
-(VIResponse *)productsToReviewWithEmail:(NSString *)email
                           andCategoryID:(int)categoryID
                               andGender:(NSString *)gender
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getProductsToReview",[self serverAddress]]]];
    
    // CRIAR STRING DE DADOS PARA REALIZAR POST
    NSString *post;
    [self incrementPost:&post WithName:symbPack.page andValue:gender];
    if (categoryID) {
        [self incrementPost:&post WithName:symbPack.storeID andValue:[NSString stringWithFormat:@"%d", categoryID]];
    }
    [self incrementPost:&post WithName:symbPack.page andValue:email];
    
    // REALIZAR CONEXÃO
    return [self createResponseFromData:[self makeRequest:request withPost:post]];
    
}

/////////////////////////////////////////////////////////////////
//
//        PEGAR FILTROS
//
/////////////////////////////////////////////////////////////////
-(VIResponse *)getFilter
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getFilter",[self serverAddress]]]];
    
    // CRIAR STRING DE DADOS PARA REALIZAR POST
    NSString *post = @"";
    
    // REALIZAR CONEXÃO
    return [self createResponseFromData:[self makeRequest:request withPost:post]];
    
}


@end
