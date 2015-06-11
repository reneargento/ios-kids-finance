//
//  TransationsViewController.h
//  KidsFinance
//
//  Created by Rafael  Letro on 31/03/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionViewController : UIViewController <UITextFieldDelegate>

@property BOOL isAddMoney;
@property long category;
@property BOOL isUpdate;

@end
