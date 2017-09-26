//
//  CancelledViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 18/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "CancelledViewController.h"
#import "UpcomingTableViewCell.h"
#import "SidebarViewController.h"
#import "DetailtripViewController.h"
#import "CancelTripTableViewCell.h"
#import "DejalActivityView.h"
#import "GetUsHere.pch"
#import "SWRevealViewController.h"
#import "SplachscreenViewController.h"

@interface CancelledViewController ()

@end

@implementation CancelledViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    self.navigationItem.title=@"Cancelled Trips";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _smallPrevious.hidden=YES;
    _smallnext.hidden=YES;
    _previous.hidden=YES;
    _next.hidden=YES;
    
    _next.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
     tab.backgroundColor=[UIColor colorWithRed:228.0/255.0f green:224.0/255.0f blue:224.0/255.0f alpha:1.0];
    self.view.backgroundColor=[UIColor colorWithRed:228.0/255.0f green:224.0/255.0f blue:224.0/255.0f alpha:1.0];

    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressedcan:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    arrdetails=[[NSMutableArray alloc]init];
    arrdetails=[[NSUserDefaults standardUserDefaults]objectForKey:@"detailsofall"];
    
    arrpages=[[NSMutableDictionary alloc]init];
    
    arrpages = [[NSUserDefaults standardUserDefaults]objectForKey:@"detailsofall2"];
    
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && ![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
    {
        _next.hidden=NO;
        _smallPrevious.hidden=YES;
        _smallnext.hidden=YES;
        _previous.hidden=YES;
        strpage=[arrpages valueForKey:@"nextPage"];
        _next.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [_next addTarget:self action:@selector(nextClick4cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)barButtonBackPressedcan:(id)sender
{
    SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:side animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

-(void)nextClick4cancel:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"canceled"]];
    [profile appendString:[NSString stringWithFormat:@"&page=%@",strpage]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResp11:data];
                               }
                           }];
    
}

