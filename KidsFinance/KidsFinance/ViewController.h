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

@property (weak, nonatomic) IBOutlet UIImageView *addMoneyButton;
@property (weak, nonatomic) IBOutlet UIImageView *substractMoneyButton;
@property (weak, nonatomic) IBOutlet UIImageView *configurationsButton;

@end

