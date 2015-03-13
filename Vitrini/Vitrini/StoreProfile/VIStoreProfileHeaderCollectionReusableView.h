//
//  VIStoreProfileHeaderCollectionReusableView.h
//  Vitrini
//
//  Created by Paulo Magalhães Germano on 2/18/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface VIStoreProfileHeaderCollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet AsyncImageView *backgroundLoja;
@property (weak, nonatomic) IBOutlet AsyncImageView *logoLoja;
@property (weak, nonatomic) IBOutlet UITextView *descricaoLoja;
@property (weak, nonatomic) IBOutlet UIButton *seguirLoja;
@property (weak, nonatomic) IBOutlet UIButton *localizacaoLoja;

@end
