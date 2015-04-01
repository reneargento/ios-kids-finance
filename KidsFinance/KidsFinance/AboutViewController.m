//
//  AboutViewController.m
//  KidsFinance
//
//  Created by Rene Argento on 3/30/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Set the navigation item title
    self.navigationItem.title = @"Sobre o Aplicativo";
    
    //About text
    NSString* aboutText = @"Este app tem o objetivo de...hegherkhkgherhghehrghregjejrkgjerhjghjkerhkjghjehrghjerhjghkjehrkjghkjehrkghejrkhgkherhgjhekjrhgkjherkjghkjehrkjghjerg";
    [self.aboutLabel setText:aboutText];
    
    //Allow the text to expand
    [self.aboutLabel setNumberOfLines:0];
    [self.aboutLabel sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
