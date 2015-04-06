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
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    // Do any additional setup after loading the view, typically from a nib.
    
    [Utils loadValuesFromKeychain:self.currentMoneyLabel withSavingsLabel:self.savingsLabel];
}

-(void)viewWillAppear:(BOOL)animated{
    [Utils loadValuesFromKeychain:self.currentMoneyLabel withSavingsLabel:self.savingsLabel];
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

@end
