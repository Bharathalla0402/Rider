//
//  Alertview.m
//  GetUsHere For Rider
//
//  Created by bharat on 05/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "Alertview.h"

@interface Alertview ()

@end

@implementation Alertview

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)showalertwithTitle:(NSString *)Title Message:(NSString *)message cancelButton:(NSString *)cancel OkButton:(NSString *)okbutton
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:Title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *button=[UIAlertAction actionWithTitle:okbutton style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:button];
    
    UIViewController *rootviewcontroller = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootviewcontroller presentViewController:alert animated:YES completion:nil];
}

@end
