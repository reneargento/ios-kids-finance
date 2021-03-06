//
//  Report.m
//  KidsFinance
//
//  Created by Rafael  Letro on 12/06/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "Report.h"

#import <UIKit/UIKit.h>
#import <MailCore/MailCore.h>


@interface Report ()
@property (nonatomic,strong) NSDate* dateInit;
@property (nonatomic,strong) NSDate* dateEnd;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@end


@implementation Report



-(NSMutableArray*) getDataReport
{
    
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

   
    [self.pdfDocument addText:[self returnTextRange] withFrame:CGRectMake(20, 20, 600, 400) fontSize:12.0f];
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

    CategoryEnumeration * enumerations = [[CategoryEnumeration alloc] init];
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
    }
    
}




-(void) sentEmail:(NSDate*) dateInit andDateEnd:(NSDate *) dateEnd
{
    NSString * userName = @"r.letro@hotmail.com";
    NSString * toAdress = [Utils getValueFromKeychain:EMAIL_REPORT];
    
    NSString * subject = @"Relatório Din Din";
    
    Report * report = [[Report alloc] init];
    
    [report generateReport:dateInit withDateEnd:dateEnd];
    MCOSMTPSession *smtpSession = [[MCOSMTPSession alloc] init];
//    smtpSession.checkCertificateEnabled = NO;
    smtpSession.hostname = @"smtp-mail.outlook.com";
    smtpSession.port = 587;
    smtpSession.username = userName;
    smtpSession.password = @"rafsla_2011";
    smtpSession.connectionType = MCOConnectionTypeStartTLS;
    
    
    
    MCOMessageBuilder * builder = [[MCOMessageBuilder alloc] init];
    [[builder header] setFrom:[MCOAddress addressWithDisplayName:nil mailbox:userName]];
    NSMutableArray *to = [[NSMutableArray alloc] init];
    
    MCOAddress *newAddress = [MCOAddress addressWithMailbox:toAdress];
    [to addObject:newAddress];
    [[builder header] setTo:to];
    
    
     NSString * path = [Utils retrunPathReport];
    
    
    [[builder header] setSubject:subject];
    [builder setHTMLBody: [[NSString alloc] initWithFormat:@"<h3> Relatório DinDin </h3> <p>Segue anexo o relatório referente ao período configurado.</br> A equipe do DinDin Agradece.  </p>"]];
    MCOAttachment *attachment = [MCOAttachment attachmentWithContentsOfFile:path];
    [builder addAttachment:attachment];
    NSData * rfc822Data = [builder data];

    
    
    MCOSMTPSendOperation *sendOperation = [smtpSession sendOperationWithData:rfc822Data];
    [sendOperation start:^(NSError *error) {
        if(error) {
            NSLog(@"%@ Error sending email:%@", userName, error);
        } else {
            NSLog(@"%@ Successfully sent email!", userName);
        }
    }];
    
    
}




@end
