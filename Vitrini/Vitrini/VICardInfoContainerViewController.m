//
//  VICardInfoContainerViewController.m
//  Vitrini
//
//  Created by Willian Pinho on 2/8/15.
//  Copyright (c) 2015 Willian Pinho. All rights reserved.
//

#import "VICardInfoContainerViewController.h"
#import "VICardInfoInformationOfTheSelectedItemViewController.h"
@interface VICardInfoContainerViewController ()

@end

@implementation VICardInfoContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    
    self.informationProduct = @[@"1", @"2", @"3"];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.informationProduct count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell Identifier";
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    // Fetch Information
    NSString *informationProduct = [self.informationProduct objectAtIndex:[indexPath row]];
    
    [cell.textLabel setText:informationProduct];
    [cell setAccessoryType:UITableViewCellAccessoryDetailButton];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *cards = [UIStoryboard storyboardWithName:@"Cards" bundle:nil];
    VICardInfoInformationOfTheSelectedItemViewController *informationOTSIVC = (VICardInfoInformationOfTheSelectedItemViewController *)[cards instantiateViewControllerWithIdentifier:@"VICardInfoInformationOfTheSelectedItemViewControllerID"];
    [self presentViewController:informationOTSIVC animated:YES completion:nil];
    
    
}

@end
