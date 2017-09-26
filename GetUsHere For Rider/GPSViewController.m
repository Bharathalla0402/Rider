//
//  GPSViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 05/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "GPSViewController.h"
#import "GetUsHere.pch"
#import "SidebarViewController.h"
#import "SplachscreenViewController.h"


#define setTurqoiseColor [UIColor whiteColor]

@interface GPSViewController ()

@end

@implementation GPSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Driver is coming to you";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPress)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    locationManager = [[CLLocationManager alloc] init];
    [_mapView_ clear];
     locationManager.delegate = self;
    _mapView_.myLocationEnabled = YES;
    _mapView_.delegate=self;
    [locationManager startUpdatingLocation];
    
    // [self locationManager];
    latitude = locationManager.location.coordinate.latitude;
    longitude = locationManager.location.coordinate.longitude;

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                                longitude:longitude
                                                                     zoom:17];
    self.mapView_.camera=camera;
    marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
    marker.map = _mapView_;
    
    
    arrpointlat=[[NSMutableArray alloc]init];
    arrpointlong=[[NSMutableArray alloc]init];
    
    [self performSelector:@selector(NavigateButtonClicked:) withObject:self afterDelay:0.1];
    
//    arrdriverdetails=[[NSMutableArray alloc]init];
//    arrdriverdetails=[[NSUserDefaults standardUserDefaults]objectForKey:@"driverlocdetails"];
   
}


-(void)barButtonBackPress
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size
{
    //avoid redundant drawing
    if (CGSizeEqualToSize(originalImage.size, size))
    {
        return originalImage;
    }
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //draw
    [originalImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

- (void)addBackButtonWithImageName:(NSString *)imageName
{
    // init yor custom button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40); // custom frame
    [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    backButton.tintColor=[UIColor whiteColor];
    [backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    // set left barButtonItem to backButton
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)backButtonPressed
{
    SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:side animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
//    NSString *urlString = [NSString stringWithFormat:
//                           @"%@?origin=%f,%f&destination=%@,%@&sensor=true&key=%@",
//                           @"https://maps.googleapis.com/maps/api/directions/json",
//                           _mapView_.myLocation.coordinate.latitude,
//                           _mapView_.myLocation.coordinate.longitude,
//                           @"",
//                           @"",
//                           @"AIzaSyAIyff4QNwE1x_0KZ7xVZhMQUMNX_VGEd4"];
//    NSURL *directionsURL = [NSURL URLWithString:urlString];
//    
//    
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:directionsURL];
//    [request startSynchronous];
//    NSError *error = [request error];
//    if (!error) {
//        NSString *response = [request responseString];
//        NSLog(@"%@",response);
//        NSDictionary *json =[NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableContainers error:&error];
//        GMSPath *path =[GMSPath pathFromEncodedPath:json[@"routes"][0][@"overview_polyline"][@"points"]];
//        GMSPolyline *singleLine = [GMSPolyline polylineWithPath:path];
//        singleLine.strokeWidth = 7;
//        singleLine.strokeColor = [UIColor greenColor];
//        singleLine.map = self.mapView_;
//    }
//    else NSLog(@"%@",[request error]);
}


- (void)NavigateButtonClicked:(id)sender
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getBookingInfo]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    
    
    [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"tripid"]]];
    
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
    
 //   NSLog(@"*****Near car details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    sampleImgView.image=nil;
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
       
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
       
        
         arrdriverdetails=[[responseJSON valueForKey:@"data"] valueForKey:@"trip"];
        
        double lati = [[arrdriverdetails valueForKey:@"driver_current_lat"]doubleValue];
        double longit = [[arrdriverdetails valueForKey:@"driver_current_lng"]doubleValue];
        
        marker1=[[GMSMarker alloc]init];
        marker1.position=CLLocationCoordinate2DMake(lati, longit);
        marker1.icon=[UIImage imageNamed:@"carjam.png"];
        marker1.icon = [self image:marker1.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        marker1.map=_mapView_;
        
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel3) object:nil];
        [self performSelector:@selector(numnel3) withObject:nil afterDelay:2.0];
    }
}