-(void)parseJSONResp11:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
   // NSLog(@"*****Next page details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        arrdetails=[[[responseJSON valueForKey:@"data"] valueForKey:@"tripDetail"]valueForKey:@"trip"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        arrpages=[responseJSON valueForKey:@"data"];
        
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data2 forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        if (![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && ![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=NO;
            _smallPrevious.hidden=NO;
            _previous.hidden=YES;
            
            strpage=[arrpages valueForKey:@"nextPage"];
            strpagepre=[arrpages valueForKey:@"prevPage"];
            
            _smallnext.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            _smallPrevious.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            
            [_smallnext addTarget:self action:@selector(nextClick4cancel:) forControlEvents:UIControlEventTouchUpInside];
            [_smallPrevious addTarget:self action:@selector(nextClick21:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && [[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=NO;
            strpagepre=[arrpages valueForKey:@"prevPage"];
            _previous.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            [_previous addTarget:self action:@selector(nextClick21:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && ![[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=NO;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=YES;
            
            strpage=[arrpages valueForKey:@"nextPage"];
            _next.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
            [_next addTarget:self action:@selector(nextClick4cancel:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"prevPage"]]isEqualToString:@"0"] && [[NSString stringWithFormat:@"%@",[arrpages valueForKey:@"nextPage"]]isEqualToString:@"0"])
        {
            _next.hidden=YES;
            _smallnext.hidden=YES;
            _smallPrevious.hidden=YES;
            _previous.hidden=YES;
        }
        [tab reloadData];
    }
}
-(void)nextClick21:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"canceled"]];
    [profile appendString:[NSString stringWithFormat:@"&page=%@",strpagepre]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResp11:data];
                               }
                           }];
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrdetails.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellClassName = @"CancelTripTableViewCell";
    
    CancelTripTableViewCell *cell = (CancelTripTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
    
    if (cell == nil)
    {
        cell = [[CancelTripTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CancelTripTableViewCell"
                                                     owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.backgroundColor=[UIColor colorWithRed:228.0/255.0f green:224.0/255.0f blue:224.0/255.0f alpha:1.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    UILabel *lbldatew=(UILabel *)[cell viewWithTag:1];
    UILabel *lblinfo=(UILabel *)[cell viewWithTag:2];
    UILabel *lblreason=(UILabel *)[cell viewWithTag:3];
    
    UILabel *lbldate=[[UILabel alloc]init];
    UILabel *lbldateat=[[UILabel alloc]init];
    UILabel *lbltimeabove=[[UILabel alloc]init];
    
    UILabel *labcancel=[[UILabel alloc]init];
    UILabel *labon=[[UILabel alloc]init];
    UILabel *lbldat=[[UILabel alloc]init];
    UILabel *lblat=[[UILabel alloc]init];
    UILabel *lbltim=[[UILabel alloc]init];
    UILabel *lblby=[[UILabel alloc]init];
    UILabel *labrea=[[UILabel alloc]init];
    
    lbldateat.text=@"at";
    
    labcancel.text=@"Cancelled";
    labcancel.textColor=[UIColor colorWithRed:253.0/255.0f green:12.0/255.0f blue:3.0/255.0f alpha:1.0];
    
    labon.text=@"on";
    lblat.text=@"at";
    lblby.text=@"by";
    labon.textColor=[UIColor colorWithRed:132.0/255.0f green:131.0/255.0f blue:131.0/255.0f alpha:1.0];
    lblat.textColor=[UIColor colorWithRed:132.0/255.0f green:131.0/255.0f blue:131.0/255.0f alpha:1.0];
    lblby.textColor=[UIColor colorWithRed:132.0/255.0f green:131.0/255.0f blue:131.0/255.0f alpha:1.0];
    
    lbldat.textColor=[UIColor blackColor];
    lbltim.textColor=[UIColor blackColor];
    labrea.textColor=[UIColor blackColor];
    
    lbldate.text=[[arrdetails valueForKey:@"booking_date"]objectAtIndex:indexPath.row];
    lbltimeabove.text=[[arrdetails valueForKey:@"booking_time"]objectAtIndex:indexPath.row];
    
    lbldat.text=[[arrdetails valueForKey:@"updated_date"]objectAtIndex:indexPath.row];
    lbltim.text=[[arrdetails valueForKey:@"updated_time"]objectAtIndex:indexPath.row];
    labrea.text=[[arrdetails valueForKey:@"canceled_by"]objectAtIndex:indexPath.row];
    
    lblreason.text=[[arrdetails valueForKey:@"canceled_message"]objectAtIndex:indexPath.row];
    lblreason.textColor=[UIColor colorWithRed:120.0/255.0f green:119.0/255.0f blue:119.0/255.0f alpha:1.0];
    
    NSString *strdate=[NSString stringWithFormat:@"%@  %@  %@",lbldate.text,lbldateat.text,lbltimeabove.text];
    lbldatew.text=strdate;
    lbldatew.textColor=[UIColor colorWithRed:132.0/255.0f green:131.0/255.0f blue:131.0/255.0f alpha:1.0];
    
    NSString *strinfoline=[NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@ ",labcancel.text,labon.text,lbldate.text,lblat.text,lbltim.text,lblby.text,labrea.text];
    lblinfo.text=strinfoline;
    
    NSString *strinfoattributrd=[NSString stringWithFormat:@"%@",lblinfo.text];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]  initWithString:strinfoattributrd];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:253.0/255.0f green:12.0/255.0f blue:3.0/255.0f alpha:1.0] range:NSMakeRange(0,9)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:132.0/255.0f green:131.0/255.0f blue:131.0/255.0f alpha:1.0] range:NSMakeRange(10,2)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(13,11)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:132.0/255.0f green:131.0/255.0f blue:131.0/255.0f alpha:1.0] range:NSMakeRange(25,2)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(28,8)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:132.0/255.0f green:131.0/255.0f blue:131.0/255.0f alpha:1.0] range:NSMakeRange(37,2)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(40,6)];
   
   lblinfo.attributedText = attributedString;
 
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidDisappear:(BOOL)animated{
    
    self.title = @"";
    [self.revealViewController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Cancelled Trips";
    
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
    
 //   NSLog(@"***** login check details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    [DejalBezelActivityView removeView];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
