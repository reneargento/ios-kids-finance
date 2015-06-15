//
//  CategoryViewController.h
//  KidsFinance
//
//  Created by Rafael  Letro on 31/03/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transactions.h"

@interface CategoryViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) BOOL isUpdate;
@property (nonatomic, weak) Transactions *transactionToUpdate;

@end