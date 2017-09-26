//
//  AvailableCabsViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 23/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "AvailableCabsViewController.h"
#import "CarDriverTableViewCell.h"
#import "DejalActivityView.h"
#import "DriverDetailsViewController.h"
#import "GetUsHere.pch"
#import "SWRevealViewController.h"
#import "SplachscreenViewController.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"

@interface AvailableCabsViewController ()
{
    CarDriverTableViewCell *cell;
    CarDriverTableViewCell *Celll;
    
    NSMutableArray *arrchecks;
}

@end

@implementation AvailableCabsViewController
@synthesize TitleString;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrnames=[[NSMutableArray alloc]init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"cardet"];
    
    arrnames = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    strid=[arrnames valueForKey:@"driver_id"];
    
    arrdriverdetails=[[NSMutableArray alloc]init];
    arrdriverinfo=[[NSMutableArray alloc]init];
    arrtripinfo=[[NSMutableArray alloc]init];
    arrchecks=[[NSMutableArray alloc]init];
    
    NSLog(@" arr names  :%@",arrnames);
    countlabel=0;
    
    _tabl.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
 //   _tabl.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.title=[NSString stringWithFormat:@"Available %@ Cars",TitleString];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _topView.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    _pickuplab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _deslab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _pickupline.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _deslinelab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
   
    
    strpic=[[NSUserDefaults standardUserDefaults]objectForKey:@"pic"];
    strdes=[[NSUserDefaults standardUserDefaults]objectForKey:@"des"];
    strfareest=[[NSUserDefaults standardUserDefaults]objectForKey:@"farevalue"];
    strcartype=[[NSUserDefaults standardUserDefaults] objectForKey:@"idd"];
    
    _farelabel.text=[NSString stringWithFormat:@"%@",strfareest];
    _pickuplabel.text=[NSString stringWithFormat:@"%@",strpic];
    _deslabel.text=[NSString stringWithFormat:@"%@",strdes];
    
    self.view.userInteractionEnabled=NO;
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];

    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    str=[[NSUserDefaults standardUserDefaults] objectForKey:@"tripstatuscheck"];
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    [self performSelector:@selector(AcceptedResponse7:) withObject:self afterDelay:0.1];
}

-(void)AcceptedResponse7:(id)sender
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,riderBookingCheck]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"rider_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    
    [profile appendString:[NSString stringWithFormat:@"&trip_id=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"tripstatuscheck"]]];
    
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResponres:data];
                                   
                               }
                           }];
}

