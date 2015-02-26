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
    return @"http://127.0.0.1:8000/appinterface";
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

@end
