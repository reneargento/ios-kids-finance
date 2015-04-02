//
//  DAO.h
//  KidsFinance
//
//  Created by Rene Argento on 3/31/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//
#import "Transactions.h"

@interface DAO : NSObject

- (BOOL)saveTransaction:(Transactions*) transaction;
- (NSMutableArray*)getData:(NSDate*)initialDate withFinalDate:(NSDate*)endDate;

@end
