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
    [self saveTransactionOnCoreData];
    
    [self updateCurrentMoneyOnKeyChain];
}

- (void)saveTransactionOnCoreData {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Transactions" inManagedObjectContext:self.appDelegate.managedObjectContext];
    self.transactionsCurrent = [[Transactions alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    
    [self.transactionsCurrent setDescriptionTransaction: self.descriptionField.text ];
    [self.transactionsCurrent setValue: [NSNumber numberWithDouble:[self.valueField.text doubleValue]]];
    [self.transactionsCurrent setDate:self.dateTransationPicker.date];
    [self.transactionsCurrent setCategory: self.category];
    [self.transactionsCurrent setIsEarning:self.isAddMoney];
    
    DAO * daoOperation = [[DAO alloc] init];
    [daoOperation saveTransaction:self.transactionsCurrent];
}

- (void)updateCurrentMoneyOnKeyChain {
    double currentMoney;
    
    NSString *currentMoneyOnKeyChain = [Utils getValueFromKeychain:CURRENT_MONEY_KEY];
    if(currentMoneyOnKeyChain != nil) {
        currentMoney = [currentMoneyOnKeyChain doubleValue];
    } else {
        currentMoney = 0;
    }
    
    currentMoney += [self.valueField.text doubleValue];
    [Utils saveValueInKeychain:[NSNumber ]currentMoney withValue:CURRENT_MONEY_KEY];
}

@end
