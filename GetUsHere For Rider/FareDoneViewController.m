//
//  FareDoneViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 02/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "FareDoneViewController.h"
#import "Alertview.h"
#import "SWRevealViewController.h"
#import "SplachscreenViewController.h"
#import "GetUsHere.pch"


@interface FareDoneViewController ()
{
    UIView*popview;
    UITableViewCell *cell;
}

@end

@implementation FareDoneViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
   [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0]];
    _nav.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.title=@"Fare Details";
    
    
    _txtpick.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"pick"];
    _txtdes.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"des"];
    
    _mapView.hidden=YES;
    arrfaredetails=[[NSMutableArray alloc]init];
    arrfaredetails=[[NSUserDefaults standardUserDefaults]objectForKey:@"fare"];
    
 //   NSLog(@"final fare %@",arrfaredetails);
    
    arrairportdet=[arrfaredetails valueForKey:@"airport"];
    
    _lablwhrerefrom.text=[NSString stringWithFormat:@"Fare Estimate From %@ to %@",_txtpick.text,_txtdes.text];
    
    _txtbasefare.text=[arrfaredetails valueForKey:@"base_fare"];
    
    _txtkm.text=[arrfaredetails valueForKey:@"distance"];
  _txtkmfare.text=[arrfaredetails valueForKey:@"sub_total"];
    
    arrlength=[[NSMutableArray alloc]init];
    arrlength=[arrfaredetails valueForKey:@"tolls"];
    tollname=[[NSMutableArray alloc]init];
    tollfare=[[NSMutableArray alloc]init];
    tollname=[arrlength valueForKey:@"name"];
    tollfare=[arrlength valueForKey:@"price"];
    
    
    NSString *str=[NSString stringWithFormat:@"%lu Tolls", (unsigned long)arrlength.count];
    NSString *strairport=[NSString stringWithFormat:@"%lu airport", (unsigned long)arrairportdet.count];
    
    _txttolls.text=str;
    _txttollfare.text=[arrfaredetails valueForKey:@"total_toll_fare"];
    _txttotalfare.text=[arrfaredetails valueForKey:@"total_fare"];
    
    _lblairporttolls.text=strairport;
    _lblairporttollsfare.text=[arrfaredetails valueForKey:@"total_airport_fare"];
    
  //  _txttolls.text=[arrlength.count];
    
    [_mapView_ setDelegate:self];
    
    [self getCurentLocationwithtext:_txtpick.text];
    [self getDesLocationwithtext:_txtdes.text];
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
}


-(void)getCurentLocationwithtext:(NSString*)text
{
    
    geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:text completionHandler:^(NSArray *placemarks, NSError *error) {
      //  NSLog(@"Fetch Gecodingaddress");
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            //   NSLog(@"GET placemark%@",placemark);
            
            CLLocation *location = placemark.location;
            
            //   NSLog(@"GET location%@",location);
            
            CLLocationCoordinate2D coordinate = location.coordinate;
            
            //  NSLog(@"latitude ,longitude %f %f",coordinate.latitude, coordinate.longitude);
            
            NSDictionary *addressDic = [[placemarks objectAtIndex:0] addressDictionary];
            
            currentLocationAddArr=[addressDic valueForKey:@"FormattedAddressLines"];
            
            // NSLog(@"currentLocationAdd %@",currentLocationAddArr);
            
            for(int i=0;i<currentLocationAddArr.count;i++)
            {
                strAdd=[currentLocationAddArr objectAtIndex:0];
                
                strAdd1=[currentLocationAddArr objectAtIndex:1];
                
            };
            
            
            latitude=coordinate.latitude;
            longitude=coordinate.longitude;
            
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                                    longitude:longitude
                                                                         zoom:7];
            self.mapView_.camera=camera;
            _mapView_.myLocationEnabled = NO;
            
            marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(latitude, longitude);
            marker.title=strAdd;
            marker.snippet=strAdd1;
            marker.map = _mapView_;
           
            [self getDesLocationwithtext:_txtdes.text];
            
            
        }
        
    }];
}
-(void)getDesLocationwithtext:(NSString *)text
{
    
    geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:text completionHandler:^(NSArray *placemarks, NSError *error) {
     //   NSLog(@"Fetch Gecodingaddress");
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            //    NSLog(@"GET placemark%@",placemark);
            
            CLLocation *location = placemark.location;
            
            //   NSLog(@"GET location%@",location);
            
            CLLocationCoordinate2D coordinate = location.coordinate;
            
            //   NSLog(@"latitude ,longitude %f %f",coordinate.latitude, coordinate.longitude);
            
            NSDictionary *addressDic = [[placemarks objectAtIndex:0] addressDictionary];
            
            currentLocationAddArr=[addressDic valueForKey:@"FormattedAddressLines"];
            
            // NSLog(@"currentLocationAdd %@",currentLocationAddArr);
            
            for(int i=0;i<currentLocationAddArr.count;i++)
            {
                strAdd=[currentLocationAddArr objectAtIndex:0];
                
                strAdd1=[currentLocationAddArr objectAtIndex:1];
                
            };
            
            
            latitude1=coordinate.latitude;
            longitude1=coordinate.longitude;
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                                    longitude:longitude
                                                                         zoom:7];
            self.mapView_.camera=camera;
            _mapView_.myLocationEnabled = NO;
            
            marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(latitude1, longitude1);
            marker.title=strAdd;
            marker.snippet=strAdd1;
            marker.map = _mapView_;

            
            [self getCurentLocationwith:_txtpick.text];
            
        }
        
    }];
}

