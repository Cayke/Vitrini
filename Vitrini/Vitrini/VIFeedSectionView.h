//
//  VIFeedSectionView.h
//  Vitrini
//
//  Created by Cayke Prudente on 03/02/15.
//

#import <UIKit/UIKit.h>
#import "VIFeedViewController.h"

@interface VIFeedSectionView : UIView

@property (nonatomic, weak) VIFeedViewController *feedVC;

-(instancetype)initWithFrame:(CGRect)frame andDict:(NSDictionary*)dict;

@end
