//
//  FrequencyEnumeration.h
//  KidsFinance
//
//  Created by Rene Argento on 6/18/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FrequencyEnumeration : NSObject

+(NSString *) getFrequencyEnumerationString:(long) value;
+(long) getFrequencyEnumerationLong:(NSString *) value;

enum {
    FrequencyDaily,
    FrequencyWeekly,
    FrequencyMonthly
};

@end
