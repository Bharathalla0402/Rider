//
//  InvoiceDetailViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 17/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "InvoiceDetailViewController.h"
#import "GetUsHere.pch"
#import "DejalActivityView.h"
#import "PaymentViewController.h"
#import "SelectPaymentViewController.h"
#import "SWRevealViewController.h"
#import "SplachscreenViewController.h"
#import "Reachability.h"
#import "ACFloatingTextField.h"

@interface InvoiceDetailViewController ()<UITextFieldDelegate>
{
    ACFloatingTextField *forgotPasswordMobile;
    UILabel *forgotPasswordMobileUnderlabel;
}

@end

@implementation InvoiceDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _BaseFareCrossLine.hidden=YES;
    _MilesFareCrossLine.hidden=YES;
    
    self.title=@"Invoice Details";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor=[UIColor lightGrayColor];
    
    _faredetailsView.textColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _faredetailslinelab.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _bookingdetailslab.textColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _bookingdetailslinelab.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _pickuplocationtitlelab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _deslocationtitlelab.textColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _proceedtopaymentbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];

    
    arrinvoiceDetails=[[NSMutableArray alloc]init];
    arrtollscount=[[NSMutableArray alloc]init];
    arrairportcount=[[NSMutableArray alloc]init];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"InvoiceDetails"];
    
    arrinvoiceDetails = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
  //  arrinvoiceDetails=[[NSUserDefaults standardUserDefaults]objectForKey:@"InvoiceDetails"];
    
    
    arrtollscount=[arrinvoiceDetails valueForKey:@"tolls"];
    arrairportcount=[arrinvoiceDetails valueForKey:@"airport"];
    
    if (arrtollscount != (id)[NSNull null])
    {
        
        strtollsnumber=[NSString stringWithFormat:@"%lu Tolls",(unsigned long)arrtollscount.count];
        
    }
    else
    {
        strtollsnumber=@"0";
    }
    
    
    if (arrairportcount != (id)[NSNull null])
    {
        
        strairportcoun=[NSString stringWithFormat:@"%lu",(unsigned long)arrairportcount.count];
        
    }
    else
    {
        strairportcoun=@"0";
    }

    
    strmiles=[NSString stringWithFormat:@"Rate for %@",[arrinvoiceDetails valueForKey:@"distance"]];
    
    NSString *stramount=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_tip"]];
    
    if ([stramount isEqualToString:@""])
    {
        _tipamount.text=[NSString stringWithFormat:@"$%@",@"0"];
    }
    else{
//        _tipamount.text=stramount;
         _tipamount.text=[NSString stringWithFormat:@"$%@",stramount];
    }
    
    NSString *strwaitingcharge=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_waiting"]];
    
    _waitingChargeLab.text=[NSString stringWithFormat:@"$%@",strwaitingcharge];
    
    NSString *strservicetax=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"service_tax"]];
    NSString *strtip=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_tip"]];
    
    
    
    _invoiceno.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"invoice_id"]];
    _totaldistance.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"distance"]];
    _totalridetime.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"duration"]];
    
    NSString *strDiscountcharge=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"discount"]];
    
    _DiscountPricelab.text=[NSString stringWithFormat:@"$%@",strDiscountcharge];
    
    NSString *strtotalfarevalue=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_fare_value"]];
    value1=[strwaitingcharge intValue];
    value2=[strtotalfarevalue intValue];
    value3=[strservicetax intValue];
    value4=[strtip intValue];
    value8=[strDiscountcharge intValue];
    
    value5=value1+value2+value3+value4-value8;
    
    
    _totalfare.text=[NSString stringWithFormat:@"$%d",value5];

    
    
      _basefare.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"base_fare"]];
      _ratemileslable.text=[NSString stringWithFormat:@"%@",strmiles];
      _ratemilesamount.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"sub_total"]];
      _totaltollscountlable.text=[NSString stringWithFormat:@"%@",strtollsnumber];
      _totaltollsfare.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_toll_fare"]];
      _servicetax.text=[NSString stringWithFormat:@"$%@",[arrinvoiceDetails valueForKey:@"service_tax"]];
      _pickupaddress.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"src_addr"]];
      _desaddress.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"dest_addr"]];
    
    
    NSString *strpictime=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"tripStartTime"]];
    NSArray *arr = [strpictime componentsSeparatedByString:@" "];
    _pickuptime.text=[arr objectAtIndex:1];
    
    NSString *strdestime=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"tripEndTime"]];
    NSArray *arr2 = [strdestime componentsSeparatedByString:@" "];
    _destime.text=[arr2 objectAtIndex:1];

    _airportcountlable.text=[NSString stringWithFormat:@"%@ Airport",strairportcoun];
    
    _airportfare.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_airport_fare"]];
    
    NSString *strtripid=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"trip_id"]];
    [[NSUserDefaults standardUserDefaults]setObject:strtripid forKey:@"tripid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
//    NSString *strtipamountlab=[[NSUserDefaults standardUserDefaults]objectForKey:@"tipamount"];
//    
//    if ([strtipamountlab isEqualToString:@"0"] || [strtipamountlab isEqualToString:@"1"] || [strtipamountlab isEqualToString:@"2"] || [strtipamountlab isEqualToString:@"3"] || [strtipamountlab isEqualToString:@"4"] || [strtipamountlab isEqualToString:@"5"] || [strtipamountlab isEqualToString:@"6"] || [strtipamountlab isEqualToString:@"7"] || [strtipamountlab isEqualToString:@"8"] || [strtipamountlab isEqualToString:@"9"] || [strtipamountlab isEqualToString:@"10"])
//    {
//        _amountlable.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"tipamount"];
//        _tipamount.text=[NSString stringWithFormat:@"$%@",_amountlable.text];
//    }
//    else
//    {
//     _amountlable.text=@"0";
//    }
    
    
    NSLog(@"%@",strtollsnumber);
    NSLog(@"%@",strmiles);
    
    
    NSString *strbasefareValue=[[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"base_fare"]] substringFromIndex:1];
    NSString *strSubTotalValue=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"sub_total_value"]];
    int a=(int)[strbasefareValue integerValue];
    int b=(int)[strSubTotalValue integerValue];
    
    if (a<b)
    {
        _BaseFareCrossLine.hidden=NO;
    }
    else
    {
        _MilesFareCrossLine.hidden=NO;
    }
    
    
  
    