- (void)NavigateButtonClicked1:(id)sender
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getBookingInfo]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    
    
    [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"tripid"]]];
    
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@", @"rider"]];
    
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRespon1:data];
                                   
                               }
                           }];
    
}


-(void)parseJSONRespon1:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
//    NSLog(@"***** Driver location ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
   
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
       
        arrdriverdetails=[[responseJSON valueForKey:@"data"] valueForKey:@"trip"];
        sampleImgView.image=nil;
       
        marker1.map=nil;
        
        [arrpointlat removeAllObjects];
        [arrpointlong removeAllObjects];
        
        double lati = [[arrdriverdetails valueForKey:@"driver_current_lat"]doubleValue];
        double longit = [[arrdriverdetails valueForKey:@"driver_current_lng"]doubleValue];
        
        double latiold = [[arrdriverdetails valueForKey:@"driver_old_lat"]doubleValue];
        double longitold = [[arrdriverdetails valueForKey:@"driver_old_lng"]doubleValue];
        
        currLocation = [[CLLocation alloc]initWithLatitude:lati longitude:longit];
        prevCurrLocation = [[CLLocation alloc]initWithLatitude:latiold longitude:longitold];
        
        
        
        sampleImgView = [[UIImageView alloc]init];
        sampleImgView.center = _mapView_.center;
        sampleImgView.backgroundColor = [UIColor clearColor];
        [_mapView_ addSubview:sampleImgView];
        
        CGPoint ImgCenter = sampleImgView.center;
        CGRect frameRect = sampleImgView.frame;
        
        frameRect.size.width = 30.0f;
        frameRect.size.height = 30.0f;
       
        
        sampleImgView.center = ImgCenter;
        sampleImgView.frame = frameRect;
        
        NSString *str=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", latiold,  longitold, lati, longit];
        
        NSURL *url=[[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        NSArray* latestRoutes = [json objectForKey:@"routes"];
        
        NSString *points=[[[latestRoutes objectAtIndex:0] objectForKey:@"overview_polyline"] objectForKey:@"points"];
        
        @try {
            // TODO: better parsing. Regular expression?
            
            temp= [self decodePolyLine:[points mutableCopy]];
            
            GMSMutablePath *path = [GMSMutablePath path];
            
            for(int idx = 0; idx < [temp count]; idx++)
            {
                CLLocation *location=[temp objectAtIndex:idx];
                
                [path addCoordinate:location.coordinate];
                
            }
            // create the polyline based on the array of points.
//            GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//            
//            rectangle.strokeWidth=5.0;
//            
//            rectangle.map = _mapView_;
        }
        @catch (NSException * e)
        {
        
        }
        j=1;
        count=0;
        [self angle:sampleImgView];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel3) object:nil];
        [self performSelector:@selector(numnel3) withObject:nil afterDelay:18.0];
    }
}

-(void)numnel3
{
    if (count==0)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(NavigateButtonClicked1:) object:nil];
        [self performSelector:@selector(NavigateButtonClicked1:) withObject:nil afterDelay:2.0];
    }
    else if(count==1)
    {
        [self num];
    }
}

-(void)num
{
    return;
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
    count=1;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel3) object:nil];
    [self performSelector:@selector(numnel3) withObject:nil afterDelay:0.1];
}



-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded {
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
        NSNumber *latitude2 = [[NSNumber alloc] initWithFloat:lattt * 1e-5] ;
        NSNumber *longitude2 = [[NSNumber alloc] initWithFloat:lng * 1e-5] ;
        printf("[%f,", [latitude2 doubleValue]);
        printf("%f]", [longitude2 doubleValue]);
        
        [arrpointlat addObject:latitude2];
        [arrpointlong addObject:longitude2];
        
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude2 floatValue] longitude:[longitude2 floatValue]] ;
        [array addObject:loc];
    }
   // NSLog(@"array:%@",arrpointlat);
   // NSLog(@"array:%@",arrpointlong);
    return array;
}