-(void)parseJSONResponres:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"*****old Driver Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
  //  NSString *statuspending=[responseJSON valueForKey:@"message"];
    NSString *statusCode=[responseJSON valueForKey:@"code"];
    
    // NSLog(@"%@",DataArray);
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        //
        //        [alert show];
        
    //    [Celll.bookbtn setTitle:@"Book Now" forState:UIControlStateNormal];
        
        self.view.userInteractionEnabled=YES;
        
        
             [DejalBezelActivityView removeView];
        
        if (countlabel==0)
        {
            [self performSelector:@selector(AcceptedResponse7:) withObject:self afterDelay:2.0];
        }
        else
        {
            return;
        }
        
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"pending"])
        {
            Celll.bookbtn.enabled=NO;
            cell.userInteractionEnabled=NO;
              Celll.userInteractionEnabled=NO;
              bookbtn.userInteractionEnabled = NO;
             self.view.userInteractionEnabled=NO;
            if (countlabel==0)
            {
                [self performSelector:@selector(AcceptedResponse7:) withObject:self afterDelay:2.0];
            }
            else
            {
                return;
            }
        }
        else if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"Booking Successful"])
        {
           // [Celll.bookbtn setTitle:[responseJSON valueForKey:@"code"] forState:UIControlStateNormal];
            
          //  Celll.bookbtn.enabled=NO;
             cell.userInteractionEnabled=NO;
              Celll.userInteractionEnabled=NO;
              bookbtn.userInteractionEnabled = NO;
             self.view.userInteractionEnabled=NO;
            if (countlabel==0)
            {
                [self performSelector:@selector(AcceptedResponse7:) withObject:self afterDelay:2.0];
            }
            else
            {
                return;
            }
        }
        else if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"rejected"])
        {
          //  [Celll.bookbtn setTitle:[responseJSON valueForKey:@"code"] forState:UIControlStateNormal];
        
            cell.userInteractionEnabled=YES;
            Celll.userInteractionEnabled=YES;
            bookbtn.userInteractionEnabled = YES;
             self.view.userInteractionEnabled=YES;
            if (countlabel==0)
            {
                [self performSelector:@selector(AcceptedResponse7:) withObject:self afterDelay:2.0];
            }
            else
            {
                return;
            }
        }
        else if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"pending"])
        {
            //  [Celll.bookbtn setTitle:[responseJSON valueForKey:@"code"] forState:UIControlStateNormal];
            
            cell.userInteractionEnabled=NO;
            Celll.userInteractionEnabled=NO;
            bookbtn.userInteractionEnabled = NO;
            self.view.userInteractionEnabled=NO;
            if (countlabel==0)
            {
                [self performSelector:@selector(AcceptedResponse7:) withObject:self afterDelay:2.0];
            }
            else
            {
                return;
            }
        }
        else if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"canceled"])
        {
            //  [Celll.bookbtn setTitle:[responseJSON valueForKey:@"code"] forState:UIControlStateNormal];
            
            cell.userInteractionEnabled=YES;
            Celll.userInteractionEnabled=YES;
            bookbtn.userInteractionEnabled = YES;
            self.view.userInteractionEnabled=YES;
            if (countlabel==0)
            {
                [self performSelector:@selector(AcceptedResponse7:) withObject:self afterDelay:2.0];
            }
            else
            {
                return;
            }
        }
        else if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"completed"])
        {
            //  [Celll.bookbtn setTitle:[responseJSON valueForKey:@"code"] forState:UIControlStateNormal];
            
            cell.userInteractionEnabled=YES;
            Celll.userInteractionEnabled=YES;
            bookbtn.userInteractionEnabled = YES;
            self.view.userInteractionEnabled=YES;
            [self performSelector:@selector(AcceptedResponse7:) withObject:self afterDelay:0.1];
        }
        else if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"arrived"])
        {
            //  [Celll.bookbtn setTitle:[responseJSON valueForKey:@"code"] forState:UIControlStateNormal];
            
            cell.userInteractionEnabled=NO;
            Celll.userInteractionEnabled=NO;
            bookbtn.userInteractionEnabled = NO;
            self.view.userInteractionEnabled=NO;
            if (countlabel==0)
            {
                [self performSelector:@selector(AcceptedResponse7:) withObject:self afterDelay:2.0];
            }
            else
            {
                return;
            }
        }
        else if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"started"])
        {
            //  [Celll.bookbtn setTitle:[responseJSON valueForKey:@"code"] forState:UIControlStateNormal];
            
            cell.userInteractionEnabled=NO;
            Celll.userInteractionEnabled=NO;
            bookbtn.userInteractionEnabled = NO;
            self.view.userInteractionEnabled=NO;
            if (countlabel==0)
            {
                [self performSelector:@selector(AcceptedResponse7:) withObject:self afterDelay:2.0];
            }
            else
            {
                return;
            }        }
        else if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"stopped"])
        {
            //  [Celll.bookbtn setTitle:[responseJSON valueForKey:@"code"] forState:UIControlStateNormal];
            
            cell.userInteractionEnabled=NO;
            Celll.userInteractionEnabled=NO;
            bookbtn.userInteractionEnabled = NO;
            self.view.userInteractionEnabled=NO;
            if (countlabel==0)
            {
                [self performSelector:@selector(AcceptedResponse7:) withObject:self afterDelay:2.0];
            }
            else
            {
                return;
            }
        }
        else if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"accepted"])
        {
            //  [Celll.bookbtn setTitle:[responseJSON valueForKey:@"code"] forState:UIControlStateNormal];
            
            cell.userInteractionEnabled=NO;
            Celll.userInteractionEnabled=NO;
            bookbtn.userInteractionEnabled = NO;
            self.view.userInteractionEnabled=NO;
            if (countlabel==0)
            {
                [self performSelector:@selector(AcceptedResponse7:) withObject:self afterDelay:2.0];
            }
            else
            {
                return;
            }        }

        else if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"Rider_Paid"])
        {
            //  [Celll.bookbtn setTitle:[responseJSON valueForKey:@"code"] forState:UIControlStateNormal];
            
            cell.userInteractionEnabled=NO;
            Celll.userInteractionEnabled=NO;
            bookbtn.userInteractionEnabled = NO;
            self.view.userInteractionEnabled=NO;
            if (countlabel==0)
            {
                [self performSelector:@selector(AcceptedResponse7:) withObject:self afterDelay:2.0];
            }
            else
            {
                return;
            }
        }

        else
        {
            cell.userInteractionEnabled=NO;
            Celll.userInteractionEnabled=NO;
            bookbtn.userInteractionEnabled = NO;
            self.view.userInteractionEnabled=NO;
            if (countlabel==0)
            {
                [self performSelector:@selector(AcceptedResponse7:) withObject:self afterDelay:2.0];
            }
            else
            {
                return;
            }
        }
        
            [DejalBezelActivityView removeView];
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//   
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrnames.count;
    
}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//   // return [(@"Available %@ cabs",[arrnames objectAtIndex:0])];
//    
//    return nil;
//
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellClassName = @"CarDriverTableViewCell";
    
   cell = (CarDriverTableViewCell *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
    
    if (cell == nil)
    {
        cell = [[CarDriverTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CarDriverTableViewCell"
                                                     owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.backgroundColor=[UIColor blackColor];
        
    }
    
    UILabel *lbltime1=(UILabel *)[cell viewWithTag:1];
    UILabel *lbldriver=(UILabel *)[cell viewWithTag:2];
    UILabel *lbllicence=(UILabel *)[cell viewWithTag:4];
    UILabel *lbltime=(UILabel *)[cell viewWithTag:8];
    UILabel *lbllanguages=(UILabel *)[cell viewWithTag:11];
    
    UIImageView *imaged=(UIImageView *)[cell viewWithTag:9];
    
    imaged.layer.cornerRadius = imaged.frame.size.height /2;
    imaged.layer.masksToBounds = YES;
    imaged.layer.borderWidth = 0;
    
    NSString *strurl=[NSString stringWithFormat:@"%@",[[arrnames valueForKey:@"image"]objectAtIndex:indexPath.row]];
//    
//    NSURL *imageURL = [NSURL URLWithString:strurl];
//    
//    NSData *data = [NSData dataWithContentsOfURL : imageURL];
//    
//    UIImage *image = [UIImage imageWithData: data];
//    
//    imaged.image=image;
    
//    UIImage *imag=[UIImage imageNamed:@"profilepic.png"];
//    imaged.image=imag;
    
    [imaged sd_setImageWithURL:[NSURL URLWithString:strurl]
                           placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
    
    bookbtn=(UIButton *)[cell viewWithTag:5];
    
    bookbtn.tag=indexPath.row;
    [bookbtn addTarget:self action:@selector(btnclicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    lbltime.text=[NSString stringWithFormat:@"Estimated time to reach You: %@",[[arrnames valueForKey:@"time"]objectAtIndex:indexPath.row]];
    lbltime.textColor=[UIColor purpleColor];
    
    lbltime1.hidden=YES;
    
  //  lbltime1.text=[[arrnames valueForKey:@"time"]objectAtIndex:indexPath.row];
    lbldriver.text=[[arrnames valueForKey:@"name"]objectAtIndex:indexPath.row];
    lbllicence.text=[[arrnames valueForKey:@"license_plate"]objectAtIndex:indexPath.row];
    
    
    NSMutableArray *arrlanguages=[[NSMutableArray alloc] init];
    
    arrlanguages=[[arrnames valueForKey:@"lang"] objectAtIndex:indexPath.row];
    
    NSMutableArray *arrids=[[NSMutableArray alloc]init];
    
    for (int i=0; i<arrlanguages.count; i++)
    {
        NSString *strpresent=[NSString stringWithFormat:@"%@",[[arrlanguages objectAtIndex:i] valueForKey:@"present"]];
        
        if ([strpresent isEqualToString:@"1"])
        {
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            [arr addObject:[[arrlanguages objectAtIndex:i]valueForKey:@"name"]];
            arrids=[[arrids arrayByAddingObjectsFromArray:arr] mutableCopy];
        }
    }
    NSLog(@"%@",arrids);
    NSString *result = [arrids  componentsJoinedByString:@", "];
    NSLog(@"%@",result);
    lbllanguages.text=result;
    
    
    
    bookbtn.titleLabel.text=[[arrnames valueForKey:@"driver_id"]objectAtIndex:indexPath.row];
    
    if ([bookbtn.titleLabel.text isEqualToString:@"Accept"])
    {
        bookbtn.userInteractionEnabled = YES;
    }
   
    
    
    return cell;
    
}

-(void)btnclicked:(UIButton *)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                           toView:self.tabl];
    NSIndexPath *tappedIP = [self.tabl indexPathForRowAtPoint:buttonPosition];
    
    Celll = [self.tabl cellForRowAtIndexPath: tappedIP];
    [Celll.bookbtn setTitle:@"Pending" forState:UIControlStateNormal];
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    NSString *driverID= [[arrnames objectAtIndex:sender.tag] valueForKey:@"driver_id"];
        
    [self nextwithDriverid:driverID];
    cell.userInteractionEnabled=NO;
    Celll.userInteractionEnabled=NO;
    bookbtn.userInteractionEnabled = NO;
    self.view.userInteractionEnabled=NO;
    }
}




-(void)nextwithDriverid:(NSString *)dId
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,bookNow]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"rider_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&driver_id=%@",dId]];
    [profile appendString:[NSString stringWithFormat:@"&car_type=%@",strcartype]];
    [profile appendString:[NSString stringWithFormat:@"&src_lat=%f",[[NSUserDefaults standardUserDefaults]floatForKey:@"lati"]]];
    [profile appendString:[NSString stringWithFormat:@"&src_lng=%f",[[NSUserDefaults standardUserDefaults]floatForKey:@"longi"]]];
    [profile appendString:[NSString stringWithFormat:@"&dest_lat=%f",[[NSUserDefaults standardUserDefaults]floatForKey:@"lati1"]]];
    [profile appendString:[NSString stringWithFormat:@"&dest_lng=%f",[[NSUserDefaults standardUserDefaults]floatForKey:@"longi1"]]];
    
    [profile appendString:[NSString stringWithFormat:@"&src_addr=%@",strpic]];
    [profile appendString:[NSString stringWithFormat:@"&dest_addr=%@",strdes]];
    
    [profile appendString:[NSString stringWithFormat:@"&rider_device_id=%@", [[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]]];
    
  //  [profile appendString:[NSString stringWithFormat:@"&rider_device_id=%@", @"8d7fe17621d143ef19fd6ffcb12e12ce511f27fe45e0a6e180a028cba2f95746"]];

    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRespons:data];
                               }
                           }];
}

