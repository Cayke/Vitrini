//
//  VIFeedViewController.h
//  Vitrini
//
//  Created by Cayke Prudente on 02/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIProtocol.h"

@interface VIFeedViewController : UIViewController <VIViewControllerMenuItemProtocol,UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) UIRefreshControl *refresh;

//array com VIProducts
@property (nonatomic) NSArray *feed;


@end
