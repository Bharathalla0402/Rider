//
//  CompletedInvoiceViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 31/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "CompletedInvoiceViewController.h"
#import "GetUsHere.pch"
#import "DejalActivityView.h"
#import "SidebarViewController.h"
#import "SplachscreenViewController.h"
#import "Reachability.h"


@interface CompletedInvoiceViewController ()

@end

@implementation CompletedInvoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _BaseFareCrossLine.hidden=YES;
    _MilesFareCrossLine.hidden=YES;
    
    _triptodriver.hidden=YES;
    _tripamountView.hidden=YES;
    _dollerlable.hidden=YES;
    _amountlable.hidden=YES;
    _dolleramountbutt.hidden=YES;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        popview = [[ UIView alloc]init];
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

- (IBAction)proceedtopaymentClicked:(id)sender
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //  popview.backgroundColor = [UIColor clearColor];
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height/2-10, self.view.frame.size.width-20, 130)];
    //footerview.backgroundColor=[UIColor blackColor];
    footerview.backgroundColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    [popview addSubview:footerview];
    
    labelname=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, footerview.frame.size.width-10, 30)];
    labelname.text=@"Are You Sure You Want to send invoice to email";
    labelname.textColor=[UIColor whiteColor];
    labelname.textAlignment=NSTextAlignmentCenter;
    labelname.font=[UIFont systemFontOfSize:13];
    [footerview addSubview:labelname];
    
    
    lab1=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, footerview.frame.size.width-20, 30)];
    lab1.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    lab1.backgroundColor=[UIColor whiteColor];
    lab1.textColor=[UIColor blackColor];
    lab1.textAlignment=NSTextAlignmentCenter;
    lab1.font=[UIFont systemFontOfSize:13];
    lab1.userInteractionEnabled=NO;
    [footerview addSubview:lab1];
    
    UIButton *cancelbutt=[[UIButton alloc]initWithFrame:CGRectMake(5, 90, footerview.frame.size.width/3-5, 30)];
    cancelbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    [cancelbutt  setTitle:@"Send" forState:UIControlStateNormal];
    [cancelbutt addTarget:self action:@selector(sendClicked) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:cancelbutt];
    
    UIButton *add=[[UIButton alloc]initWithFrame:CGRectMake(cancelbutt.frame.size.width+10, 90, footerview.frame.size.width/3-10, 30)];
    add.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    [add  setTitle:@"Cancel" forState:UIControlStateNormal];
    [add addTarget:self action:@selector(cancelclicked) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:add];
    
    UIButton *edit=[[UIButton alloc]initWithFrame:CGRectMake(cancelbutt.frame.size.width+add.frame.size.width+15, 90, footerview.frame.size.width/3-15, 30)];
    edit.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    [edit  setTitle:@"Edit" forState:UIControlStateNormal];
    [edit addTarget:self action:@selector(editClicked) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:edit];
    
    lab1.delegate=self;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSString *trimmedString = [checkString stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    return [emailTest evaluateWithObject:trimmedString];
}

-(void)cancelclicked
{
     lab1.userInteractionEnabled=NO;
    [self.view endEditing:YES];
    [footerview removeFromSuperview];
    popview.hidden = YES;
    
}

-(void)editClicked
{
    lab1.userInteractionEnabled=YES;
    [lab1 becomeFirstResponder];
}

-(void)sendClicked
{
    [self checkNetworkStatus];
    if (lab1.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Enter Email Id" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (![self NSStringIsValidEmail:lab1.text])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Enter Valid Email Id" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];

    }
    else if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }
    else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,invoiceemail]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"tripid" ]]];
        [profile appendString:[NSString stringWithFormat:@"&email=%@",lab1.text]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else
                                   {
                                       [self parseJSONR4:data];
                                   }
                               }];
        
    }
}


-(void)parseJSONR4:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"***** Emergency contact details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        [self.view endEditing:YES];
        lab1.userInteractionEnabled=NO;
        [footerview removeFromSuperview];
        popview.hidden = YES;
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Invoice Details has been sended to your Prefered Email Id" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        SidebarViewController *sch=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
        [self.navigationController pushViewController:sch animated:YES];
    }
}



#pragma mark
#pragma mark -- TextfieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -120; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}



-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
