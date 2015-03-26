//
//  ViewController.m
//  KidsFinance
//
//  Created by Rene Argento on 3/25/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addAddMoneyImageView];
    [self addSubtractMoneyImageView];
    [self addConfigurationsImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addMoneyButton:(id)sender {
}

- (IBAction)subtractMoneyButton:(id)sender {
}

- (IBAction)configurationsButton:(id)sender {
}

- (void) addAddMoneyImageView {
    [self.addMoneyButton setImage:[UIImage imageNamed:@"add.png"]];
    [self.addMoneyButton setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapping:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.addMoneyButton addGestureRecognizer:singleTap];
    [self.view addSubview:self.addMoneyButton];
}

- (void) addSubtractMoneyImageView {
    [self.substractMoneyButton setImage:[UIImage imageNamed:@"subtract"]];
    [self.substractMoneyButton setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapping:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.substractMoneyButton addGestureRecognizer:singleTap];
    [self.view addSubview:self.addMoneyButton];
}

- (void) addConfigurationsImageView {
    [self.configurationsButton setImage:[UIImage imageNamed:@"configurations.png"]];
    [self.configurationsButton setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapping:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.configurationsButton addGestureRecognizer:singleTap];
    [self.view addSubview:self.configurationsButton];
}
@end