//    NSLog(@"%@",strbasefareValue);
//    NSLog(@"%@",strSubTotalValue);
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"body_background2.png"]];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)DolleramountbuttClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {

    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"Select Trip Amount" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    
    [sheet showInView:self.view];
    }

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if(buttonIndex==0)
    {
        _tipamount.text=[NSString stringWithFormat:@"$%@",@"0"];
        _amountlable.text=@"0";
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self trip];
        
    }
    else if (buttonIndex==1)
    {
        _tipamount.text=[NSString stringWithFormat:@"$%@",@"1"];
        _amountlable.text=@"1";
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self trip];
    }

    else if (buttonIndex==2)
    {
       _tipamount.text=[NSString stringWithFormat:@"$%@",@"2"];
        _amountlable.text=@"2";
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self trip];
    }
    else if (buttonIndex==3)
    {
        _tipamount.text=[NSString stringWithFormat:@"$%@",@"3"];
        _amountlable.text=@"3";
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self trip];
    }
    else if (buttonIndex==4)
    {
      _tipamount.text=[NSString stringWithFormat:@"$%@",@"4"];
        _amountlable.text=@"4";
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self trip];
    }
    else if (buttonIndex==5)
    {
       _tipamount.text=[NSString stringWithFormat:@"$%@",@"5"];
        _amountlable.text=@"5";
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self trip];
    }
    else if (buttonIndex==6)
    {
        _tipamount.text=[NSString stringWithFormat:@"$%@",@"6"];
        _amountlable.text=@"6";
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self trip];
    }
    else if (buttonIndex==7)
    {
        _tipamount.text=[NSString stringWithFormat:@"$%@",@"7"];
        _amountlable.text=@"7";
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self trip];
    }
    else if (buttonIndex==8)
    {
       _tipamount.text=[NSString stringWithFormat:@"$%@",@"8"];
        _amountlable.text=@"8";
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self trip];
    }
    else if (buttonIndex==9)
    {
       _tipamount.text=[NSString stringWithFormat:@"$%@",@"9"];
        _amountlable.text=@"9";
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self trip];
    }
    else if (buttonIndex==10)
    {
        _tipamount.text=[NSString stringWithFormat:@"$%@",@"10"];
        _amountlable.text=@"10";
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self trip];
    }
    
    
   
    
}

