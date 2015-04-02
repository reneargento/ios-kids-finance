//
//  Enumerations.h
//  KidsFinance
//
//  Created by Carolina Bonturi on 3/27/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface Enumerations : NSObject // herda do NS Object por padrao
-(NSString *) getDescriptionEnumeration:(long) value;

enum {
    TransactionCategoryEducation,
    TransactionCategoryFood,
    TransactionCategoryFun,
    TransactionCategoryToys,
    TransactionCategoryOther,
    TransactionCategoryNone // para o caso em que só teve entrada
};
typedef NSInteger TransactionCategory; // nome do enumaration


@end