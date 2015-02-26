//
//  VIFeedViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 02/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIFeedViewController.h"
#import "VIFeedTableViewCell.h"
#import "VIFeedSectionView.h"
#import "VIServer.h"
#import "VIResponse.h"
#import "VIStorage.h"

#define sectionHeight 45

@interface VIFeedViewController ()

@end

@implementation VIFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //adicionar refresh control. para poder atualizar o feed
    _refresh = [[UIRefreshControl alloc]init];
    [_refresh addTarget:self action:@selector(refreshFeed) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refresh];
    
    [self refreshFeed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    cell.productImage.image = [UIImage imageNamed:@"feed_temp"];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    VIFeedSectionView *view = [[VIFeedSectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, sectionHeight)];
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
    NSLog(@"ir para foto/produto");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) refreshFeed
{
    //***********************************************
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Call your function or whatever work that needs to be done
        //Code in this part is run on a background thread
        
        VIServer *server = [[VIServer alloc]init];
        VIResponse *response = [server getFeedForUser:[VIStorage sharedStorage].user.email];
    
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            //Stop your activity indicator or anything else with the GUI
            //Code here is run on the main thread
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [_refresh endRefreshing];
            
            //tratar algo se precisar
            if (response.status == VIRequestSuccess) {
                _feed = [NSArray arrayWithArray:response.value];
                [_tableView reloadData];
            }
            
        });
    });
    //****************************************************
    

}




@end