- (IBAction)tollsinfoClicked:(id)sender
{
    if (arrtollscount.count==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Tolls Information" message:@"There is no Tolls in this Region" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else
    {
        popview = [[ UIView alloc]init];
        popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //  popview.backgroundColor = [UIColor clearColor];
        popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
        
        [self.view addSubview:popview];
        
        footerview=[[UIView alloc] initWithFrame:CGRectMake(5, self.view.frame.size.height/3, self.view.frame.size.width-10, 201)];
        //footerview.backgroundColor=[UIColor blackColor];
        footerview.backgroundColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [popview addSubview:footerview];
        
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
        lab.text=@"Tolls Information";
        lab.textColor=[UIColor whiteColor];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.font=[UIFont systemFontOfSize:16];
        [footerview addSubview:lab];
        
        UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-40,8,25,21)];
        [butt setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
        //[butt setTitle:@"CLOSE" forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(butnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [footerview addSubview:butt];
        
        
        UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(3, 0, footerview.frame.size.width, 40)];
        //  [butt setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
        //[butt setTitle:@"CLOSE" forState:UIControlStateNormal];
        [butt1 addTarget:self action:@selector(butnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [footerview addSubview:butt1];
        
        tabl=[[UITableView alloc] init];
        tabl.frame = CGRectMake(0,butt.frame.origin.y+butt.frame.size.height+10, footerview.frame.size.width, 180);
        tabl.delegate=self;
        tabl.dataSource=self;
        tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [footerview addSubview:tabl];
        tabl.tag=1;
        
        [popview addSubview:footerview];
        
    }
}

-(void)butnclicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tabl.tag==1)
    {
        return arrtollscount.count;
    }
    else if (tabl.tag==2)
    {
        return arrairportcount.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tabl.tag==1)
    {
        return 90;
    }
    else if (tabl.tag==2)
    {
        return 90;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tabl.tag==1)
    {
        static NSString *cellIdetifier = @"Cell";
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
        
        
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width/1.5, 30)];
        namel.text=[[arrtollscount valueForKey:@"user_define_name"]objectAtIndex:indexPath.row];
        namel.lineBreakMode = NSLineBreakByWordWrapping;
        namel.numberOfLines = 1;
       // namel.font=[UIFont systemFontOfSize:15];
        [namel setFont:[UIFont boldSystemFontOfSize:16]];
        [cell addSubview:namel];
        
        UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, namel.frame.origin.y+28, cell.frame.size.width/1.5, cell.frame.size.height)];
        namelabel.text=[[arrtollscount valueForKey:@"name"]objectAtIndex:indexPath.row];
        namelabel.lineBreakMode = NSLineBreakByWordWrapping;
        namelabel.numberOfLines = 3;
        namelabel.font=[UIFont systemFontOfSize:13];
        [cell addSubview:namelabel];
        
        UILabel *pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(namelabel.frame.origin.x+namelabel.frame.size.width + 10 , 20, cell.frame.size.width/4, cell.frame.size.height)];
        pricelabel.text=[NSString stringWithFormat:@"%@",[[arrtollscount valueForKey:@"price"] objectAtIndex:indexPath.row]];
        pricelabel.textAlignment = NSTextAlignmentCenter;
        namelabel.font=[UIFont systemFontOfSize:14];
        [cell addSubview:pricelabel];
        
    }
    
    else if (tabl.tag==2)
    {
        static NSString *cellIdetifier = @"Cell";
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
        
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width/1.5, 30)];
        namel.text=[[arrairportcount valueForKey:@"user_define_name"]objectAtIndex:indexPath.row];
        namel.lineBreakMode = NSLineBreakByWordWrapping;
        namel.numberOfLines = 1;
      //  namel.font=[UIFont systemFontOfSize:15];
        [namel setFont:[UIFont boldSystemFontOfSize:16]];
        [cell addSubview:namel];
        
        UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, namel.frame.origin.y+28, cell.frame.size.width/1.5, cell.frame.size.height)];
        namelabel.text=[[arrairportcount valueForKey:@"name"]objectAtIndex:indexPath.row];
        namelabel.lineBreakMode = NSLineBreakByWordWrapping;
        namelabel.numberOfLines = 3;
        namelabel.font=[UIFont systemFontOfSize:13];
        [cell addSubview:namelabel];
        
        UILabel *pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(namelabel.frame.origin.x+namelabel.frame.size.width + 10 , 20, cell.frame.size.width/4, cell.frame.size.height)];
        pricelabel.text=[NSString stringWithFormat:@"%@",[[arrairportcount valueForKey:@"price"] objectAtIndex:indexPath.row]];
        pricelabel.textAlignment = NSTextAlignmentCenter;
        namelabel.font=[UIFont systemFontOfSize:14];
        [cell addSubview:pricelabel];
    }
    return cell;
}