-(void)parseJSONRespons:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    NSLog(@"*****Book Now Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
   
    
    // NSLog(@"%@",DataArray);
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        [DejalBezelActivityView removeView];
        
        [Celll.bookbtn setTitle:@"No Response" forState:UIControlStateNormal];
        
        Celll.bookbtn.enabled=NO;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        
        cell.userInteractionEnabled=NO;
         Celll.userInteractionEnabled=NO;
         bookbtn.userInteractionEnabled = NO;
         self.view.userInteractionEnabled=NO;
        
        arrdriverdetails=[[responseJSON valueForKey:@"data"]valueForKey:@"driver"];
        strtripid=[[[responseJSON valueForKey:@"data"]valueForKey:@"trip"]valueForKey:@"id"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrdriverdetails forKey:@"Driverdetails"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:strtripid forKey:@"tripid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:strtripid forKey:@"tripstatuscheck"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSLog(@"%@",arrdriverdetails);
        NSLog(@"%@",strtripid);

        //bookbtn.titleLabel.text=[responseJSON valueForKey:@"code"];
        [self performSelector:@selector(AcceptedResponse1:) withObject:self afterDelay:2.0];
    }
}


//-(void)estimatedtime
//{
//    UIButton *title=[[UIButton alloc] init];
//    title.titleLabel.text=@"Pending";
//    NSString* str2 = [title titleForState:UIControlStateNormal];
//    NSString* str1 = [Celll.bookbtn titleForState:UIControlStateNormal];
//    
//    if (![str1 isEqualToString:str2])
//    {
//        statements
//    }
//    
//    
//
//}