-(void)getCurentLocationwith:(NSString*)text
{
    
    geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:text completionHandler:^(NSArray *placemarks, NSError *error) {
       // NSLog(@"Fetch Gecodingaddress");
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            //   NSLog(@"GET placemark%@",placemark);
            
            CLLocation *location = placemark.location;
            
            //   NSLog(@"GET location%@",location);
            
            CLLocationCoordinate2D coordinate = location.coordinate;
            
            //  NSLog(@"latitude ,longitude %f %f",coordinate.latitude, coordinate.longitude);
            
            NSDictionary *addressDic = [[placemarks objectAtIndex:0] addressDictionary];
            
            currentLocationAddArr=[addressDic valueForKey:@"FormattedAddressLines"];
            
            // NSLog(@"currentLocationAdd %@",currentLocationAddArr);
            
            for(int i=0;i<currentLocationAddArr.count;i++)
            {
                strAdd=[currentLocationAddArr objectAtIndex:0];
                
                strAdd1=[currentLocationAddArr objectAtIndex:1];
                
            };
            latitude=coordinate.latitude;
            longitude=coordinate.longitude;
        
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                                    longitude:longitude
                                                                         zoom:7];
            self.mapView_.camera=camera;
            _mapView_.myLocationEnabled = NO;
            
            marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(latitude, longitude);
            marker.title=strAdd;
            marker.snippet=strAdd1;
            marker.map = _mapView_;

            
            NSString *str=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", latitude,  longitude, latitude1, longitude1];
            
            NSURL *url=[[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
            
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            
            NSError* error;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            NSArray* latestRoutes = [json objectForKey:@"routes"];
            
            NSString *points=[[[latestRoutes objectAtIndex:0] objectForKey:@"overview_polyline"] objectForKey:@"points"];
            
            @try {
                // TODO: better parsing. Regular expression?
                
                temp= [self decodePolyLine4:[points mutableCopy]];
                
                GMSMutablePath *path = [GMSMutablePath path];
                
                for(int idx = 0; idx < [temp count]; idx++)
                {
                    CLLocation *location=[temp objectAtIndex:idx];
                    
                    [path addCoordinate:location.coordinate];
                    
                }
                // create the polyline based on the array of points.
                GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
                
                rectangle.strokeWidth=2.0;
                
                rectangle.strokeColor=[UIColor blueColor];
                
                rectangle.map = _mapView_;
            }
            @catch (NSException * e)
            {
                
            }

            
            }
        
    }];
}
-(NSMutableArray *)decodePolyLine4: (NSMutableString *)encoded {
    [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
                                options:NSLiteralSearch
                                  range:NSMakeRange(0, [encoded length])];
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init] ;
    NSInteger lattt=0;
    NSInteger lng=0;
    while (index < len) {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lattt += dlat;
        shift = 0;
        result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        NSNumber *latitude22 = [[NSNumber alloc] initWithFloat:lattt * 1e-5] ;
        NSNumber *longitude22 = [[NSNumber alloc] initWithFloat:lng * 1e-5] ;
    //    printf("[%f,", [latitude22 doubleValue]);
    //    printf("%f]", [longitude22 doubleValue]);
        
        [arrpointlat5 addObject:latitude22];
        [arrpointlong5 addObject:longitude22];
        
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude22 floatValue] longitude:[longitude22 floatValue]] ;
        [array addObject:loc];
    }
    return array;
}




