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
@property (strong, nonatomic) NSMutableArray *valuePickerData;
@property (weak, nonatomic) IBOutlet UIPickerView *valuePicker;
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
    
    [self initValuePickerValues];
    self.valuePicker.delegate = self;
    self.valuePicker.dataSource = self;
    
    if(self.isUpdate) {
        NSString *currentValue = [self.transactionToUpdate.value stringValue];
        NSArray *values = [currentValue componentsSeparatedByString:@"."];
        
        [self.valuePicker selectRow:[values[0] integerValue] inComponent:0 animated:YES];
        [self.valuePicker selectRow:[values[1] integerValue]  inComponent:1 animated:YES];

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
    
    NSString *value = [NSString stringWithFormat:@"%ld", [self.valuePicker selectedRowInComponent:0]];
    NSString *cents = [NSString stringWithFormat:@"%ld", [self.valuePicker selectedRowInComponent:1]];
    NSString *newValue = [NSString stringWithFormat:@"%@.%@", value, cents];
    
    if(self.isUpdate) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:newValue forKey:TRANSACTION_VALUE_KEY];
        [dictionary setObject:self.dateTransationPicker.date forKey:TRANSACTION_DATE_KEY];
        [dictionary setObject:@(self.category) forKey:TRANSACTION_CATEGORY_KEY];
        
        self.valueToAdd = [newValue doubleValue] - [self.transactionToUpdate.value doubleValue];
        
        result = [dao updateTransaction:self.transactionToUpdate withDictionary:dictionary];
    } else {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Transactions" inManagedObjectContext:self.appDelegate.managedObjectContext];
        Transactions *transaction = [[Transactions alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
        
        [transaction setValue: [NSNumber numberWithDouble:[newValue doubleValue]]];
        [transaction setDate: self.dateTransationPicker.date];
        [transaction setCategory: self.category];
        
        [transaction setIsEarning:self.isAddMoney];
        
        self.valueToAdd = [newValue doubleValue];
        
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

- (void)onBackgroundTap:(id)sender{
    //when the tap gesture recognizer gets an event, it calls endEditing on the view controller's view
    //this should dismiss the keyboard
    [[self view] endEditing:YES];
}

- (void)returnOnUpdate {
    NSArray *navigationArray = self.navigationController.viewControllers;
    for (UIViewController *view in navigationArray) {
        if ([view isKindOfClass:[AccountViewController class]]) {
            [self.navigationController popToViewController:view animated:YES];
        }
    }
}

#pragma mark Picker View

- (void)initValuePickerValues {
    NSMutableArray *valuePickerDataMoney = [[NSMutableArray alloc] init];
    NSMutableArray *valuePickerDataCents = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 100; i++) {
        [valuePickerDataMoney insertObject:[NSNumber numberWithInt:i] atIndex:i];
        [valuePickerDataCents insertObject:[NSNumber numberWithInt:i] atIndex:i];
    }
    
    //Maximum value for money is 100, for cents is 99
    [valuePickerDataMoney insertObject:[NSNumber numberWithInt:100] atIndex:100];
    
    self.valuePickerData = [[NSMutableArray alloc] initWithObjects:valuePickerDataMoney, valuePickerDataCents, nil];
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    int numberOfComponents = 1;
    
    if (pickerView == self.valuePicker) {
        numberOfComponents = 2;
    }
    
    return numberOfComponents;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    long numberOfRows;
    
    if (pickerView == self.valuePicker) {
        if(component == 0) {
            numberOfRows = ((NSMutableArray *)self.valuePickerData[0]).count;
        } else {
            numberOfRows = ((NSMutableArray *)self.valuePickerData[1]).count;;
        }
    }
    
    return numberOfRows;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@", self.valuePickerData[component][row]];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return (self.view.frame.size.width * 15 ) / 100;
}

@end
