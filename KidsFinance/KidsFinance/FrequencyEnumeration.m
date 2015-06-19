//
//  FrequencyEnumeration.m
//  KidsFinance
//
//  Created by Rene Argento on 6/18/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "FrequencyEnumeration.h"

@implementation FrequencyEnumeration

+(NSString *) getFrequencyEnumerationString:(long)value {
    NSString *frequency;
    
    switch (value) {
        case 0:
            frequency = @"Diária";
            break;
        case 1:
            frequency = @"Semanal";
            break;
        case 2:
            frequency = @"Mensal";
            break;
        default:
            break;
    }
    
    return frequency;
}

+(long) getFrequencyEnumerationLong:(NSString *)value {
    long frequency;
    
    if ([value isEqualToString:@"Diária"]) {
        frequency = 0;
    } else if ([value isEqualToString:@"Semanal"]) {
        frequency = 1;
    } else if ([value isEqualToString:@"Mensal"]) {
        frequency = 2;
    }
    
    return frequency;
}

@end
