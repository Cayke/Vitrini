//
//  VIFeedViewController.h
//  Vitrini
//
//  Created by Cayke Prudente on 02/02/15.
//

#import <UIKit/UIKit.h>
#import "VIProtocol.h"

@interface VIFeedViewController : UIViewController <VIViewControllerMenuItemProtocol,UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) UIRefreshControl *refresh;

//array com VIProducts
@property (nonatomic) NSMutableArray *feed;


@end
