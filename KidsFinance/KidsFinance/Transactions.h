//
//  Transactions.h
//  KidsFinance
//
//  Created by Carolina Bonturi on 3/27/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Enumerations.h"


@interface Transactions : NSManagedObject

@property (nonatomic,retain) NSString * descriptionTransaction;
@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic) BOOL isEarning;
@property (nonatomic) TransactionCategory category;


@end
