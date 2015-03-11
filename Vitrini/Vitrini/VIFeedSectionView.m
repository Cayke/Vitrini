//
//  VIFeedSectionView.m
//  Vitrini
//
//  Created by Cayke Prudente on 03/02/15.
//

#import "VIFeedSectionView.h"
#import "VIStoreProfileViewController.h"

#import "AsyncImageView.h"
#import "VIColor.h"

@implementation VIFeedSectionView {
    NSDictionary *storeDict;
}

-(instancetype)initWithFrame:(CGRect)frame andDict:(NSDictionary*)dict
{
    self = [super initWithFrame:frame];
    
    [self createLayoutWithDict:dict];
    
    return self;
}

-(void) createLayoutWithDict:(NSDictionary*)dict
{
    storeDict = [dict objectForKey:@"store"];
    
    UIBlurEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [self addSubview:visualEffectView];
    //criar botao foto loja
    UIButton *buttonStore = [[UIButton alloc]initWithFrame:CGRectMake(8, 7, 30, 30)];
    
    [self addSubview:buttonStore];
    
    //add fotinha loja
    AsyncImageView *imageView = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    NSString *imageName = [[dict objectForKey:@"store"] objectForKey:@"image"];
    imageView.activityIndicatorStyle = UIActivityIndicatorViewStyleWhiteLarge;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://107.170.189.125/vitrini/default/download/db/%@", imageName]];
    imageView.imageURL = url;
    
    //botar foto redonda
    imageView.layer.cornerRadius = imageView.frame.size.width/2;
    imageView.clipsToBounds = YES;
    
    //adicionar imageview ao button
    [buttonStore addSubview:imageView];
    [buttonStore setShowsTouchWhenHighlighted:YES];
    [buttonStore addTarget:self action:@selector(goToStorePage) forControlEvents:UIControlEventTouchUpInside];
    
    //adicionar nome da loja
    UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(50, 12, 200, 20)];
    labelName.text = [[dict objectForKey:@"store"]objectForKey:@"name"];
    
    [self addSubview:labelName];
    
    //linha seguinte para section nao ficar "transparente"
    //self.backgroundColor = [VIColor blueVIColor];
    
}

-(void) goToStorePage
{
    UIStoryboard *store = [UIStoryboard storyboardWithName:@"VIStoreProfile" bundle:nil];
    VIStoreProfileViewController *storeVC = (VIStoreProfileViewController *) [store instantiateInitialViewController];
    storeVC.storeID = [[storeDict objectForKey:@"storeID"]intValue];
    [self.feedVC presentViewController:storeVC animated:YES completion:nil];
}

@end
