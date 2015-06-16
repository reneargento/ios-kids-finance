//
//  TransationsViewController.m
//  KidsFinance
//
//  Created by Rafael  Letro on 31/03/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "AppDelegate.h"
#import "TransactionViewController.h"
#import "Transactions.h"
#import "DAO.h"
#import "Utils.h"
#import "Constants.h"
#import "AccountViewController.h"

@interface TransactionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *valueField;

@property (weak, nonatomic) IBOutlet UIDatePicker *dateTransationPicker;
@property AppDelegate * appDelegate;
@property (nonatomic) UITapGestureRecognizer *tapRecognizer;

@property double valueToAdd;
@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self.view setBackgroundColor: [UIColor colorWithRed:82.0/255.0 green:177.0/255.0 blue:193.0/255.0 alpha:1.0]];
    
    if(self.isUpdate) {
        self.valueField.text = [self.transactionToUpdate.value stringValue];
        self.dateTransationPicker.date = self.transactionToUpdate.date;
    }

    //add a tap gesture recognizer to capture all tap events
    //this will include tap events when a user clicks off of a textfield
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundTap:)];
    self.tapRecognizer.numberOfTapsRequired = 1;
    self.tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:self.tapRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmTransationClicked:(id)sender {
    BOOL wasTransactionSuccessful;
    
    if ([self saveTransactionOnCoreData]) {
        wasTransactionSuccessful = YES;
        [Utils updateCurrentMoneyOnKeyChain:self.valueToAdd withIsAddMoney:self.isAddMoney];
    } else {
        wasTransactionSuccessful = NO;
    }
    
    [self showResultPopup:wasTransactionSuccessful];
    [self clearFields];
}

- (IBAction)cancelTransaction:(id)sender {
    if (self.isUpdate) {
        [self returnOnUpdate];
    } else {
        [self performSegueWithIdentifier:GO_TO_HOME_SEGUE sender:self];
    }
}

- (BOOL)saveTransactionOnCoreData {
    BOOL result;
    DAO *dao = [[DAO alloc] init];
    
    if(self.isUpdate) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:self.valueField.text forKey:TRANSACTION_VALUE_KEY];
        [dictionary setObject:self.dateTransationPicker.date forKey:TRANSACTION_DATE_KEY];
        [dictionary setObject:@(self.category) forKey:TRANSACTION_CATEGORY_KEY];
        
        self.valueToAdd = [self.valueField.text doubleValue] - [self.transactionToUpdate.value doubleValue];
        
        result = [dao updateTransaction:self.transactionToUpdate withDictionary:dictionary];
    } else {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Transactions" inManagedObjectContext:self.appDelegate.managedObjectContext];
        Transactions *transaction = [[Transactions alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
        
        [transaction setValue: [NSNumber numberWithDouble:[self.valueField.text doubleValue]]];
        [transaction setDate: self.dateTransationPicker.date];
        [transaction setCategory: self.category];
        
        [transaction setIsEarning:self.isAddMoney];
        
        self.valueToAdd = [self.valueField.text doubleValue];
        
        result = [dao saveTransaction:transaction];
    }
    
    return result;
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
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.isUpdate) {
        [self returnOnUpdate];
    } else {
        [self performSegueWithIdentifier:@"homeSegue" sender:self];
    }
}

- (void)clearFields{
    self.valueField.text = @"";
}


- (void)onBackgroundTap:(id)sender{
    //when the tap gesture recognizer gets an event, it calls endEditing on the view controller's view
    //this should dismiss the keyboard
    [[self view] endEditing:YES];
}

- (void) returnOnUpdate {
    NSArray *navigationArray = self.navigationController.viewControllers;
    for (UIViewController *view in navigationArray) {
        if ([view isKindOfClass:[AccountViewController class]]) {
            [self.navigationController popToViewController:view animated:YES];
        }
    }
}

@end
