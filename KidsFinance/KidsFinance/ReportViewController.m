//
//  ReportViewController.m
//  KidsFinance
//
//  Created by Rene Argento on 3/30/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "ReportViewController.h"

@interface ReportViewController ()

@end

@implementation ReportViewController
{
    NSMutableArray* frequencyPickerValues;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Relatório";
    [self.view setBackgroundColor: [UIColor colorWithRed:82.0/255.0 green:177.0/255.0 blue:193.0/255.0 alpha:1.0]];
    //[self.navigationItem setTextColor:[UIColor colorWithRed:241.0/255.0 green:208.0/255.0 blue:24.0/255.0 alpha:1.0]];
    
    // Sets the values for the picker
    [self startFrequencyPickerValues];
    
    self.frequencyPicker.dataSource = self;
    self.frequencyPicker.delegate = self;
    
    [self.view setBackgroundColor: [UIColor colorWithRed:82.0/255.0 green:177.0/255.0 blue:193.0/255.0 alpha:1.0]];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///Sets the value of the frequency pickers
- (void) startFrequencyPickerValues {
    frequencyPickerValues = [[NSMutableArray alloc]init];
    
    for (int i = 7; i <= 60; i++) {
        [frequencyPickerValues addObject:[NSString stringWithFormat:@"%d", i]];
    }
}

#pragma mark - data source

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [frequencyPickerValues count];
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    //self.selectedRow = row;
    
    return [frequencyPickerValues objectAtIndex:row];
}

- (IBAction)reportButton:(id)sender {
  
}

@end
