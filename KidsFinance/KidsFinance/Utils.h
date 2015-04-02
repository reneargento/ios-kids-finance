//
//  Utils.h
//  KidsFinance
//
//  Created by Rene Argento on 4/1/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

@interface Utils: NSObject

+(void)saveValueInKeychain: (NSString*)key withValue:(NSString*)value;
+(NSString*)getValueFromKeychain: (NSString*)key;
+(NSString*)formatNumber:(double)number;

@end