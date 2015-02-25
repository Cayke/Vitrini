//
//  VIServer.h
//  Vitrini
//
//  Created by Cayke Prudente on 19/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIResponse.h"

@interface VIServer : NSObject

////////////////////////////
/// login/validacao user ///
////////////////////////////

//regsitra usuario (facebobok ou email) e recebe se foi ok ou nao
-(VIResponse *) registerWithEmail:(NSString *) email
                      andPassword:(NSString *) pass
                    andFacebookID:(NSString *) fbID
                          andName:(NSString *) name
                          andCity:(NSString *) city
                      andBirthday:(NSString *) birthday
                        andGender:(NSString *) gender
                         andImage:(NSData *) image;

//valida o login por email e senha. retorna se e valido ou nao
-(VIResponse *) loginWithEmail:(NSString *) email
                   andPassword:(NSString *) pass;

//manda os likes(facebook) de um usuario
-(VIResponse *) sendUser:(NSString *) email
              likesArray:(NSArray *) likes;

////////////////////////////
///     tela vitrini     ///
////////////////////////////
//essa request retorna uma lista de produtos, porem os produtos conterao apenas foto e id...
-(VIResponse *) getProductsForUser:(NSString *) email
                  andFilter1Active:(BOOL) filter1;
                //todo: falar com riheldo. aqiu viria todos os filtros dizendo se ta ativo ou nao?

//quando clicar no botao de info: aqui manda um id e recebe o produto em si(completo)
-(VIResponse *) getAllInfoFromProduct:(int) productID;

//quando uma pessoa da like ou deslike num product manda para o server
-(VIResponse *) product:(int) productID wasLiked:(BOOL) likes;

////////////////////////////
///     tela likeds     ///
////////////////////////////
//essa request retorna uma lista de produtos que o usuario curtiu, porem os produtos conterao apenas foto e id...
-(VIResponse *) getProductsLikedsForUser:(NSString *) email
                  andFilter1Active:(BOOL) filter1;
//aqiu viria todos os filtros dizendo se ta ativo ou nao?

//clicando numa foto
//-(VIResponse *) getAllInfoFromProduct:(int) productID;

////////////////////////////
///     tela catalogo     ///
////////////////////////////
//todo : criar request quando tiver o search...

//request que retornas as categorias com nome e foto
-(VIResponse *) getCategories;

//clicando numa categoria, vai mostrar os produtos daquela...
-(VIResponse *) getProductsForCategory:(int) categoryID;

//clicando no produto baixa ele por completo...
//-(VIResponse *) getAllInfoFromProduct:(int) productID;

////////////////////////////
///      tela feed       ///
////////////////////////////
//retorna o feed do usuario...(loja e foto do produto)
-(VIResponse *) getFeedForUser:(NSString *) email;

//clicando no produto
//-(VIResponse *) getAllInfoFromProduct:(int) productID;

//clicando na loja
-(VIResponse *) getStoreWithID:(int) storeID;

//usuario seguiu/deseguiu loja
-(VIResponse *) user:(NSString *) email
          willFollow:(BOOL) follow
               store:(int) storeID;

////////////////////////////
///     tela perfil      ///
////////////////////////////




@end
