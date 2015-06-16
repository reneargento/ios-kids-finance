//
//  Report.m
//  KidsFinance
//
//  Created by Rafael  Letro on 12/06/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "Report.h"

#import <UIKit/UIKit.h>

@interface Report ()
@property (nonatomic,strong) NSDate* dateInit;
@property (nonatomic,strong) NSDate* dateEnd;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@end


@implementation Report



-(NSMutableArray*) getDataReport
{
    
    
    NSLog(@"aqui");
    self.daoOperation = [[DAO alloc] init];
    
    return [self.daoOperation getData:self.dateInit withFinalDate:self.dateEnd];
}


-(void) generateReport: (NSDate*) dateInit withDateEnd: (NSDate*) dateEnd
{
    
    self.dateFormatter = [[NSDateFormatter alloc]init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    
    self.dateInit = dateInit;
    self.dateEnd = dateEnd;
    
    self.pdfDocument = [[PDFCreator alloc] init];
    
    [self.pdfDocument setupPDFDocumentNamed:@"Report" Width:850 Height:1100];
    [self.pdfDocument beginPDFPage];
    
    [self reportCreateHeader];
    
   
  
    self.values = [self getDataReport];
    
  
    
    [self createExtract];
    

    
    
    
    [self.pdfDocument finishPDF];
    
}


-(void) reportCreateHeader
{
   
    [self.pdfDocument addText:[self returnTextRange] withFrame:CGRectMake(20, 20, 400, 200) fontSize:12.0f];
    [self.pdfDocument addText:[[NSString alloc] initWithFormat:@"Saldo Atual: %@", [Utils getValueFromKeychain:CURRENT_MONEY_KEY]] withFrame:CGRectMake(20, 40, 400, 200) fontSize:12.0f];
    
}




-(NSString*) returnTextRange
{
    if (self.dateInit != nil && self.dateEnd != nil) {
        return [[NSString alloc] initWithFormat:@"Relatório de transação entre %@ e %@.",self.dateInit,self.dateEnd];
    }else if(self.dateInit != nil){
        return [[NSString alloc] initWithFormat:@"Relatório de transação apartir de %@.",self.dateInit];
    }else if(self.dateEnd != nil){
        return [[NSString alloc] initWithFormat:@"Relatório de transação até %@.",self.dateEnd];
    }else{
        return [[NSString alloc] initWithFormat:@"Relatório completo."];
    }
}


-(void) createExtract
{

    Enumerations * enumerations = [[Enumerations alloc] init];
    NSString * category = @"";
    
    float balance = 0.0;
    float line = 80.0;
    
    
    for (int i = 0; i<self.values.count; i++) {
        category = [enumerations getCategoryEnumeration:[[self.values[i] valueForKey:@"category"] integerValue]];
        if ([category isEqualToString:@"none"]) {
            category = @"";
        }
        
        
        [self.pdfDocument addText:[self.dateFormatter stringFromDate:[self.values[i] valueForKey:@"date"]] withFrame:CGRectMake(50, line, 400, 200) fontSize:12.0f];
        [self.pdfDocument addText:category withFrame:CGRectMake(150, line, 400, 200) fontSize:12.0f];
        [self.pdfDocument addText:[NSString stringWithFormat:@" %@",[self.values[i] valueForKey:@"value"]] withFrame:CGRectMake(300, line, 400, 200) fontSize:12.0f];
        NSLog(@"%@",[self.values[i] valueForKey:@"isEarning"]);
        
        if ([[self.values[i] valueForKey:@"isEarning"] integerValue]) {
            balance += [[self.values[i] valueForKey:@"value"] floatValue];
        }else{
            balance -= [[self.values[i] valueForKey:@"value"] floatValue];
        }
        
        line += 20.0;
    }
    
    [self.pdfDocument addText:@"Saldo" withFrame:CGRectMake(50, line, 400, 200) fontSize:12.0f];
    [self.pdfDocument addText:[NSString stringWithFormat:@" %f",balance] withFrame:CGRectMake(300, line, 400, 200) fontSize:12.0f];
   
    
}



-(void)showPDFFile: (UIView*) view
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:@"Report.PDF"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:pdfPath]) {
        
        UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        NSURL *urlen = [NSURL fileURLWithPath:pdfPath];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlen];
        
        [webView loadRequest:urlRequest];
        [webView setScalesPageToFit:YES];
        [view addSubview:webView];
    } else {
        NSLog(@"qwoijqiwodjqijwdq");
    }
    
}


@end
