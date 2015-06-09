//
//  AccountViewController.m
//  KidsFinance
//
//  Created by Rafael  Letro on 02/04/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "AccountViewController.h"
#import "DAO.h"
#import "Enumerations.h"
#import "Utils.h"


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
    
    [Utils loadValuesFromKeychain:_currentMoneyLabel withSavingsLabel:_savingsLabel];
    
    self.navigationItem.title = @"Conta";
    self.automaticallyAdjustsScrollViewInsets = NO; // make view controllers start below the status bar
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.values count];
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
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(200, 0, 150, 43)];
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 43)];
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 100, 43)];
    
    label1.backgroundColor = [UIColor clearColor];
    label1.layer.borderColor=[[UIColor lightGrayColor]CGColor];

    label1.numberOfLines = 0;
    label1.textAlignment = NSTextAlignmentRight;
    NSManagedObject *row = [self.values objectAtIndex:indexPath.row];
    label1.text = [NSString stringWithFormat:@" %@",[row valueForKey:@"value"]];
    
    label2.text = [NSString stringWithFormat:@" %@",[self.dateFormatter stringFromDate:[row valueForKey:@"date"]]];
    
    if([[row valueForKey:@"isEarning"] integerValue] ){
        [label1 setTextColor:[UIColor greenColor]];
    }else{
        [label1 setTextColor:[UIColor redColor]];
    }
    Enumerations * enumerations = [[Enumerations alloc] init];

    NSString * category = [enumerations getDescriptionEnumeration:[[row valueForKey:@"category"] integerValue]];

    if ([category isEqualToString:@"none"]) {
        label3.text = @"";
    }else{
        label3.text = category;
    }
    
    [cell.contentView addSubview:label2];
    [cell.contentView addSubview:label3];
    [cell.contentView addSubview:label1];
    
    return cell;
}

/*
 Handles click on each row
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"Atualizar" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //TODO
        //[self updateTransaction: [self.values objectAtIndex:indexPath.row]];
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

-(void)updateTransaction:(NSManagedObject *)transaction withDictionary:(NSDictionary *)dictionary {
    DAO *dao = [[DAO alloc] init];
    [dao updateTransaction:transaction withDictionary:dictionary];
}

-(void)deleteTransaction:(NSManagedObject *)transaction withIndex:(NSInteger)index {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Confirmar" message:@"Tem certeza que deseja deletar?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Sim" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        DAO *dao = [[DAO alloc] init];
        if ([dao deleteTransaction:transaction]) {
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

@end
