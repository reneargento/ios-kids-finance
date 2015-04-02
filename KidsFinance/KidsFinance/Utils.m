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

@end

