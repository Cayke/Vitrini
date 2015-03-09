//
//  VIFeedTableViewCell.h
//  Vitrini
//
//  Created by Cayke Prudente on 02/02/15.
//

#import <UIKit/UIKit.h>

#import "VIProduct.h"
#import "AsyncImageView.h"

@interface VIFeedTableViewCell : UITableViewCell

@property (nonatomic) NSDictionary *productDict;
@property (weak, nonatomic) IBOutlet AsyncImageView *productImage;

-(void)mountCell;

@end
