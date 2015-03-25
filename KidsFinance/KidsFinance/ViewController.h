//
//  ViewController.h
//  KidsFinance
//
//  Created by Rene Argento on 3/25/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *currentMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *savingsLabel;

- (IBAction)addMoneyButton:(id)sender;
- (IBAction)subtractMoneyButton:(id)sender;
- (IBAction)configurationsButton:(id)sender;


@end