- (IBAction)airportinfoClicked:(id)sender
{
    if (arrairportcount.count==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Tolls Information" message:@"There is no Tolls in this Region" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else
    {
        popview = [[UIView alloc]init];
        popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //  popview.backgroundColor = [UIColor clearColor];
        popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
        
        [self.view addSubview:popview];
        
        footerview=[[UIView alloc] initWithFrame:CGRectMake(5, self.view.frame.size.height/3, self.view.frame.size.width-10, 111)];
        //footerview.backgroundColor=[UIColor blackColor];
        footerview.backgroundColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
        [popview addSubview:footerview];
        
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(3, 0, 160, 40)];
        lab.text=@"Airport's Information";
        lab.textColor=[UIColor whiteColor];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.font=[UIFont systemFontOfSize:16];
        [footerview addSubview:lab];
        
        UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width-40,8,25,21)];
        [butt setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
        //[butt setTitle:@"CLOSE" forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(butnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [footerview addSubview:butt];
        
        
        UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(3, 0, footerview.frame.size.width, 40)];
        //  [butt setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
        //[butt setTitle:@"CLOSE" forState:UIControlStateNormal];
        [butt1 addTarget:self action:@selector(butnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [footerview addSubview:butt1];
        
        tabl=[[UITableView alloc] init];
        tabl.frame = CGRectMake(0,butt.frame.origin.y+butt.frame.size.height+10, footerview.frame.size.width, 90);
        tabl.delegate=self;
        tabl.dataSource=self;
        tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [footerview addSubview:tabl];
        tabl.tag=2;
        
        [popview addSubview:footerview];
    }
}


-(void)trip
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,addtrip]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"trip_id"]]]];
    [profile appendString:[NSString stringWithFormat:@"&total_tip=%@",_amountlable.text]];
    
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONR:data];
                               }
                           }];
}

-(void)parseJSONR:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"*****Tip details ******* %@", responseJSON);
    
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
      //  NSString *str1=[arrinvoiceDetails valueForKey:@"total_fare_value"];
        NSString *str2=[NSString stringWithFormat:@"%@",_amountlable.text];
        
//        int value1 = [str1 intValue];
//        NSLog(@"%i",value1);
        
        value6 = [str2 intValue];
         NSLog(@"%i",value2);
        
        [[NSUserDefaults standardUserDefaults]setObject:str2 forKey:@"tipamount"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        value7=value1+value2+value3+value6-value8;
         NSLog(@"%i",value3);
        
        NSString *myNewString = [NSString stringWithFormat:@"%i", value7];
        
        NSLog(@"%@",myNewString);
        
        _totalfare.text=[NSString stringWithFormat:@"$%@",myNewString];
    }
}



- (IBAction)proceedtopaymentClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
    
    [[NSUserDefaults standardUserDefaults]setObject:_totalfare.text forKey:@"totalfare"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    SelectPaymentViewController *pvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectPaymentViewController"];
    [self.navigationController pushViewController:pvc animated:YES];
    }
}



-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title=@"Invoice Details";
    
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




