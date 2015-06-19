//
//  ReportViewController.m
//  KidsFinance
//
//  Created by Rene Argento on 3/30/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "ReportViewController.h"
#import "Report.h"
#import "PDFCreator.h"
#import "Utils.h"
#import "FrequencyEnumeration.h"

@interface ReportViewController ()
@property long selectedRow;
@property NSMutableArray* frequencyPickerValues;
@end

@implementation ReportViewController


    


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
    self.frequencyPickerValues = [[NSMutableArray alloc]init];
    
    
    
    [self.frequencyPickerValues addObject:[FrequencyEnumeration getFrequencyEnumerationString:0]];
    [self.frequencyPickerValues addObject:[FrequencyEnumeration getFrequencyEnumerationString:1]];
    [self.frequencyPickerValues addObject:[FrequencyEnumeration getFrequencyEnumerationString:2]];
}

#pragma mark - data source

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.frequencyPickerValues count];
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    self.selectedRow = row;
    
    return [self.frequencyPickerValues objectAtIndex:row];
}

- (IBAction)reportButton:(id)sender {

    UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    
    long day = 24*3600;
    
    long frequencyType = [FrequencyEnumeration getFrequencyEnumerationLong:self.frequencyPickerValues[self.selectedRow]] ;
    long interval;
    
    NSDate* sourceDate = [NSDate date];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    
    NSTimeInterval intHor = destinationGMTOffset - sourceGMTOffset + interval;
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    
    switch (frequencyType) {
        case FrequencyDaily:
            localNotif.repeatInterval = NSCalendarUnitDay;
            interval = day / 24 / 60;
            break;
        case FrequencyWeekly:
            localNotif.repeatInterval = NSCalendarUnitWeekOfMonth;
            interval = day * 7;
            break;
        case FrequencyMonthly:
            localNotif.repeatInterval = NSCalendarUnitMonth;
            interval = day * 30;
            break;
        default:
            break;
    }
    
    localNotif.alertBody = @"Email Enviado com sucesso";
    localNotif.alertAction = @"open";
    localNotif.fireDate =[NSDate dateWithTimeIntervalSinceNow: intHor];
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.category = @"REPORT_CATEGORY";
    
    
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    //[report showPDFFile:self.view];
    

}


-(void)showPDFFile
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:@"Report.PDF"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:pdfPath]) {
        
        UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        NSURL *urlen = [NSURL fileURLWithPath:pdfPath];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlen];
        NSLog(@"%@",pdfPath);
        [webView loadRequest:urlRequest];
        [webView setScalesPageToFit:YES];
        [self.view addSubview:webView];
    } else {
        NSLog(@"qwoijqiwodjqijwdq");
    }
    
}





@end
