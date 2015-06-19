//
//  Enumerations.m
//  KidsFinance
//
//  Created by Rafael  Letro on 02/04/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryEnumeration.h"

@implementation CategoryEnumeration

-(NSString *) getCategoryEnumeration:(long) value
{
    NSString *category;
    
    switch (value) {
        case 0:
            category = @"Educação";
            break;
        case 1:
            category = @"Comida";
            break;
        case 2:
            category = @"Diversão";
            break;
        case 3:
            category = @"Brinquedos";
            break;
        case 4:
            category = @"Outros";
            break;
        default:
            category = @"none";
            break;
    }
    
    return category;
}

@end