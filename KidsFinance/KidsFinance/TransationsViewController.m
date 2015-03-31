//
//  TransationsViewController.m
//  KidsFinance
//
//  Created by Rafael  Letro on 31/03/15.
//  Copyright (c) 2015 Umbrella. All rights reserved.
//

#import "TransationsViewController.h"

@interface TransationsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *valueField;

@end

@implementation TransationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%lu",self.category);
    NSLog(@"%d",self.isAddMoney);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
