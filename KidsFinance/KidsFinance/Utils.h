//
//  Utils.h
//  KidsFinance
//
//  Created by Rene Argento on 4/1/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Utils: NSObject

+(void)saveValueInKeychain: (NSString*)key withValue:(NSString*)value;
+(NSString*)getValueFromKeychain: (NSString*)key;
+(NSString*)formatNumber:(double)number;
+(void)loadValuesFromKeychain:(UILabel *)currentMoneyLabel withSavingsLabel:(UILabel *)savingsLabel;
+(void)updateCurrentMoneyOnKeyChain:(double)value withIsAddMoney:(BOOL)isAddMoney;

@end