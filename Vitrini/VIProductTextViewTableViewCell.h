//
//  VIProductTextViewTableViewCell.h
//  Vitrini
//
//  Created by Cayke Prudente on 15/03/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIProductTextViewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *productDescription;

-(void) mountWithDescription:(NSString *) productDescription;

@end
