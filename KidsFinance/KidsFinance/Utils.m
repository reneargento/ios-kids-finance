//
//  Utils.m
//  KidsFinance
//
//  Created by Rene Argento on 4/1/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"
#import "JNKeychain.h"
#import "Constants.h"

@interface Utils ()

@end

@implementation Utils

+(void)saveValueInKeychain: (NSString*)key withValue:(id)value {
    [JNKeychain saveValue:value forKey:key];
}

+(id)getValueFromKeychain:(NSString *)key {
    return [JNKeychain loadValueForKey:key];
}

+(NSString*)formatNumber:(double)number {
    NSNumberFormatter *doubleValueWithMaxTwoDecimalPlaces = [[NSNumberFormatter alloc] init];
    [doubleValueWithMaxTwoDecimalPlaces setNumberStyle:NSNumberFormatterDecimalStyle];
    [doubleValueWithMaxTwoDecimalPlaces setMaximumFractionDigits:2];
    
    NSNumber *numberObject = [NSNumber numberWithDouble:number];
    NSString *formattedValue = [doubleValueWithMaxTwoDecimalPlaces stringFromNumber:numberObject];
    return formattedValue;
}

@end

