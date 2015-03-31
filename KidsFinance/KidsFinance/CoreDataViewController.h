//
//  CoreDataViewController.h
//  KidsFinance
//
//  Created by Rene Argento on 3/31/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataViewController : UIViewController
{
    IBOutlet UITextField *valueField;
}
-(IBAction)Save;
-(IBAction)Fetch;

@end
