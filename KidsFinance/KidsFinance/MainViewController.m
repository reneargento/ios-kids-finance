//
//  ViewController.m
//  KidsFinance
//
//  Created by Rene Argento on 3/25/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "MainViewController.h"
#import "TransationsViewController.H"
#import <UIKit/UIKit.h>
#import "Enumerations.h"
#import "Utils.h"
#import "Constants.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadValuesFromKeychain];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadValuesFromKeychain];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addMoneyButton:(id)sender {
}

- (IBAction)subtractMoneyButton:(id)sender {
}

- (IBAction)configurationsButton:(id)sender {

}

- (IBAction)AccountViewController:(id)sender {
    
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([[segue identifier] isEqualToString:@"addMoney"]){
         TransationsViewController *transferViewController = segue.destinationViewController;

         transferViewController.isAddMoney = YES;
         transferViewController.category = TransactionCategoryNone;
     }
 }

//Load current money and savings values from keychain
- (void)loadValuesFromKeychain {
    
    NSString *currentMoney = [Utils getValueFromKeychain:CURRENT_MONEY_KEY];
    if(currentMoney != nil) {
        self.currentMoneyLabel.text = @"R$ ";
        self.currentMoneyLabel.text = [self.currentMoneyLabel.text stringByAppendingString:currentMoney];
    } else {
        self.currentMoneyLabel.text = @"R$ 0,00";
    }
    
    NSString *savings = [Utils getValueFromKeychain:SAVINGS_KEY];
    if(savings != nil) {
        self.savingsLabel.text = @"R$ ";
        NSLog(@"%@",savings);
        self.savingsLabel.text = [self.savingsLabel.text stringByAppendingString:savings];
    } else {
        self.savingsLabel.text = @"R$ 0,00";
    }
}


@end
