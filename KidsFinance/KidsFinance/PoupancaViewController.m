//
//  PoupancaViewController.m
//  KidsFinance
//
//  Created by Rafael  Letro on 02/04/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "PoupancaViewController.h"
#import "Utils.h"
#import "Constants.h"

@interface PoupancaViewController()
    @property (nonatomic,strong) UIAlertView * alertPoupanca;
    @property (weak, nonatomic) IBOutlet UITableView *poupancaTableView;
    @property (nonatomic,strong) NSArray * poupancaSections;
@end

@implementation PoupancaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor colorWithRed:82.0/255.0 green:177.0/255.0 blue:193.0/255.0 alpha:1.0]];
    

    
    self.poupancaSections = [NSArray arrayWithObjects:@"Poupar",@"Meta" , nil];
    
    self.navigationItem.title = @"Poupança";
    self.automaticallyAdjustsScrollViewInsets = NO; // make view controllers start below the status bar
    
    self.alertPoupanca = [[UIAlertView alloc] initWithTitle:@"Poupança" message:@"Quanto você desejaa poupar?" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Confirmar", nil];
    [self.alertPoupanca setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Teste");
    return [self.poupancaSections count];
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
    
    cell.textLabel.text = [self.poupancaSections objectAtIndex:indexPath.row];
    [cell setBackgroundColor:[UIColor clearColor]];
    

    
    return cell;
}

/*
 Handles click on each row
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
            [self.alertPoupanca setTitle:@"Poupar"];
            [self.alertPoupanca setMessage:@"Quanto deseja poupar?"];
            [self.alertPoupanca textFieldAtIndex:0].text = @"0.00";
            [self.alertPoupanca  show];
            break;
        case 1:
            [self.alertPoupanca setTitle:@"Meta"];
            [self.alertPoupanca setMessage:@"Qual sua meta de poupança?"];
            
            if ([Utils getValueFromKeychain:TARGET_KEY] == nil) {
                [self.alertPoupanca textFieldAtIndex:0].text = @"0.00";
            }else{
                [self.alertPoupanca textFieldAtIndex:0].text = [Utils getValueFromKeychain:TARGET_KEY];
            }
            
            [self.alertPoupanca  show];
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        double saldoAtual =  00.00;
        double savings = 00.00;
        NSString *saldoFormatted;
        NSString *savingsFormatted;
        
        switch ([self.poupancaTableView indexPathForSelectedRow].row ) {
            case 0:
                if ([Utils getValueFromKeychain:SAVINGS_KEY]  != nil) {
                    saldoAtual = [[Utils getValueFromKeychain:SAVINGS_KEY] doubleValue];
                }
                
                saldoAtual += [[[self.alertPoupanca textFieldAtIndex:0] text] doubleValue];
                saldoFormatted = [Utils formatNumber:saldoAtual];
                
                NSLog(@"Saldo: %@",saldoFormatted);
                [Utils saveValueInKeychain:SAVINGS_KEY withValue:saldoFormatted];
                break;
            case 1:
                savings = [[[self.alertPoupanca textFieldAtIndex:0] text] doubleValue];
                savingsFormatted = [Utils formatNumber:savings];
                
                NSLog(@"Poupança: %@",savingsFormatted);
                [Utils saveValueInKeychain:TARGET_KEY withValue:savingsFormatted];
                break;
            default:
                break;
        }
        
        NSLog(@"%@",[Utils getValueFromKeychain:TARGET_KEY]);
        NSLog(@"%@",[Utils getValueFromKeychain:SAVINGS_KEY]);
        
    }
}

@end

