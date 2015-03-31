//
//  DatabaseController.m
//  KidsFinance
//
//  Created by Rene Argento on 3/31/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Enumerations.h"
#import "Transactions.h"
#import "DAO.h"

@interface DAO ()

@end

@implementation DAO

//- (void)saveData:(float)value withDate:(NSDate*)date withCategory:(long)category withEarning:(BOOL)earning{
- (void)saveTransaction:(Transactions*) transaction{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //Entity for table Transactions
    NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Transactions" inManagedObjectContext:appDelegate.managedObjectContext];
    //Set values to be stored in the database
    [entity setValue:transaction.value forKey:@"value"];
    [entity setValue:transaction.date forKey:@"date"];
    [entity setValue:[NSNumber numberWithLong:transaction.category] forKey:@"category"];
    [entity setValue:[NSNumber numberWithBool:transaction.isEarning] forKey:@"isEarning"];
    
    NSError *error;
    //Returns true if the data was stored succesfully in the database
    BOOL isSaved = [appDelegate.managedObjectContext save:&error];
    NSLog(@"Values stored succesfully in the database: %d", isSaved);
}

- (NSMutableArray*)getData {
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //Creating entity object for table Transactions
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Transactions" inManagedObjectContext:appDelegate.managedObjectContext];
    
    //Create fetch request
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    //Get all rows
    NSMutableArray * values = [[appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    //Core data returns each row as managed objects so we can access rows values through key-value pair
    for(NSManagedObject *row in values) {
        NSLog(@"Value: %@\n Category: %@\n", [row valueForKey:@"value"], [row valueForKey:@"category"]);
    }
    
    return values;
}

@end