//
//  AccountViewController.m
//  KidsFinance
//
//  Created by Rafael  Letro on 02/04/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "AccountViewController.h"
#import "DAO.h"


@interface AccountViewController ()
@property (weak, nonatomic) IBOutlet UILabel *initialDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *finalDateLabel;
@property (nonatomic,strong) NSMutableArray * accountList;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@end


@implementation AccountViewController

-(void)viewDidLoad
{
    
    NSDate* now = [NSDate date];
    self.dateFormatter = [[NSDateFormatter alloc]init];
    [self.dateFormatter setDateFormat:@"dd/MM/YY"];
  
    self.finalDateLabel.text =[self.dateFormatter stringFromDate:now];
    //DAO * daoOperation = [[DAO alloc] init];
    //[daoOperation getData:<#(NSDate *)#> withFinalDate:<#(NSDate *)#>];
    
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.accountList count];
    
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
    
    cell.textLabel.text = [self.accountList objectAtIndex:indexPath.row];
    
    
    
    return cell;
}

/*
 Handles click on each row
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO
    

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
