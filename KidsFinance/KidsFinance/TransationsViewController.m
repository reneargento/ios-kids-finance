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

@interface TransationsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property AppDelegate * appDelegate;
@property (strong, nonatomic) Transactions * transactionsCurrent;
@end

@implementation TransationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%lu",self.category);
    NSLog(@"%d",self.isAddMoney);
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)confirmTransationClicked:(id)sender {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Transactions" inManagedObjectContext:self.appDelegate.managedObjectContext];
    self.transactionsCurrent = [[Transactions alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    [self.transactionsCurrent setValue: [NSNumber numberWithDouble:[self.valueField.text doubleValue]]];
    
     NSLog(@"%@",self.transactionsCurrent.value);
}

@end