-(void)angle:(UIImageView *)sender
{
    if (j<arrpointlat.count)
    {
        [sampleImgView removeFromSuperview];
        double lati = [[arrpointlat objectAtIndex:j-1] doubleValue];
        double longit = [[arrpointlong objectAtIndex:j-1] doubleValue];
        
        double lati1 = [[arrpointlat objectAtIndex:j] doubleValue];
        double longit1 = [[arrpointlong objectAtIndex:j] doubleValue];
        
        prevCurrLocation = [[CLLocation alloc]initWithLatitude:lati longitude:longit];
        currLocation = [[CLLocation alloc]initWithLatitude:lati1 longitude:longit1];
        
        
        sampleImgView = [[UIImageView alloc]init];
        sampleImgView.center = _mapView_.center;
        sampleImgView.backgroundColor = [UIColor clearColor];
        [_mapView_ addSubview:sampleImgView];
        
        CGPoint ImgCenter = sampleImgView.center;
        CGRect frameRect = sampleImgView.frame;
        
        frameRect.size.width = 30.0f;
        frameRect.size.height = 30.0f;
        sampleImgView.image = [UIImage imageNamed:@"carjam.png"];         
        sampleImgView.center = ImgCenter;
        sampleImgView.frame = frameRect;
        
        sampleImgView.image = [UIImage imageNamed:@"carjam.png"];
        [sampleImgView setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(prevCurrLocation.coordinate.latitude, prevCurrLocation.coordinate.longitude)]];
        
        
        CGPoint anglepoint = [_mapView_.projection pointForCoordinate:currLocation.coordinate];
        
        CGPoint previousLocationPoint = [_mapView_.projection pointForCoordinate:prevCurrLocation.coordinate];
        
        CGFloat x1 = previousLocationPoint.x;
        CGFloat y1 = previousLocationPoint.y;
        
        CGFloat x2 = anglepoint.x;
        CGFloat y2 = anglepoint.y;
        
        CGFloat x3 = x1;
        CGFloat y3 = y2;
        
        CGFloat oppSide = sqrtf(((x2-x3)*(x2-x3)) + ((y2-y3)*(y2-y3)));
        CGFloat adjSide = sqrtf(((x1-x3)*(x1-x3)) + ((y1-y3)*(y1-y3)));
        
        CGFloat angle = atanf(oppSide/adjSide);
        // Quadrant Identifiaction
        if(x2 < previousLocationPoint.x)
        {
            angle = 0-angle;
        }
        
        
        if(y2 > previousLocationPoint.y)
        {
            angle = M_PI/2 + (M_PI/2 -angle);
        }
        
        
        if(!isnan(angle))
        {
            CGAffineTransform rotationTransform = CGAffineTransformIdentity;
            rotationTransform = CGAffineTransformMakeRotation(angle);
            sampleImgView.transform=rotationTransform;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation.coordinate.latitude, currLocation.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation = currLocation;
        }
        else{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation.coordinate.latitude, currLocation.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation = currLocation;
        }
        j++;
        // [self angle:sampleImgView];
        [self performSelector:@selector(angle:) withObject:self afterDelay:2.0];
    }
    else if (arrpointlat.count==1)
    {
        [sampleImgView removeFromSuperview];
        double lati = [[arrpointlat objectAtIndex:0] doubleValue];
        double longit = [[arrpointlong objectAtIndex:0] doubleValue];
        
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(lati, longit);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
         mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
    }
    
    else
    {
        sampleImgView.image=nil;
        
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(currLocation.coordinate.latitude, currLocation.coordinate.longitude);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
         mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
    }
}



-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Driver is coming to you";
    
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
