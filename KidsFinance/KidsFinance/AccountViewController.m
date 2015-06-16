//
//  AccountViewController.m
//  KidsFinance
//
//  Created by Rafael  Letro on 02/04/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "AccountViewController.h"
#import "CategoryViewController.h"
#import "TransactionViewController.h"
#import "DAO.h"
#import "Enumerations.h"
#import "Utils.h"
#import "TransactionCell.h"
#import "Constants.h"


@interface AccountViewController ()
@property (weak, nonatomic) IBOutlet UILabel *initialDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *finalDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *savingsLabel;
@property (nonatomic,strong) NSMutableArray * accountList;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic,strong) NSMutableArray *values;
@property (nonatomic,strong) DAO * daoOperation;
@property (nonatomic,strong) UIAlertView* dateAlert;
@property (nonatomic,strong) UIDatePicker * datePicker;
@property (weak, nonatomic) IBOutlet UITableView *lancTable;
@property bool isInitial;
@property (weak, nonatomic) Transactions *currentTransaction;
@end


@implementation AccountViewController

-(void)viewDidLoad
{
    self.accountList = [[NSMutableArray alloc] init];
    self.values = [[NSMutableArray alloc] init];
    NSDate* date2 = [NSDate date];
    self.dateFormatter = [[NSDateFormatter alloc]init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.initialDateLabel.text =@"";
    self.finalDateLabel.text =@"";
    self.finalDateLabel.text =[self.dateFormatter stringFromDate:date2];
    self.daoOperation = [[DAO alloc] init];
    self.values = [self.daoOperation getData:nil withFinalDate:date2];

    self.dateAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Data:" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Confirmar", nil];
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(10, self.dateAlert.bounds.size.height, 320, 216)];
    [self.dateAlert addSubview:self.datePicker];
    self.dateAlert.bounds = CGRectMake(0, 0, 320 + 20, self.dateAlert.bounds.size.height + 216 + 20);
    [self.dateAlert setValue:self.datePicker forKey:@"accessoryView"];
    
    self.navigationItem.title = @"Conta";
    self.automaticallyAdjustsScrollViewInsets = NO; // make view controllers start below the status bar
}

-(void)viewWillAppear:(BOOL)animated {
    //These methods need to be on viewWillAppear in case we are returning from an update
    [self.lancTable reloadData];
    
    [Utils loadValuesFromKeychain:self.currentMoneyLabel withSavingsLabel:self.savingsLabel];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.values count];
}

/*
 Customizes each cell of the table
 */
- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"TransactionTableCell";
    
    TransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[TransactionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //Date
    NSManagedObject *row = [self.values objectAtIndex:indexPath.row];
    cell.dateLabel.text = [NSString stringWithFormat:@" %@",[self.dateFormatter stringFromDate:[row valueForKey:@"date"]]];
    
    //Category
    Enumerations * enumerations = [[Enumerations alloc] init];
    NSString * category = [enumerations getDescriptionEnumeration:[[row valueForKey:@"category"] integerValue]];
    if ([category isEqualToString:@"none"]) {
        cell.categoryLabel.text = @"";
    }else{
        cell.categoryLabel.text = category;
    }
    
    //Value
    cell.valueLabel.textAlignment = NSTextAlignmentRight;
    cell.valueLabel.text = [NSString stringWithFormat:@" %@",[row valueForKey:@"value"]];
    
    if([[row valueForKey:@"isEarning"] integerValue] ){
        [cell.valueLabel setTextColor:[UIColor greenColor]];
    }else{
        [cell.valueLabel setTextColor:[UIColor redColor]];
    }

    return cell;
}

/*
 Handles click on each row
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"Atualizar" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        self.currentTransaction = self.values[indexPath.row];
        if(self.currentTransaction.isEarning) {
            [self performSegueWithIdentifier:GO_TO_TRANSACTION_SEGUE sender:self];
        } else {
            [self performSegueWithIdentifier:GO_TO_CATEGORIES_SEGUE sender:self];
        }
    }];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Apagar" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self deleteTransaction: [self.values objectAtIndex:indexPath.row] withIndex:indexPath.row];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        nil;
    }];
    
    [alertController addAction:updateAction];
    [alertController addAction:deleteAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
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


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        self.values = [[NSMutableArray alloc] initWithArray:@[]];
        [self.lancTable reloadData];
         NSDate * dataSelected = [self.datePicker date];
         NSLog(@"%@",[self.dateFormatter stringFromDate:dataSelected]);
        if (self.isInitial) {
            self.initialDateLabel.text = [self.dateFormatter stringFromDate:dataSelected];
        }else{
            self.finalDateLabel.text = [self.dateFormatter stringFromDate:dataSelected];
        }
        
        
        if ([self.initialDateLabel.text isEqualToString:@""]) {
            self.values = [self.daoOperation getData:nil withFinalDate:[self.dateFormatter dateFromString:self.finalDateLabel.text]];
        }else if([self.finalDateLabel.text isEqualToString:@""]){
            self.values = [self.daoOperation getData:[self.dateFormatter dateFromString:self.initialDateLabel.text] withFinalDate:nil];
        }else{
            NSLog(@"%@",[self.dateFormatter dateFromString:self.initialDateLabel.text]);
            self.values = [self.daoOperation getData:[self.dateFormatter dateFromString:self.initialDateLabel.text] withFinalDate:[self.dateFormatter dateFromString:self.finalDateLabel.text]];
        }
        
        [self.lancTable reloadData];
    }
    
    NSLog(@"%lu",[self.values count]);
    
}

- (IBAction)initialSetData:(id)sender {
    
    self.isInitial = YES;
    [self.dateAlert show];

}

- (IBAction)finalSetData:(id)sender {
    
    self.isInitial = NO;
    [self.dateAlert show];
}

-(void)deleteTransaction:(NSManagedObject *)transaction withIndex:(NSInteger)index {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Confirmar" message:@"Tem certeza que deseja deletar?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Sim" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSNumber *value = ((Transactions*)transaction).value;
        BOOL isEarning = !((Transactions*)transaction).isEarning;
        
        DAO *dao = [[DAO alloc] init];
        if ([dao deleteTransaction:transaction]) {
            //Transaction deleted successfully
            
            [Utils updateCurrentMoneyOnKeyChain:[value doubleValue] withIsAddMoney:isEarning];
            [Utils loadValuesFromKeychain:self.currentMoneyLabel withSavingsLabel:self.savingsLabel];
            
            [self.values removeObjectAtIndex:index];
            [self.lancTable reloadData];
        }
    }];
    UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"Não" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        return;
    }];
    
    [alertController addAction:confirmAction];
    [alertController addAction:returnAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:GO_TO_CATEGORIES_SEGUE]) {
        CategoryViewController *categoryViewController = segue.destinationViewController;
        categoryViewController.isUpdate = YES;
        categoryViewController.transactionToUpdate = self.currentTransaction;
    } else if([[segue identifier] isEqualToString:GO_TO_TRANSACTION_SEGUE]) {
        TransactionViewController *transactionViewController = segue.destinationViewController;
        transactionViewController.isUpdate = YES;
        transactionViewController.transactionToUpdate = self.currentTransaction;
        transactionViewController.isAddMoney = YES;
        transactionViewController.category = TransactionCategoryNone;
    }
}

@end
