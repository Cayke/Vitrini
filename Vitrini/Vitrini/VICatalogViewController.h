//
//  VICatalogViewController.h
//  Vitrini
//
//  Created by Cayke Prudente on 21/01/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIProtocol.h"

@interface VICatalogViewController : UIViewController <VIViewControllerMenuItemProtocol, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackground;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;

@property (nonatomic) BOOL isLoading;


@property (nonatomic) NSArray *arrayCategorys;
@property (nonatomic) NSArray *arrayStores;


@end
