//
//  VIFeedViewController.m
//  Vitrini
//
//  Created by Cayke Prudente on 02/02/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VIFeedViewController.h"
#import "VIFeedTableViewCell.h"

@interface VIFeedViewController ()

@end

@implementation VIFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    return [UIImage imageNamed:@"Icon_feed_Menu"];
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
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"rivaldo";
}



@end
