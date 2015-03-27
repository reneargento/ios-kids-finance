//
//  ViewController.h
//  KidsFinance
//
//  Created by Rene Argento on 3/25/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *currentMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *savingsLabel;
@property (strong, nonatomic) NSString *databasePath; // create a ponter to database in APP
@property (nonatomic)sqlite3 *DB; 


- (IBAction)addMoneyButton:(id)sender;
- (IBAction)subtractMoneyButton:(id)sender;
- (IBAction)configurationsButton:(id)sender;

@end