-(void)AcceptedResponse1:(id)sender
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,riderBookingCheck]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"rider_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    
    [profile appendString:[NSString stringWithFormat:@"&trip_id=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"tripid"]]];
    
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRespon:data];
                                   
                               }
                           }];
}



-(void)parseJSONRespon:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"***** Driver Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    NSString *statuspending=[responseJSON valueForKey:@"message"];
    NSString *statusCode=[responseJSON valueForKey:@"code"];
    
    // NSLog(@"%@",DataArray);
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        
//        [alert show];
        
      //   [Celll.bookbtn setTitle:@"Book Now" forState:UIControlStateNormal];
        [self performSelector:@selector(AcceptedResponse1:) withObject:self afterDelay:4.0];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        
        if ([[NSString stringWithFormat:@"%@",statuspending] isEqualToString:@"Booking is pending yet"])
        {
            Celll.bookbtn.enabled=NO;
             cell.userInteractionEnabled=NO;
             Celll.userInteractionEnabled=NO;
             bookbtn.userInteractionEnabled = NO;
             self.view.userInteractionEnabled=NO;
            [self performSelector:@selector(AcceptedResponse1:) withObject:self afterDelay:4.0];
        }
       else if ([[NSString stringWithFormat:@"%@",statuspending] isEqualToString:@"Booking Successful"])
        {
            [Celll.bookbtn setTitle:[responseJSON valueForKey:@"code"] forState:UIControlStateNormal];
            
             Celll.bookbtn.enabled=NO;
             Celll.userInteractionEnabled=NO;
             bookbtn.userInteractionEnabled = NO;
             self.view.userInteractionEnabled=NO;
        }
       else if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"rejected"])
       {
           [Celll.bookbtn setTitle:[responseJSON valueForKey:@"code"] forState:UIControlStateNormal];
           [self performSelector:@selector(AcceptedResponse1:) withObject:self afterDelay:4.0];
           
           Celll.bookbtn.enabled=NO;
           cell.userInteractionEnabled=YES;
            Celll.userInteractionEnabled=YES;
            bookbtn.userInteractionEnabled = YES;
            self.view.userInteractionEnabled=YES;
           
//           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:@"Selected Driver rejected your Request.Please select another Driver" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//           
//           [alert show];
           
        }
        
      //  [bookbtn setTitle:[responseJSON valueForKey:@"code"] forState:UIControlStateNormal];
      //  [_tabl reloadData];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    countlabel=1;
    self.title = @"";
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(AcceptedResponse7:) object:nil];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = [NSString stringWithFormat:@"Available %@ Cars",TitleString];
    
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
        
   //     NSLog(@"***** login check details ******* %@", responseJSON);
        
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
    [self.revealViewController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

#pragma mark -- checkNetworkStatus
-(void)checkNetworkStatus{
    Reachability* internetAvailable = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [internetAvailable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:{
            NSLog(@"The internet is down.");
            _isInternetConnectionAvailable = NO;
            break;
        }
        case ReachableViaWiFi:{
            _isInternetConnectionAvailable = YES;
            NSLog(@"The internet is working via WIFI.");
            break;
        }
        case ReachableViaWWAN:{
            _isInternetConnectionAvailable = YES;
            NSLog(@"The internet is working via WWAN.");
            break;
        }
    }
}
#pragma mark -- UIAlertView Method
-(void)showMessage:(NSString*)message withTitle:(NSString *)title{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    });
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
