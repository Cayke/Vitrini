//
//  VIServer.h
//  Vitrini
//
//  Created by Cayke Prudente on 19/02/15.
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
                        andGender:(NSString *) gender;
//                         andImage:(NSData *) image;

//valida o login por email e senha. retorna se e valido ou nao
-(VIResponse *) loginWithEmail:(NSString *) email
                   andPassword:(NSString *) pass
                 andFacebookID:(NSString *) facebookID;

//manda os likes(facebook) de um usuario
-(VIResponse *) sendUser:(NSString *) email
              likesArray:(NSArray *) likes;

////////////////////////////
///     tela vitrini     ///
////////////////////////////
// retorna produtos com suas infos
-(VIResponse *) productsToReviewWithEmail:(NSString*)email
                            andCategoryID:(int)categoryID
                                andGender:(NSString*)gender;

//quando uma pessoa da like ou deslike num product manda para o server
-(VIResponse *) product:(int) productID wasLiked:(BOOL) likes byUser:(NSString *) email;

////////////////////////////
///     tela likeds     ///
////////////////////////////
//essa request retorna uma lista de produtos que o usuario curtiu, porem os produtos conterao apenas foto e id...
-(VIResponse *) getProductsLikedsForUser:(NSString *) email
                              withGender:(NSString *) gender
                             andCategory:(int) categoryID;
//aqiu viria todos os filtros dizendo se ta ativo ou nao?

//clicando numa foto
//-(VIResponse *) getAllInfoFromProduct:(int) productID;

////////////////////////////
///    tela catalogo     ///
////////////////////////////
//todo : criar request quando tiver o search...

//request que retornas as categorias com nome e foto
-(VIResponse *) getCategories;

//clicando numa categoria, vai mostrar os produtos daquela...
//todo riheldo : criar essa request no server e no app
-(VIResponse *) getProductsForCategory:(int) categoryID;

//clicando no produto baixa ele por completo...
//-(VIResponse *) getAllInfoFromProduct:(int) productID;

////////////////////////////
///      tela feed       ///
////////////////////////////
//retorna o feed do usuario...(loja e foto do produto)
-(VIResponse *) getFeedForUser:(NSString *) email andPage:(int)page;

//clicando no produto
//-(VIResponse *) getAllInfoFromProduct:(int) productID;

//clicando na loja
-(VIResponse *) getStoreWithID:(int) storeID andUserEmail:(NSString*)email;
-(VIResponse *) getProductsOfStore:(int) storeID andPage:(int) page;

//usuario seguiu/deseguiu loja
-(VIResponse *) user:(NSString *) email
          willFollow:(BOOL) follow
               store:(int) storeID;

////////////////////////////
///     tela perfil      ///
////////////////////////////
//editar dados usuario
-(VIResponse *) editUserWithEmail:(NSString *) email
                          andName:(NSString *) name
                          andCity:(NSString *) city
                      andBirthday:(NSString *) birthday
                        andGender:(NSString *) gender;

-(VIResponse*)getFilter;


////////////////////////////
///     tela perfil      ///
////////////////////////////

-(NSURL*)urlToDownloadImageName:(NSString*)imageName;

@end
