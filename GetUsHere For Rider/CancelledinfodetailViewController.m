//
//  CancelledinfodetailViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 21/06/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "CancelledinfodetailViewController.h"
#import "SidebarViewController.h"
#import "SplachscreenViewController.h"
#import "GetUsHere.pch"

@interface CancelledinfodetailViewController ()

@end

@implementation CancelledinfodetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title=@"Cancelled Ride";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"itemType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _txtname.text=_strname;
    _pickuplab.text=_strpickup;
    _deslab.text=_strDestination;
    _bookingtime.text=[NSString stringWithFormat:@"%@ %@",_strdate,_strtime];
    _bookingstatus.text=_strstatus;
    _resaon.text=_strreason;
    
    NSString *strurl=_strimageurl;

    TPFloatRatingView *ratingview=(TPFloatRatingView *)[self.view viewWithTag:2];
    
    _detailview.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    ratingview.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    NSString *str1=[NSString stringWithFormat:@"%@",_strratingnumber];
    float value = [str1 floatValue];
    
    ratingview.emptySelectedImage = [UIImage imageNamed:@"StarEmpty"];
    ratingview.fullSelectedImage = [UIImage imageNamed:@"StarFull"];
    ratingview.contentMode = UIViewContentModeScaleAspectFill;
    ratingview.editable = NO;
    ratingview.halfRatings = YES;
    ratingview.floatRatings = YES;
    ratingview.rating=value;
    
    if (![strurl isEqualToString:@""])
    {
        NSString *strurl=[NSString stringWithFormat:@"%@",_strimageurl];
        NSURL *imageURL = [NSURL URLWithString:strurl];
        NSData *data = [NSData dataWithContentsOfURL : imageURL];
        UIImage *image = [UIImage imageWithData: data];
        _driverprofileimage.image=image;
    }
    

    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;

}


-(void)barButtonBackPressed:(id)sender
{
    SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:side animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
   // self.title = @"";
   // [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title=@"Cancelled Ride";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,logincheck]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&device_id=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRdevicecheck:data];
                               }
                           }];
    
    
    
}


-(void)parseJSONRdevicecheck:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"***** login check details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
   
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        //
        //        [alert show];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Login"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
        
        SplachscreenViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"SplachscreenViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        
    }
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