- (IBAction)CuponCodeButtClicked:(id)sender
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-100, 300, 200)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 40)];
    lab.text=@"Enter Coupon code";
    lab.textColor=[UIColor blackColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(0, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width, 2)];
    labeunder.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:labeunder];
    
    
    forgotPasswordMobile=[[ACFloatingTextField alloc]initWithFrame:CGRectMake(10, labeunder.frame.size.height+labeunder.frame.origin.y+15, footerview.frame.size.width-20, 40)];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Enter Coupon code" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    forgotPasswordMobile.attributedPlaceholder = str;
    forgotPasswordMobile.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    forgotPasswordMobile.textColor=[UIColor blackColor];
    forgotPasswordMobile.font = [UIFont systemFontOfSize:15];
    forgotPasswordMobile.backgroundColor=[UIColor clearColor];
    forgotPasswordMobile.delegate=self;
    forgotPasswordMobile.returnKeyType = UIReturnKeyDone;
    [footerview addSubview:forgotPasswordMobile];
    
    forgotPasswordMobileUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, forgotPasswordMobile.frame.size.height+forgotPasswordMobile.frame.origin.y+1, footerview.frame.size.width-20, 2)];
    forgotPasswordMobileUnderlabel.backgroundColor=[UIColor lightGrayColor];
    forgotPasswordMobileUnderlabel.hidden=YES;
    [footerview addSubview:forgotPasswordMobileUnderlabel];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(10,forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35,footerview.frame.size.width/2-15,40)];
    [butt setTitle:@"Cancel" forState:UIControlStateNormal];
    butt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt addTarget:self action:@selector(CancelButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor=[UIColor grayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+10, forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35, footerview.frame.size.width/2-15, 40)];
    [butt1 setTitle:@"Apply" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt1 addTarget:self action:@selector(DoneButtClicked2:) forControlEvents:UIControlEventTouchUpInside];
    butt1.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:butt1];
}


-(IBAction)CancelButtClicked2:(id)sender
{
    [footerview endEditing:YES];
    [footerview removeFromSuperview];
    popview.hidden = YES;
}

-(IBAction)DoneButtClicked2:(id)sender
{
    [footerview endEditing:YES];
    if (forgotPasswordMobile.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please Enter Your Coupon Code" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,@"check_coupon"]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        NSString *strtripIdforCoupon=[[NSUserDefaults standardUserDefaults]objectForKey:@"tripid"];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@", strtripIdforCoupon]];
        [profile appendString:[NSString stringWithFormat:@"&coupon=%@",forgotPasswordMobile.text]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       [self parseJSONCoupon:data];
                                   }
                               }];
    }
}


-(void)parseJSONCoupon:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    NSLog(@"***** Coupon check details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        [DejalBezelActivityView removeView];
        
        [footerview endEditing:YES];
        [footerview removeFromSuperview];
        popview.hidden = YES;

        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        [footerview endEditing:YES];
        [footerview removeFromSuperview];
         popview.hidden = YES;
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,invoicedetail]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        NSString *strtripIdforCoupon=[[NSUserDefaults standardUserDefaults]objectForKey:@"tripid"];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@",strtripIdforCoupon]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       [self parseJSONDiscountInvoice:data];
                                       
                                   }
                               }];

    }
}


-(void)parseJSONDiscountInvoice:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    NSLog(@"***** Invoice Discount Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        arrinvoiceDetails=[responseJSON valueForKey:@"data"];
        
        NSString *strDiscountcharge=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"discount"]];
        
        _DiscountPricelab.text=[NSString stringWithFormat:@"$%@",strDiscountcharge];
        
        
        
        NSString *strwaitingcharge=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_waiting"]];
        
        _waitingChargeLab.text=[NSString stringWithFormat:@"$%@",strwaitingcharge];
        
        NSString *strservicetax=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"service_tax"]];
        NSString *strtip=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_tip"]];
        
        
        
        _invoiceno.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"invoice_id"]];
        _totaldistance.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"distance"]];
        _totalridetime.text=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"duration"]];
        
        
        NSString *strtotalfarevalue=[NSString stringWithFormat:@"%@",[arrinvoiceDetails valueForKey:@"total_fare_value"]];
        value1=[strwaitingcharge intValue];
        value2=[strtotalfarevalue intValue];
        value3=[strservicetax intValue];
        value4=[strtip intValue];
        value8=[strDiscountcharge intValue];
        
        value5=value1+value2+value3+value4-value8;
        
        
        _totalfare.text=[NSString stringWithFormat:@"$%d",value5];
    }
}




-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [(ACFloatingTextField *)textField textFieldDidBeginEditing];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [(ACFloatingTextField *)textField textFieldDidEndEditing];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==forgotPasswordMobile)
    {
        [textField resignFirstResponder];
        return YES;
    }
    return YES;
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
