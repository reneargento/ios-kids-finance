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
    [self.view setBackgroundColor: [UIColor colorWithRed:82.0/255.0 green:177.0/255.0 blue:193.0/255.0 alpha:1.0]];
    
    //Set the navigation item title
    self.navigationItem.title = @"Sobre o Aplicativo";
    
    //About text
    NSString* aboutText = @"\nGerencie o dinheiro da sua mesada e aprenda a se planejar para comprar o brinquedo dos seus sonhos!\nCom o dinDin APP você pode controlar o seu cofrinho e anotar seus gastos. Além disso, você pode cadastrar o e-mail dos seus pais para que eles acompanhem e participem da sua educação financeira.";
    [self.aboutLabel setText:aboutText];
    [self.aboutLabel setTextColor:[UIColor colorWithRed:241.0/255.0 green:208.0/255.0 blue:24.0/255.0 alpha:1.0]];
    
    
    //Allow the text to expand
    [self.aboutLabel setNumberOfLines:0];
    [self.aboutLabel sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
