//
//  UpcomingdetailsViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 21/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "UpcomingdetailsViewController.h"
#import "UpcomingCancelViewController.h"
#import "DejalActivityView.h"
#import "GetUsHere.pch"

@interface UpcomingdetailsViewController ()

@end

@implementation UpcomingdetailsViewController
@synthesize strpickup,strDestination,strtime,strdate,strstatus,strtripid,mapView;

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrdriverlocation=[[NSMutableArray alloc]init];
    self.navigationItem.title=@"Details";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
     _lblpickup.text=strpickup;
     _lbldes.text=strDestination;
     _lblstatus.text=strstatus;
    
    
    NSString *varyingString1 =strdate;
    NSString *varyingString2 =strtime;
    NSString *str = [NSString stringWithFormat: @"%@  %@", varyingString1, varyingString2];
    
    _lbldate.text=str;
    labid.text=strtripid;
    
    [[NSUserDefaults standardUserDefaults]setObject:strtripid forKey:@"tripid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    _Cancelridebut.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    //[self getDesLocationwithtext:_lbldes.text];
    count=0;
    
    if ([_lblstatus.text isEqualToString:@"confirmed"])
    {
        [self performSelector:@selector(next:) withObject:self afterDelay:5.0];
    }
    else
    {
        [self getCurentLocationwithtext:_lblpickup.text];
    }
}

-(void)next:(id)sender
{
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getBookingInfo]]];
    
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    
    [profile appendString:[NSString stringWithFormat:@"trip_id=%@", strtripid]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@", @"rider"]];
    
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
    
    
    
    NSLog(@"*****Driver location ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    arrdriverlocation =[[responseJSON valueForKey:@"data"]valueForKey:@"trip"];
        
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
      //  [mapView removeAnnotation]
        [mapView removeAnnotations:mapView.annotations];
        CLLocationCoordinate2D  ctrpoint;
        
        NSString *strlat= [NSString stringWithFormat:@"%@",[arrdriverlocation valueForKey:@"driver_current_lat"]];
        lat=[strlat doubleValue];
        
        NSString *strlong= [NSString stringWithFormat:@"%@",[arrdriverlocation valueForKey:@"driver_current_lng"]];
        longi=[strlong doubleValue];
        
        
        ctrpoint.latitude=lat;
        ctrpoint.longitude =longi;
        
        MyAnnotation *annotation=[[MyAnnotation alloc]initWithCoordinate:ctrpoint title:strAdd subtitle:strAdd1];
        [mapView addAnnotation:annotation];
        
        
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
        
        
       [self performSelector:@selector(nex) withObject:self afterDelay:10.0];
        
    }
}

-(void)nex
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getBookingInfo]]];
    
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    
    [profile appendString:[NSString stringWithFormat:@"trip_id=%@", strtripid]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@", @"rider"]];
    
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
    
    
    
    NSLog(@"*****Driver location ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    arrdriverlocation =[[responseJSON valueForKey:@"data"]valueForKey:@"trip"];
    
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        //  [mapView removeAnnotation]
        //  [mapView removeAnnotations:mapView.annotations];
        CLLocationCoordinate2D  ctrpoint;
        
        NSString *strlat= [NSString stringWithFormat:@"%@",[arrdriverlocation valueForKey:@"driver_current_lat"]];
        lat=[strlat doubleValue];
        
        NSString *strlong= [NSString stringWithFormat:@"%@",[arrdriverlocation valueForKey:@"driver_current_lng"]];
        longi=[strlong doubleValue];
        
        
        ctrpoint.latitude=lat;
        ctrpoint.longitude =longi;
        
        MyAnnotation *annotation=[[MyAnnotation alloc]initWithCoordinate:ctrpoint title:strAdd subtitle:strAdd1];
        [mapView addAnnotation:annotation];
        
        
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
        
        
    [self performSelector:@selector(ne) withObject:self afterDelay:5.0];
        
    }
}

-(void)ne
{
    if (count==0) {
        [self nex];
    }
    else if (count==1)
    {
        [self rety];
    
    }
}
-(void)rety
{
    return;
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
        
        // [self getCurentLocation:locatedAt];
     }
     ];
}

-(void)getCurentLocation:(NSString*)text
{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
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
                strAdd=[currentLocationAddArr objectAtIndex:0];
                
                strAdd1=[currentLocationAddArr objectAtIndex:1];
                
            };
            latitude=coordinate.latitude;
            longitude=coordinate.longitude;
           // [self drawMap];
        }
        
    }];
}

-(void)getCurentLocationwithtext:(NSString*)text
{
    
   CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
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
                strAdd=[currentLocationAddArr objectAtIndex:0];
                
                strAdd1=[currentLocationAddArr objectAtIndex:1];
                
            };
            latitude=coordinate.latitude;
            longitude=coordinate.longitude;
            [self drawMap];
            [self getDesLocationwithtext:_lbldes.text];
        }
        
    }];
}
-(void)getDesLocationwithtext:(NSString *)text
{
    
   CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:text completionHandler:^(NSArray *placemarks, NSError *error) {
       
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
            [self drawMa];
            
            
            CLLocationCoordinate2D coordinateArray[2];
            coordinateArray[0] = CLLocationCoordinate2DMake(latitude, longitude);
            coordinateArray[1] = CLLocationCoordinate2DMake(latitude1, longitude1);
            
            
            self.routeLine = [MKPolyline polylineWithCoordinates:coordinateArray count:2];
            [self.mapView setVisibleMapRect:[self.routeLine boundingMapRect]]; //If you want the route to be visible
            
            [self.mapView addOverlay:self.routeLine];
        }
        
    }];
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if(overlay == self.routeLine)
    {
        if(nil == self.routeLineView)
        {
//            self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
//            self.routeLineView.fillColor = [UIColor redColor];
//            self.routeLineView.strokeColor = [UIColor redColor];
//            self.routeLineView.lineWidth = 5;
            
        }
        
        return self.routeLineView;
    }
    
    return nil;
}


-(void)drawMap
{
    CLLocationCoordinate2D location;
    location.latitude=latitude;
    location.longitude=longitude;
    
    region.center=location;
    MKCoordinateSpan span1;
    span1.latitudeDelta=0.03;
    span1.longitudeDelta=0.03;
    region.span=span1;
    [mapView setShowsUserLocation:YES];
    [mapView setRegion:region animated:YES];
    mapView.delegate=self;
    
    MyAnnotation *annotation=[[MyAnnotation alloc]initWithCoordinate:location title:strAdd subtitle:strAdd1];
    
    [mapView addAnnotation:annotation];
    [mapView reloadInputViews];
}

-(void)drawMa
{
    CLLocationCoordinate2D location;
    location.latitude=latitude1;
    location.longitude=longitude1;
    
    region.center=location;
    MKCoordinateSpan span1;
    span1.latitudeDelta=0.03;
    span1.longitudeDelta=0.03;
    region.span=span1;
    [mapView setShowsUserLocation:YES];
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
    annView.image=[UIImage imageNamed:@"carjam.png"];
    annView.canShowCallout=YES;
    return annView;
    
}

- (IBAction)CancelrideClicked:(id)sender
{
    UpcomingCancelViewController *cancel=[self.storyboard instantiateViewControllerWithIdentifier:@"UpcomingCancelViewController"];
    [self.navigationController pushViewController:cancel animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    self.title = @"";
    count=1;
    [self ne];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Details";
    
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
