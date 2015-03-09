//
//  VIFeedTableViewCell.m
//  Vitrini
//
//  Created by Cayke Prudente on 02/02/15.
//

#import "VIFeedTableViewCell.h"

@implementation VIFeedTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)mountCell{
    NSString *imageName = [[_productDict objectForKey:@"photo"] objectAtIndex:0];
    _productImage.activityIndicatorStyle = UIActivityIndicatorViewStyleWhiteLarge;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://107.170.189.125/vitrini/default/download/db/%@", imageName]];
    _productImage.imageURL = url;
}

@end
