//
//  TermsofuseViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 07/04/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "TermsofuseViewController.h"

@interface TermsofuseViewController ()

@end

@implementation TermsofuseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Term of Services";
   
    
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:10.0],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = size;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    

    
    NSString *str=@"Thank you for signing up for a subscription with Optimizely, Inc. (“Optimizely”, “we” or “us”). By placing an order, clicking to accept this Agreement, or using or accessing any Optimizely Service or related services, you agree to all the terms and conditions of this Terms of Service Agreement (“Agreement”). If you are using an Optimizely Service or related services on behalf of a company or other entity, then “Customer” or “you” means that entity, and you are binding that entity to this Agreement. You represent and warrant that you have the legal power and authority to enter into this Agreement and that, if the Customer is an entity, this Agreement and each Order Form is entered into by an employee or agent with all necessary authority to bind that entity to this Agreement. Please note that we may modify this Agreement as further described in the amendments section below, so you should make sure to check this page from time to time. This Agreement includes any Order Forms and Service-Specific Terms";
    
    _txtterm.text=str;
    
    
    
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
