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

-(void)saveValueInKeychain: (NSString*)key withValue:(NSString *)value {
    [JNKeychain saveValue:value forKey:key];
}

-(NSString *)getValueFromKeychain:(NSString *)key {
    return [JNKeychain loadValueForKey:key];
}

@end

