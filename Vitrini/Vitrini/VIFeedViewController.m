//
//  VIFeedViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 02/02/15.
//

#import "VIFeedViewController.h"
#import "VIFeedTableViewCell.h"
#import "VIFeedSectionView.h"
#import "VIServer.h"
#import "VIResponse.h"
#import "VIStorage.h"
#import "VIColor.h"
#import "VICardInfoViewController.h"
#define sectionHeight 45

@interface VIFeedViewController ()

@end

@implementation VIFeedViewController {
    int page;
    BOOL feedIsLoading;
}

- (void)viewDidLoad {
    _feed = [[NSMutableArray alloc]init];
    page = 0;
    feedIsLoading = NO;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //adicionar refresh control. para poder atualizar o feed
    _refresh = [[UIRefreshControl alloc]init];
    [_refresh addTarget:self action:@selector(refreshFeed) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refresh];
    
    [self refreshFeed];
    
    // status
    UIView *status = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    status.backgroundColor = [VIColor blueVIColor];
    
    [self.view addSubview:status];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(UIImage *)itemMenuIcon
{
    return [UIImage imageNamed:@"Vitrini_novidades_icon"];
}

-(NSString *)itemMenuTitle
{
    return @"Feed";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VIFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedCell"];
    
    cell.productDict = [_feed objectAtIndex:indexPath.section];
    [cell mountCell];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_feed count];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    VIFeedSectionView *view = [[VIFeedSectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, sectionHeight) andDict:[_feed objectAtIndex:section]];
    view.feedVC = self;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.width +10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *cards = [UIStoryboard storyboardWithName:@"Cards" bundle:nil];
    VICardInfoViewController *info = [cards instantiateViewControllerWithIdentifier:@"VICardInfoViewControllerID"];

    VIProduct *auxProduct = [[VIProduct alloc]initWithProductFromServer:[_feed objectAtIndex:(long)indexPath.section]];
    info.product = auxProduct;
    [self presentViewController:info animated:YES completion:nil];
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)refreshFeed{
    page = 0;
    [_feed removeAllObjects];
    [self loadFeed];
}

-(void) loadFeed
{
    if (!feedIsLoading) {
        feedIsLoading = YES;
        //***********************************************
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [_acitivityIndicator startAnimating];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            VIServer *server = [[VIServer alloc]init];
            VIResponse *response;
            @try {
                NSLog(@"%d",page);
                response = [server getFeedForUser:[VIStorage sharedStorage].user.email andPage:page];
            }
            @catch (NSException *exception) {
                response = nil;
                NSLog(@"colocar alerta");
            }
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [_acitivityIndicator stopAnimating];
                [_refresh endRefreshing];
                if (!response){
                    // alerta
                    
                } else if (response.status == VIRequestSuccess) {
                    page++;
                    NSArray *newFeeds = [NSArray arrayWithArray:response.value];
                    NSLog(@"nf: %@",newFeeds);
                    [_feed addObjectsFromArray:newFeeds];
                    [_tableView reloadData];
                    
                    feedIsLoading = NO;
                } else {
                    feedIsLoading = NO;
                }
                
            });
        });
        //****************************************************
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat actualPosition = scrollView.contentOffset.y + self.view.frame.size.height;
    CGFloat contentHeight = scrollView.contentSize.height - (200);
    if (actualPosition >= contentHeight) {
        [self loadFeed];
    }
}

@end
