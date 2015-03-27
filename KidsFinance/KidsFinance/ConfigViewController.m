//
//  ConfigViewController.m
//  KidsFinance
//
//  Created by Rene Argento on 3/27/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "ConfigViewController.h"

@interface ConfigViewController ()

@end

@implementation ConfigViewController
{
    NSArray *configSections;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    configSections = [NSArray arrayWithObjects:@"Poupança", @"Relatório", @"Sobre o Aplicativo" , nil];
    self.navigationItem.title = @"Configurações";
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

/*
 Returns the number of rows that will be displayed in the table
 */
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [configSections count];
}

/*
 Customizes each cell of the table
 */
- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [configSections objectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"Money Box.png"];
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"Report Card.png"];
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"About.png"];
            break;
        default:
            break;
    }
    
    
    return cell;
}

/*
 Handles click on each row
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO
    switch (indexPath.row) {
        case 0:
            ViewControllerInfo* infoController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerInfo"];
            [self.navigationController pushViewController:infoController animated:YES];
            break;
        default:
            break;
    }
}

/*
 Used to remove empty cells from the table
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == tableView.numberOfSections - 1) {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    }
    return nil;
}

/*
 Used to remove empty cells from the table
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == tableView.numberOfSections - 1) {
        return 1;
    }
    return 0;
}

@end
