//
//  TransationsViewController.m
//  KidsFinance
//
//  Created by Rafael  Letro on 31/03/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "AppDelegate.h"
#import "TransationsViewController.h"
#import "Transactions.h"
#import "DAO.h"
#import "Utils.h"
#import "Constants.h"

@interface TransationsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;

@property (weak, nonatomic) IBOutlet UIDatePicker *dateTransationPicker;
@property AppDelegate * appDelegate;
@property (strong, nonatomic) Transactions * transactionsCurrent;
@end

@implementation TransationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmTransationClicked:(id)sender {
    BOOL wasTransactionSuccessful;
    
    if ([self saveTransactionOnCoreData]) {
        wasTransactionSuccessful = YES;
        
        [self updateCurrentMoneyOnKeyChain: self.isAddMoney];
    } else {
        wasTransactionSuccessful = NO;
    }
    
    [self showResultPopup:wasTransactionSuccessful];
    [self clearFields];
}

- (BOOL)saveTransactionOnCoreData {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Transactions" inManagedObjectContext:self.appDelegate.managedObjectContext];
    self.transactionsCurrent = [[Transactions alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    
    [self.transactionsCurrent setDescriptionTransaction: self.descriptionField.text ];
    [self.transactionsCurrent setValue: [NSNumber numberWithDouble:[self.valueField.text doubleValue]]];
    [self.transactionsCurrent setDate:self.dateTransationPicker.date];
    [self.transactionsCurrent setCategory: self.category];
    [self.transactionsCurrent setIsEarning:self.isAddMoney];
    
    DAO * daoOperation = [[DAO alloc] init];
    return [daoOperation saveTransaction:self.transactionsCurrent];
}

- (void)updateCurrentMoneyOnKeyChain:(BOOL)isAddMoney {
    double currentMoney;
    
    NSString *currentMoneyOnKeyChain = [Utils getValueFromKeychain:CURRENT_MONEY_KEY];
    if(currentMoneyOnKeyChain != nil) {
        currentMoney = [currentMoneyOnKeyChain doubleValue];
    } else {
        currentMoney = 0;
    }
    
    if(isAddMoney) {
        currentMoney += [self.valueField.text doubleValue];
    } else {
        currentMoney -= [self.valueField.text doubleValue];
    }
    
    [Utils saveValueInKeychain:CURRENT_MONEY_KEY withValue:[NSString stringWithFormat:@"%.20f", currentMoney]];
}

- (void)showResultPopup:(BOOL) isSuccess{
    NSString *title;
    NSString *message;
    
    if(isSuccess) {
        title = @"Sucesso";
        message = @"Valores atualizados!";
    } else {
        title = @"Erro";
        message = @"Ocorreu um problema ao tentar atualizar os valores";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) clearFields{
    self.valueField.text = @"";
    self.descriptionField.text = @"";
}

@end