#pragma - mark -
#pragma - mark Tableview delegate methodes

- (IBAction)TollsClicked:(id)sender
{
    
    if (arrlength.count==0)
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
        return tollname.count;
    }
    else if (tabl.tag==2)
    {
        return arrairportdet.count;
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
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width/1.5, 30)];
        namel.text=[[arrlength valueForKey:@"user_define_name"]objectAtIndex:indexPath.row];
        namel.lineBreakMode = NSLineBreakByWordWrapping;
        namel.numberOfLines = 1;
        // namel.font=[UIFont systemFontOfSize:15];
        [namel setFont:[UIFont boldSystemFontOfSize:16]];
        [cell addSubview:namel];
        
        UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, namel.frame.origin.y+28, cell.frame.size.width/1.5, cell.frame.size.height)];
        namelabel.text=[[arrlength valueForKey:@"name"]objectAtIndex:indexPath.row];
        namelabel.lineBreakMode = NSLineBreakByWordWrapping;
        namelabel.numberOfLines = 3;
        namelabel.font=[UIFont systemFontOfSize:13];
        [cell addSubview:namelabel];
        
        UILabel *pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(namelabel.frame.origin.x+namelabel.frame.size.width + 10 , 20, cell.frame.size.width/4, cell.frame.size.height)];
        pricelabel.text=[NSString stringWithFormat:@"%@",[[arrlength valueForKey:@"price"] objectAtIndex:indexPath.row]];
        pricelabel.textAlignment = NSTextAlignmentCenter;
        namelabel.font=[UIFont systemFontOfSize:14];
        [cell addSubview:pricelabel];
        
    }
    
    else if (tabl.tag==2)
    {
        static NSString *cellIdetifier = @"Cell";
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *namel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width/1.5, 30)];
        namel.text=[[arrairportdet valueForKey:@"user_define_name"]objectAtIndex:indexPath.row];
        namel.lineBreakMode = NSLineBreakByWordWrapping;
        namel.numberOfLines = 1;
        //  namel.font=[UIFont systemFontOfSize:15];
        [namel setFont:[UIFont boldSystemFontOfSize:16]];
        [cell addSubview:namel];
        
        UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, namel.frame.origin.y+28, cell.frame.size.width/1.5, cell.frame.size.height)];
        namelabel.text=[[arrairportdet valueForKey:@"name"]objectAtIndex:indexPath.row];
        namelabel.lineBreakMode = NSLineBreakByWordWrapping;
        namelabel.numberOfLines = 3;
        namelabel.font=[UIFont systemFontOfSize:13];
        [cell addSubview:namelabel];
        
        UILabel *pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(namelabel.frame.origin.x+namelabel.frame.size.width + 10 , 20, cell.frame.size.width/4, cell.frame.size.height)];
        pricelabel.text=[NSString stringWithFormat:@"%@",[[arrairportdet valueForKey:@"price"] objectAtIndex:indexPath.row]];
        pricelabel.textAlignment = NSTextAlignmentCenter;
        namelabel.font=[UIFont systemFontOfSize:14];
        [cell addSubview:pricelabel];
    }
    return cell;
}


- (IBAction)airportTollsClicked:(id)sender
{

    
    if (arrairportdet.count==0)
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






- (IBAction)sidebarButton:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];


}
-(void)viewDidDisappear:(BOOL)animated{
    
    self.title = @"";
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Fare Details";
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
    
   // NSLog(@"***** login check details ******* %@", responseJSON);
    
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
