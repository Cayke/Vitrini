//
//  VIProductNameAndPriceTableViewCell.h
//  Vitrini
//
//  Created by Cayke Prudente on 15/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIProductNameAndPriceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;

-(void) mountWithName:(NSString *) name
             andPrice:(float) price;

@end
