//
//  Report.h
//  KidsFinance
//
//  Created by Rafael  Letro on 11/06/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface PDFCreator : NSObject
@property (nonatomic,strong) NSString* fileName;


- (void)setupPDFDocumentNamed:(NSString*)name Width:(float)width Height:(float)height;
- (void)beginPDFPage;
- (void)finishPDF;
- (CGRect)addText:(NSString*)text withFrame:(CGRect)frame fontSize:(float)fontSize;
- (CGRect)addLineWithFrame:(CGRect)frame withColor:(UIColor*)color;
- (CGRect)addImage:(UIImage*)image atPoint:(CGPoint)point;
- (void)drawTableAt:(CGPoint)origin
      withRowHeight:(int)rowHeight
     andColumnWidth:(int)columnWidth
        andRowCount:(int)numberOfRows
     andColumnCount:(int)numberOfColumns;
@end
