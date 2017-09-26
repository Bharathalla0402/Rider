//
//  UpcomingCancelViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 21/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "UpcomingCancelViewController.h"
#import "UpcomingRidesViewController.h"
#import "Alertview.h"
#import "DejalActivityView.h"
#import "SidebarViewController.h"
#import "GetUsHere.pch"

@interface UpcomingCancelViewController ()

@end

@implementation UpcomingCancelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // lblname.text.length=0;
    
    self.navigationItem.title=@"Cancel Ride";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _doneClick.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    _backClick.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];

    
    [_btn1 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
    [_btn2 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
    [_btn3 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
    [_btn4 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
    
}
- (IBAction)btnclicked:(UIButton*)sender
{
    if (sender.tag==1)
    {
        [_btn1 setImage:[UIImage imageNamed:@"radio button selected_20-20.png"] forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn3 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn4 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        
        str=@"Driver is Late";
    }
    else if (sender.tag==2)
    {
        [_btn1 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"radio button selected_20-20.png"] forState:UIControlStateNormal];
        [_btn3 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn4 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        str=@"Booked another car";
        
    }
    else if (sender.tag==3)
    {
        [_btn1 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn3 setImage:[UIImage imageNamed:@"radio button selected_20-20.png"] forState:UIControlStateNormal];
        [_btn4 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        
        str=@"Changed my mind";
    }
    else if (sender.tag==4)
    {
        [_btn1 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn3 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn4 setImage:[UIImage imageNamed:@"radio button selected_20-20.png"] forState:UIControlStateNormal];
        
        str=@"Driver denied duty";
    }

}
- (IBAction)DoneClicked:(id)sender
{
    
    if (str.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please select proper reason to cancel the ride" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self next];
    }
    
}


-(void)next
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,cancelTrip]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&trip_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"tripid"]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
    [profile appendString:[NSString stringWithFormat:@"&canceled_message=%@",str]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResponse:data];
                               }
                           }];
}

-(void)parseJSONResponse:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"*****Cancel details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:@"You has been successfully cancelled the Ride" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        UpcomingRidesViewController *rides=[self.storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        [self.navigationController pushViewController:rides animated:YES];

    }
}


- (IBAction)CancelClicked:(id)sender
{
    UpcomingRidesViewController *rides=[self.storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
    [self.navigationController pushViewController:rides animated:YES];
}


-(void)viewDidDisappear:(BOOL)animated{
    
    self.title = @"";
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Cancel Ride";
    
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
