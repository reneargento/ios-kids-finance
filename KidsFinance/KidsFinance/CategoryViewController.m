//
//  CategoryViewController.m
//  KidsFinance
//
//  Created by Rafael  Letro on 31/03/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "CategoryViewController.h"
#import "Enumerations.h"
#import "TransationsViewController.h"

@interface CategoryViewController ()
@property (nonatomic,strong) NSArray * categorySections;
@property long selectedRow;
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.categorySections = @[@"Educação",@"Comida",@"Diversão",@"Brinquedos",@"Outros"];
    
    self.navigationItem.title = @"Categorias";
    self.automaticallyAdjustsScrollViewInsets = NO; // make view controllers start below the status bar
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"removeMoney"]){

        TransationsViewController *transferViewController = segue.destinationViewController;
        
        transferViewController.isAddMoney = NO;
        transferViewController.category = [self getCategoryByTable];
    }
}




- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.categorySections count];
}


- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.categorySections objectAtIndex:indexPath.row];
        
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO
    self.selectedRow = indexPath.row;
   

    [self performSegueWithIdentifier:@"removeMoney" sender:self];
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




-(long) getCategoryByTable
{
    
    
    switch (self.selectedRow) {
        case 0:
            return TransactionCategoryEducation;
            break;
        case 1:
            return TransactionCategoryFood;
            break;
        case 2:
            return TransactionCategoryFun;
            break;
        case 3:
            return TransactionCategoryToys;
            break;
        case 4:
            return TransactionCategoryOther;
            break;
        default:
            return TransactionCategoryNone;
            break;
    }
}

@end
