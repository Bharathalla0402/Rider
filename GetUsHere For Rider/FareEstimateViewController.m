//
//  FareEstimateViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 01/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "FareEstimateViewController.h"
#import "DejalActivityView.h"
#import "SidebarViewController.h"
#import "FareDoneViewController.h"
#import "Alertview.h"
#import "MVPlaceSearchTextField.h"
#import "GetUsHere.pch"
#import "SWRevealViewController.h"
#import "SplachscreenViewController.h"


typedef enum{
    
    buttontag1= 100
    
}buttontag;

@interface FareEstimateViewController ()
{
    
    
    NSMutableArray *DataArray;
    UIView *footerview;
    NSString *carID;
    NSMutableDictionary *dictionary;
    NSString *selectedCategory;
    NSString *strid;
    
    NSMutableArray *arrfareDetails;
 
}

@end

@implementation FareEstimateViewController
@synthesize catID,select_item,mapView;

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _txtCarType.tag= 1;
    // Do any additional setup after loading the view.
    
     _placesClient = [[GMSPlacesClient alloc] init];
    
    self.navigationItem.title=@"Fare Estimate";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
     self.navigationItem.leftBarButtonItem = backButton;
    
    _DoneClicked.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _CancelClicked.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if(IS_OS_8_OR_LATER)
    {
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
    mapView.showsUserLocation = YES;
    mapView.delegate=self;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"map_375_637.png"]];
    
    arrcar=[[NSMutableArray alloc]init];
    arrcar=[[NSUserDefaults standardUserDefaults]objectForKey:@"cars"];
    
    arrfareDetails=[[NSMutableArray alloc]init];
    self.txtRestaurant.delegate=self;
    self.txtRest.delegate=self;
    self.txtCar.delegate=self;
    //self.txtCarType.delegate=self;
    [locationTbl setHidden:YES];
    [locationTbl2 setHidden:YES];
    [tabl setHidden:YES];
    
    tabl=[[UITableView alloc] init];
    tabl.frame = CGRectMake(10,_txtCar.frame.origin.y+_txtCar.frame.size.height,self.view.frame.size.width-20,200);
    tabl.delegate=self;
    tabl.dataSource=self;
    tabl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [mapView removeAnnotations:mapView.annotations];
    arrcares=[[NSMutableArray alloc]init];
    self.mapView.delegate = self;
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
}

-(void)barButtonBackPressed:(id)sender
{
    self.view.userInteractionEnabled=NO;
    SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:side animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];// this will do the trick
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *location = [locations objectAtIndex:0];
    
    [locationManager stopUpdatingLocation];
    
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude]; //insert your coordinates
    
    
    [ceo reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error)
     {
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         //     NSLog(@"placemark %@",placemark);
         //String to hold address
         NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         NSLog(@"I am currently at %@",locatedAt);
         _txtRestaurant.text=locatedAt;
         [self getCurentLocationwithtext:_txtRestaurant.text];
         
     }
     ];
}



-(void)PostdateToServerwithParameters:(NSString *)parameters andApiExtension:(NSString *)ext
{
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,ext]]];
//    request.HTTPMethod = @"POST";
//    request.HTTPBody  = [parameters dataUsingEncoding:NSUTF8StringEncoding];
//    
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                               if (error) {
//                                   // Handle error
//                                   //[self handleError:error];
//                                   [DejalBezelActivityView removeViewAnimated:YES];
//                               } else {
//                                   [self parseJSONResponse:data];
//                                   [DejalBezelActivityView removeViewAnimated:YES];
//                               }
//                           }];
    
    
    NSData *postData = [parameters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,ext];
    [request setURL:[NSURL URLWithString:strurl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            [self parseJSONResponse:data];
            
        });
    }] resume];
}

-(void)parseJSONResponse:(NSData*)responseData
{
    NSError *err;
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
  //  NSLog(@"*****Cars types ******* %@", responseJSON);
    NSString *status = [responseJSON valueForKey:@"status"];
    [tabl reloadData];
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        DataArray=[NSMutableArray array];
        [DataArray addObjectsFromArray:[responseJSON valueForKey:@"data"]];
    //    _txtCarType.inputView=tabl;
        [tabl reloadData];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==_txtCar)
    {
        tabl.tag=1;
        _txtCar.inputView=tabl;
        _txtCarType.text=nil;
        [tabl reloadData];
    }
    
   else if (textField==_txtCarType)
   {
      [_txtCar resignFirstResponder];
       if (_txtCar.text.length == 0)
       {
           
           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please select car" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
           
           [alert show];
           return;
       }
       else
       {
           tabl.tag=2;
           
//           NSMutableString* profile = [NSMutableString string];
//           [profile appendString:[NSString stringWithFormat:@"category_id=%@", carID]];
           
            NSString *post = [NSString stringWithFormat:@"category_id=%@", carID];
           
           [DejalBezelActivityView activityViewForView:tabl withLabel:@"Please wait..."];
           [self PostdateToServerwithParameters:post andApiExtension:@"get_car_types"];
           _txtCarType.inputView=tabl;
            [tabl reloadData];
          // [_txtCarType resignFirstResponder];

       }
    }
    else if (textField==_txtRestaurant)
    {
    
        [self animateTextField:textField up:YES];
       
    }
    else if (textField==_txtRest)
    {
        
        [self animateTextField:textField up:YES];
    }
}




- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag==1)
    {
        return @"Select a car";
    }else if(tableView.tag==2)
    {
        return @"Select a carType";
    }
    else if (tableView==locationTbl)
    {
        return @"Please Select Source Location";
    }
    else
        return @"Please Select Destination Location";
    
}
-(void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]])
    {
        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
        UIView* content = castView.contentView;
        UIColor* color = [UIColor colorWithWhite:0.85 alpha:1.]; // substitute your color here
        content.backgroundColor = color;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (IBAction)DoneClicked:(id)sender
{
    if (_txtRestaurant.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter Your Source Location" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    else if (_txtRest.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter Your Destination Location" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    else if (_txtCarType.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Select Car Type" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self next];
        
       
        
        NSString *strr=_txtRestaurant.text;
        NSString *str1=_txtRest.text;
        
        [[NSUserDefaults standardUserDefaults]setObject:strr forKey:@"pick"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"des"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
//        
//        FareDoneViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"FareDoneViewController"];
//                [self.navigationController pushViewController:bookTax animated:YES];
        
    }


}
-(void)next
{
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,estimateFare]]];
//    
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//    [profile appendString:[NSString stringWithFormat:@"car_type=%@", strid]];
//    [profile appendString:[NSString stringWithFormat:@"&src_lat=%f", latitude]];
//    [profile appendString:[NSString stringWithFormat:@"&src_lng=%f", longitude]];
//    [profile appendString:[NSString stringWithFormat:@"&dest_lat=%f", latitude1]];
//    [profile appendString:[NSString stringWithFormat:@"&dest_lng=%f", longitude1]];
//    
//    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
//    
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *dat, NSError *error) {
//                               if (error) {
//                                   // Handle error
//                                   //[self handleError:error];
//                               } else {
//                                   [self parseJSONRespons:dat];
//                               }
//                           }];
    
    NSString *post = [NSString stringWithFormat:@"car_type=%@&src_lat=%f&src_lng=%f&dest_lat=%f&dest_lng=%f", strid,latitude,longitude,latitude1,longitude1];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,estimateFare];
    [request setURL:[NSURL URLWithString:strurl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *dat, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            [self parseJSONRespons:dat];
            
        });
    }] resume];
}

-(void)parseJSONRespons:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
//    NSLog(@"*****Fare details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
   
    arrfareDetails=[responseJSON valueForKey:@"data"];
    
    NSLog(@"array%@",arrfareDetails);
    
    [[NSUserDefaults standardUserDefaults]setObject:arrfareDetails forKey:@"fare"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    

    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        FareDoneViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"FareDoneViewController"];
        [self.navigationController pushViewController:bookTax animated:YES];
    }

}

- (IBAction)CancelClicked:(id)sender
{
    SidebarViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:bookTax animated:YES];
}


