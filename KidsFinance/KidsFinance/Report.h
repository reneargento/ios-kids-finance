//
//  Report.h
//  KidsFinance
//
//  Created by Rafael  Letro on 12/06/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAO.h"
#import "PDFCreator.h"
#import "Utils.h"
#import "Constants.h"


@interface Report : NSObject 


@property (nonatomic,strong) DAO* daoOperation;
@property (nonatomic,strong) NSMutableArray* values;
@property (nonatomic,strong) PDFCreator* pdfDocument;


-(void) generateReport: (NSDate*) dateInit withDateEnd: (NSDate*) dateEnd;
-(void)showPDFFile: (UIView*) view;

-(void) sentEmail:(NSDate*) dateInit andDateEnd:(NSDate *) dateEnd;

@end
