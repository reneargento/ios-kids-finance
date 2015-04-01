//
//  Utils.m
//  KidsFinance
//
//  Created by Rene Argento on 4/1/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"
#import "KeychainItemWrapper.h"
#import "Constants.h"

@interface Utils ()

@end

@implementation Utils

-(void)saveValueInKeychain: (NSString*)key withValue:(NSString *)value {
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:keychainIdentifier accessGroup:nil];
}

-(NSString *)getValueFromKeychain:(NSString *)key {
    return nil;
}

@end