#pragma - mark -
#pragma - mark Tableview delegate methodes

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1)
    {
        return arrcar.count;
        
    }else if (tableView.tag==2)
    {
    
        return DataArray.count;
    }
    else
    
    return [arrLocations count];
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"Cell1";
    static NSString *CellIdentifier2 = @"Cell2";
    static NSString *CellIdentifier3 = @"Cell3";
    static NSString *CellIdentifier4 = @"Cell4";
    
    UITableViewCell *cell;
    
    if (tableView.tag==1) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier1];
        }
        
         cell.textLabel.text=[[arrcar objectAtIndex:indexPath.row] valueForKey:@"name"];
        
    }else if (tableView.tag==2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier2];
        }
        
        cell.textLabel.text=[[DataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    }
    else if(tableView==locationTbl)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier2];
        }

        cell.textLabel.text=[arrLocations objectAtIndex:indexPath.row];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier2];
        }
        
        cell.textLabel.text=[arrLocations objectAtIndex:indexPath.row];
    
    
    }
   
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==1)
    {
        [tabl deselectRowAtIndexPath:indexPath animated:YES];
        _txtCar.text=[[arrcar objectAtIndex:indexPath.row] valueForKey:@"name"];
        carID=[[arrcar objectAtIndex:indexPath.row] valueForKey:@"id"];
        [_txtCar resignFirstResponder];
        [tabl reloadData];
    }else if (tableView.tag==2)
    {
        [tabl deselectRowAtIndexPath:indexPath animated:YES];
        _txtCarType.text=[[DataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
        strid=[[DataArray objectAtIndex:indexPath.row] valueForKey:@"id"];
        NSLog(@"%@",strid);
       // [CartypeTable setHidden:YES];
        [_txtCarType resignFirstResponder];
        [tabl reloadData];
    }
    else if(tableView==locationTbl)
    {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [_txtRestaurant resignFirstResponder];
        _txtRestaurant.text=[arrLocations objectAtIndex:indexPath.row];
        
        [locationTbl setHidden:YES];
       // _txtRest.hidden=NO;
        [self getCurentLocationwithtext:_txtRestaurant.text];
        
        [mapView setHidden:NO];     //   [mapView setHidden:NO];
        
    //    [mapView setHidden:NO];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [_txtRest resignFirstResponder];
        _txtRest.text=[arrLocations objectAtIndex:indexPath.row];
        
        [locationTbl2 setHidden:YES];
        [self getDesLocationwithtext:_txtRest.text];
        
        [mapView setHidden:NO];
    
    }
   
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == _txtRestaurant)
    {
        
         _desflag.hidden=YES;
        NSString *str=[_txtRestaurant.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSString *apiURLStr =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=geocode&location=%f,%f&radius=500&key=AIzaSyC3R8hg9HZgayqCocCmbqDth8-JEtlrtzs",str,core_latitude,core_longitude];
        
        // NSLog(@"apiURLStr %@",apiURLStr);
        
        NSString *sampleURL = [NSString stringWithContentsOfURL:[NSURL URLWithString:apiURLStr] encoding:NSUTF8StringEncoding error:nil];
        
        NSDictionary *dict;
        
        dict=[sampleURL JSONValue];
        // NSLog(@"dict %@",dict);
        
        arrLocations=[[dict valueForKey:@"predictions"]valueForKey:@"description"];
        
        // NSLog(@"arrLocations %@",arrLocations);
        
        if([arrLocations count]>0)
        {
            
            locationTbl.dataSource=self;
            locationTbl.delegate=self;
            [locationTbl reloadData];
            [locationTbl setHidden:NO];
        }
        
        else
        {
            [locationTbl setHidden:YES];
        }

    }
    else if (textField==_txtRest)
    {
        NSString *str=[_txtRest.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSString *apiURLStr =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=geocode&location=%f,%f&radius=500&key=AIzaSyC3R8hg9HZgayqCocCmbqDth8-JEtlrtzs",str,core_latitude,core_longitude];
        
        
        
        // NSLog(@"apiURLStr %@",apiURLStr);
        
        NSString *sampleURL = [NSString stringWithContentsOfURL:[NSURL URLWithString:apiURLStr] encoding:NSUTF8StringEncoding error:nil];
        
        NSDictionary *dict;
        
        dict=[sampleURL JSONValue];
        
        
        // NSLog(@"dict %@",dict);
        
        arrLocations=[[dict valueForKey:@"predictions"]valueForKey:@"description"];
        
        // NSLog(@"arrLocations %@",arrLocations);
        
        if([arrLocations count]>0)
        {
            
            locationTbl2.dataSource=self;
            locationTbl2.delegate=self;
            [locationTbl2 reloadData];
            [locationTbl2 setHidden:NO];
        }
        
        else
        {
            [locationTbl2 setHidden:YES];
        }

    
    
    }
    
    
    return YES;
}


-(void)getCurentLocationwithtext:(NSString*)text
{
    
    geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:text completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Fetch Gecodingaddress");
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
                if (currentLocationAddArr.count==1)
                {
                    strAdd=[currentLocationAddArr objectAtIndex:0];
                }
                
                else
                {
                    strAdd=[currentLocationAddArr objectAtIndex:0];
                    
                    strAdd1=[currentLocationAddArr objectAtIndex:1];
                }
                
            };
            
            
            latitude=coordinate.latitude;
            longitude=coordinate.longitude;
            [mapView removeAnnotations:mapView.annotations];
            [self drawMap];
             [self getDesLocationwithtext:_txtRest.text];
            
            
        }
        
    }];
}
-(void)getDesLocationwithtext:(NSString *)text
{
    
geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:text completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Fetch Gecodingaddress");
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
                if (currentLocationAddArr.count==1)
                {
                    strAdd=[currentLocationAddArr objectAtIndex:0];
                }
                
                else
                {
                    strAdd=[currentLocationAddArr objectAtIndex:0];
                    
                    strAdd1=[currentLocationAddArr objectAtIndex:1];
                }

//                if (currentLocationAddArr.count > 0)
//                {
//                    strAdd=[currentLocationAddArr objectAtIndex:0];
//                } else
//                {
//                            strAdd1=[currentLocationAddArr objectAtIndex:1];
//                }
                
            };
            
            
            latitude1=coordinate.latitude;
            longitude1=coordinate.longitude;
             [self.mapView removeOverlay:self.routeLine];
    
             [mapView removeAnnotations:mapView.annotations];

            [self drawMa];
            
             [self getCurentLocationwith:_txtRestaurant.text];
           
             [self.mapView removeOverlays:self.mapView.overlays];
            
