//
//  Enumerations.h
//  KidsFinance
//
//  Created by Carolina Bonturi on 3/27/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface Enumerations : NSObject
-(NSString *) getCategoryEnumeration:(long) value;

enum {
    TransactionCategoryEducation,
    TransactionCategoryFood,
    TransactionCategoryFun,
    TransactionCategoryToys,
    TransactionCategoryOther,
    TransactionCategoryNone
};
typedef NSInteger TransactionCategory;

@end