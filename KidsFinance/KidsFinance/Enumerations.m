//
//  Enumerations.m
//  KidsFinance
//
//  Created by Rafael  Letro on 02/04/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enumerations.h"

@implementation Enumerations

-(NSString *) getDescriptionEnumeration:(long) value
{
    NSLog(@"%lu",value);
    switch (value) {
        case 0:
            return @"Educaçao";
            break;
        case 1:
            return @"Comida";
            break;
        case 2:
            return @"Diversão";
            break;
        case 3:
            return @"Brinquedos";
            break;
        case 4:
            return @"Outros";
            break;
        default:
            return @"none";
            break;
    }
  
  
}

@end