//            CLLocationCoordinate2D coordinateArray[2];
//            coordinateArray[0] = CLLocationCoordinate2DMake(latitude, longitude);
//            coordinateArray[1] = CLLocationCoordinate2DMake(latitude1, longitude1);
//            
//            
//            self.routeLine = [MKPolyline polylineWithCoordinates:coordinateArray count:2];
//            [self.mapView setVisibleMapRect:[self.routeLine boundingMapRect]]; //If you want the route to be visible
//            
//            [self.mapView addOverlay:self.routeLine];

        }
        
    }];
}

-(void)getCurentLocationwith:(NSString*)text
{
    
  geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:text completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Fetch Gecodingaddress");
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
                
                if (currentLocationAddArr.count==1)
                {
                    strAdd=[currentLocationAddArr objectAtIndex:0];
                }
                else
                {
                strAdd=[currentLocationAddArr objectAtIndex:0];
                
                strAdd1=[currentLocationAddArr objectAtIndex:1];
                }
                
            };
            latitude=coordinate.latitude;
            longitude=coordinate.longitude;
            [self drawMap];
            
        //    [self.mapView removeOverlays:self.mapView.overlays];
            

        }
        
    }];
}


-(void)drawMap
{
    MKCoordinateRegion region;
    CLLocationCoordinate2D location;
    location.latitude=latitude;
    location.longitude=longitude;
    
    region.center=location;
    MKCoordinateSpan span1;
    span1.latitudeDelta=5;
    span1.longitudeDelta=5;
    region.span=span1;
    [mapView setShowsUserLocation:NO];
    [mapView setRegion:region animated:YES];
    mapView.delegate=self;
    
    MyAnnotation *annotation=[[MyAnnotation alloc]initWithCoordinate:location title:strAdd subtitle:strAdd1];
    
    [mapView addAnnotation:annotation];
    [mapView reloadInputViews];
    
}

-(void)drawMa
{
    MKCoordinateRegion region;
    CLLocationCoordinate2D location;
    location.latitude=latitude1;
    location.longitude=longitude1;
    
    region.center=location;
    MKCoordinateSpan span1;
    span1.latitudeDelta=5;
    span1.longitudeDelta=5;
    region.span=span1;
    [mapView setShowsUserLocation:NO];
    [mapView setRegion:region animated:YES];
    mapView.delegate=self;
    
    MyAnnotation *annotation=[[MyAnnotation alloc]initWithCoordinate:location title:strAdd subtitle:strAdd1];
    
    [mapView addAnnotation:annotation];
    [mapView reloadInputViews];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView1 viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    // Try to dequeue an existing pin view first
    MKAnnotationView *annView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    annView.image=[UIImage imageNamed:@"pin.png"];
    annView.canShowCallout=YES;
    return annView;
    
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateStarting)
    {
        annotationView.dragState = MKAnnotationViewDragStateDragging;
    }
    else if (newState == MKAnnotationViewDragStateEnding || newState == MKAnnotationViewDragStateCanceling)
    {
        annotationView.dragState = MKAnnotationViewDragStateNone;
    }
}

- (CGPoint) convertCoordinate:(CLLocationCoordinate2D)coordinate

{
    
    MKMapPoint mapPoint = MKMapPointForCoordinate(coordinate);
    
    CGPoint toPos;
    
    CGFloat zoomFactor =  mapView.visibleMapRect.size.width / mapView.bounds.size.width;
    
    toPos.x = mapPoint.x/zoomFactor;
    
    toPos.y = mapPoint.y/zoomFactor;
    
    // CGPoint point = [mapView convertCoordinate:coordinate toPointToView:mapView];
    
    return toPos;
    
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



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    
    if (textField==_txtRestaurant)
    {
        const int movementDistance = -142; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
        
        _desflag.hidden=NO;
    }
    else if (textField==_txtRest)
    {
        const int movementDistance = -75; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }

}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    
    self.title = @"";
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Fare Estimate";
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
    
//    NSLog(@"***** login check details ******* %@", responseJSON);
    
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




@end
