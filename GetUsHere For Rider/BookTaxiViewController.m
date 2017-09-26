//
//  BookTaxiViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 18/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "BookTaxiViewController.h"
#import "DejalActivityView.h"
#import "Alertview.h"
#import "AvailableCabsViewController.h"
#import "MVPlaceSearchTextField.h"
#import "BooklaterViewController.h"
#import "GetUsHere.pch"
#import "ConnectionManager.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>
#import "MVPopView.h"
#import "SWRevealViewController.h"
#import "SplachscreenViewController.h"
#import "Reachability.h"
#import "PickTextViewController.h"
#import "DesTextViewController.h"


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define CLCOORDINATES_EQUAL( coord1, coord2 ) (coord1.latitude == coord2.latitude && coord1.longitude == coord2.longitude)
typedef enum{
    
    buttontag1= 0,
    imageTAg = 100
    
}buttontag;


@interface BookTaxiViewController ()<CLLocationManagerDelegate,ConnectionmangerDelegate,GMSMapViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *DataArray;
    UIView *footerview;
    UIButton *wheelchairbutt;
    NSString *carID;
    NSString *strid;
    NSMutableDictionary *dictionary;
    UIScrollView *Scrollview;
    UIView *view;
    
    NSString *wheelchairfacility;
    
    GMSMarker *marker;
    float latitudeValue;
    float longitudeValue;
    NSArray *temp;

    CLLocationCoordinate2D previousSourcePoint;
    CLLocation *prevCurrLocation, *currLocation,*prevCurrLocation1, *currLocation1,*prevCurrLocation2, *currLocation2,*prevCurrLocation3, *currLocation3,*prevCurrLocation4, *currLocation4,*prevCurrLocation5, *currLocation5,*prevCurrLocation6, *currLocation6,*prevCurrLocation7, *currLocation7,*prevCurrLocation8, *currLocation8,*prevCurrLocation9, *currLocation9;

    float LatValue;
    float LongValue;
    UILabel *labelToShowCurrentRadiusValue;
    ConnectionManager *manager;
    GMSCameraPosition *lastCameraPosition;
    
    BOOL isClicked;
    UIButton *Btn;
    
    UIButton *ridenow;
    MVPlaceSearchTextField *_searchDropAddReff,*_searchDropAddReff1,*_searchDropAddReff2;
    
    UIView *popview;
    UIView *footerview2;
    UITextField *mvplacesearchpick;
       
}

@property (nonatomic, strong)MVPopView *popView;

@end

@implementation BookTaxiViewController
@synthesize catID;

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
static NSString * const KMapPlacesApiKey = @"AIzaSyAIyff4QNwE1x_0KZ7xVZhMQUMNX_VGEd4";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 //   _searchDropAddRef.delegate=self;
  //  _searchDropAddRef2.delegate=self;
    
    arrLocations=[[NSMutableArray alloc]init];
    
    ridenow=[[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    [ridenow setTitle:@"Ride Now" forState:UIControlStateNormal];
    ridenow.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    ridenow.tintColor=[UIColor whiteColor];
    [ridenow addTarget:self action:@selector(RequestNowClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_mapView_ addSubview:ridenow];
    
    
    _searchDropAddReff=[[MVPlaceSearchTextField alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 30)];
    _searchDropAddReff.hidden=YES;
    [_searchDropAddReff setBorderStyle:UITextBorderStyleRoundedRect];
    _searchDropAddReff.font=[UIFont systemFontOfSize:14];
    [_mapView_ addSubview:_searchDropAddReff];
    
  //  UIView *viewcon=[[UIView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 40)];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-128, self.view.frame.size.width-70, 80)];
    footerview.backgroundColor=[UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0];
    [self.view addSubview:footerview];

    wheelchairbutt=[[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width+3, self.view.frame.size.height-128, 67, 80)];
    wheelchairbutt.backgroundColor=[UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0];
    [wheelchairbutt addTarget:self action:@selector(wheelchairClicked) forControlEvents:UIControlEventTouchUpInside];
    [wheelchairbutt setImage:[UIImage imageNamed:@"wheelchair.png"] forState:UIControlStateNormal];
    // [wheelchairbutt setBackgroundImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateNormal];
    [self.view addSubview:wheelchairbutt];
    
    [self footerview];

    
    UIButton *pickupbutt=[[UIButton alloc]initWithFrame:CGRectMake(4, 3, self.view.frame.size.width-12, 40)];
    pickupbutt.backgroundColor=[UIColor clearColor];
    [pickupbutt addTarget:self action:@selector(pickupbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_viewcon addSubview:pickupbutt];
    
    UIButton *Desbutt=[[UIButton alloc]initWithFrame:CGRectMake(4, 45, self.view.frame.size.width-45, 40)];
    Desbutt.backgroundColor=[UIColor clearColor];
    [Desbutt addTarget:self action:@selector(DesbuttClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_viewcon addSubview:Desbutt];
    
    
    locationManager = [[CLLocationManager alloc] init];
    [self startLocationUpdates];
    latitude = locationManager.location.coordinate.latitude;
    longitude =locationManager.location.coordinate.longitude;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:19];
    //plotting the google map
   
    CGPoint point = _mapView_.center;
    GMSCameraUpdate *camera1 =[GMSCameraUpdate setTarget:[_mapView_.projection coordinateForPoint:point]];
    [_mapView_ animateWithCameraUpdate:camera1];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    _currentlocationbutt.backgroundColor=[UIColor whiteColor];
    
    _mapView_.padding = UIEdgeInsetsMake(0, 0, 30, 0);
    
    [_mapView_.settings setAllGesturesEnabled:NO];
    
    [_mapView_.settings setZoomGestures:YES];
    
    [_mapView_.settings setScrollGestures:YES];
    
    self.mapView_.myLocationEnabled=YES;
    
    //Compass
    
    _mapView_.settings.compassButton = YES;
    
    _mapView_.padding = UIEdgeInsetsMake (40, 0, 0, 0);
    
    [_mapView_ setMinZoom:0.0 maxZoom:19.0];
    
    for (id gestureRecognizer in _mapView_.gestureRecognizers){
        
        if (![gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]){
            
            [_mapView_ removeGestureRecognizer:gestureRecognizer];
            
        }if (![gestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]]){
            
            [_mapView_ removeGestureRecognizer:gestureRecognizer];
            
        }
        
    }
    _mapView_.settings.allowScrollGesturesDuringRotateOrZoom = NO;
    
    //    NSLog(@"Latitude : %f and Longitude: %f", latitude , longitude);
    //    NSString *currentLatLong = [NSString stringWithFormat:@"%f,%f",latitude,longitude];
    // [self getAddressFromLatLong:currentLatLong];
    
    _mapView_.delegate=self;

    
    
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    locationManager.delegate = self;
//    [locationManager startUpdatingLocation];
//    
//    latitude = locationManager.location.coordinate.latitude;
//    
//    longitude =locationManager.location.coordinate.longitude;
//    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:10];
//    
    self.mapView_.camera=camera;
    

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

- (void)startLocationUpdates
{
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
    }
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.activityType = CLActivityTypeFitness;
    
    // Movement threshold for new events.
    locationManager.distanceFilter = 10; // meters
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *location = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude]; //insert your coordinates
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.5];
    [CATransaction commit];
    
    [ceo reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error)
     {
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         NSLog(@"I am currently at %@",locatedAt);
         _searchDropAddRef.text=locatedAt;
       //  [self getLocationFromAddressString4:_searchDropAddRef.text];
         
     }
     ];
}


#pragma mark
#pragma mark -- View Will Appear


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
        [DejalBezelActivityView removeView];
   
    
    self.view.userInteractionEnabled=YES;
    
    [DataArray removeAllObjects];
    
    // Enable iOS 7 back gesture
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    [self.revealViewController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;

}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}



-(void)logincheckmethod
{

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




-(void)viewWillAppear:(BOOL)animated
{
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {

    self.title = @"Ping a Ride";
    [_mapView_ clear];
        
  
    
    [self logincheckmethod];
    count=0;
    j=1;
    i=0;
    k=0;
    cont=0;
        
        sampleImgView.image=nil;
        sampleImgView1.image=nil;
        sampleImgView2.image=nil;
        sampleImgView3.image=nil;
        sampleImgView4.image=nil;
        sampleImgView5.image=nil;
        sampleImgView6.image=nil;
        sampleImgView7.image=nil;
        sampleImgView8.image=nil;
        sampleImgView9.image=nil;
    
    isClicked=NO;
    wheelchairfacility=@"0";
    self.navigationItem.title=@"Ping a Ride";
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;

  
    Btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setFrame:CGRectMake(0.0f,0.0f,30.0f,30.0f)];
    [Btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"fm.png"]]  forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(customBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:Btn];
    [self.navigationItem setRightBarButtonItem:addButton];

    
    _popView = [[MVPopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width+10, 120)];
    _popView.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-(self.view.frame.size.width/2),7,self.view.frame.size.width,30)];
    [btn addTarget:self action:@selector(hideBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Male Driver" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_popView addSubview:btn];
    
    UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake(0, 41, self.view.frame.size.width, 2)];
    [la1 setBackgroundColor:[UIColor blackColor]];
    [_popView addSubview:la1];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-(self.view.frame.size.width/2),45,self.view.frame.size.width,30)];
    [btn1 addTarget:self action:@selector(hideBtnTapped1) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"Female Driver" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_popView addSubview:btn1];
    
    UILabel *la2=[[UILabel alloc]initWithFrame:CGRectMake(0, 78, self.view.frame.size.width, 2)];
    [la2 setBackgroundColor:[UIColor blackColor]];
    [_popView addSubview:la2];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-(self.view.frame.size.width/2),85,self.view.frame.size.width,30)];
    [btn2 addTarget:self action:@selector(hideBtnTapped2) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"Any Driver" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_popView addSubview:btn2];

    strgender=@"B";
    
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    locationManager.delegate = self;
//    [locationManager startUpdatingLocation];
//    
//    latitude = locationManager.location.coordinate.latitude;
//    
//    longitude =locationManager.location.coordinate.longitude;
//    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:10];
//    
//    self.mapView_.camera=camera;
//    
     marker = [[GMSMarker alloc] init];
    
    markerimage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-25, self.view.frame.size.height/2-25, 50, 50)];
    markerimage.image = [UIImage imageNamed:@"bigpin.png"];
    markerimage.backgroundColor = [UIColor clearColor];
    [_mapView_ addSubview:markerimage];
   
    

    
//    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
//  
//    
//    marker.appearAnimation = kGMSMarkerAnimationPop;
//    
//    marker.icon = [UIImage imageNamed:@"newpin.png"];
//    
//    CGPoint point = _mapView_.center;
//    
//    GMSCameraUpdate *camera1 =[GMSCameraUpdate setTarget:[_mapView_.projection coordinateForPoint:point]];
//    
//    [_mapView_ animateWithCameraUpdate:camera1];
//    
//    marker.map = _mapView_;
    
   // _mapView_.settings.myLocationButton = YES;
    
     
    arrpointsoflalong=[[NSMutableDictionary alloc]init];
    
    arrpointlat=[[NSMutableArray alloc]init];
    arrpointlong=[[NSMutableArray alloc]init];
    
    arrpointlat1=[[NSMutableArray alloc]init];
    arrpointlong1=[[NSMutableArray alloc]init];
    
    arrpointlat2=[[NSMutableArray alloc]init];
    arrpointlong2=[[NSMutableArray alloc]init];
    
    arrpointlat3=[[NSMutableArray alloc]init];
    arrpointlong3=[[NSMutableArray alloc]init];
    
    arrpointlat4=[[NSMutableArray alloc]init];
    arrpointlong4=[[NSMutableArray alloc]init];
    
    arrpointlat5=[[NSMutableArray alloc]init];
    arrpointlong5=[[NSMutableArray alloc]init];
    
    arrpointlat6=[[NSMutableArray alloc]init];
    arrpointlong6=[[NSMutableArray alloc]init];
    
    arrpointlat7=[[NSMutableArray alloc]init];
    arrpointlong7=[[NSMutableArray alloc]init];
    
    arrpointlat8=[[NSMutableArray alloc]init];
    arrpointlong8=[[NSMutableArray alloc]init];
    
    arrpointlat9=[[NSMutableArray alloc]init];
    arrpointlong9=[[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSMutableString* profile = [NSMutableString string];
    [profile appendString:[NSString stringWithFormat:@"category_id=%@", catID]];
    

        
      
    arrnearcardetails=[[NSMutableArray alloc]init];
    arrlocationscarslat=[[NSMutableArray alloc]init];
    arrlocationscarslog=[[NSMutableArray alloc]init];
    arrlatlong=[[NSMutableDictionary alloc]init];
    
    
    _requestnowbutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _bookbutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _viewcon.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    _searchDropAddRef.placeSearchDelegate                 = self;
    
    _searchDropAddRef.strApiKey                           = KMapPlacesApiKey;
    
    _searchDropAddRef.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    
    _searchDropAddRef.autoCompleteShouldHideOnSelection   = YES;
    
    _searchDropAddRef.maximumNumberOfAutoCompleteRows     = 5;
    
    
    _searchDropAddRef2.placeSearchDelegate                 = self;
    
    _searchDropAddRef2.strApiKey                           = KMapPlacesApiKey;
    
    _searchDropAddRef2.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    
    _searchDropAddRef2.autoCompleteShouldHideOnSelection   = YES;
    
    _searchDropAddRef2.maximumNumberOfAutoCompleteRows     = 5;
        
        
    _searchDropAddReff.placeSearchDelegate                 = self;
    
    _searchDropAddReff.strApiKey                           = KMapPlacesApiKey;
        
    _searchDropAddReff.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
        
    _searchDropAddReff.autoCompleteShouldHideOnSelection   = YES;
        
    _searchDropAddReff.maximumNumberOfAutoCompleteRows     = 5;
        
        
    _searchDropAddReff1.placeSearchDelegate                 = self;
        
    _searchDropAddReff1.strApiKey                           = KMapPlacesApiKey;
        
    _searchDropAddReff1.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
        
    _searchDropAddReff1.autoCompleteShouldHideOnSelection   = YES;
        
    _searchDropAddReff1.maximumNumberOfAutoCompleteRows     = 5;


    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    [self PostdateToServerwithParameters:profile andApiExtension:getcarTypes];
    
     [self performSelector:@selector(firstne:) withObject:nil afterDelay:5.0];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(anymethod:)
                                                     name: @"anyname"
                                                   object: nil];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(anymethod2:)
                                                     name: @"anynamedes"
                                                   object: nil];
        
       
    
}
}


- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture
{
   

}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
//    CGRect newFrame = self.viewcon.frame;
//    newFrame.origin.x=0;
//    newFrame.origin.y=64;
//    [self.viewcon setFrame:newFrame];
//    
//    _requestnowbutt.hidden=NO;
//    footerview.hidden=NO;
//    wheelchairbutt.hidden=NO;
//    self.navigationController.navigationBar.hidden=NO;
//    ridenow.hidden=NO;
//    _viewcon.hidden=NO;
//    _searchDropAddReff.hidden=YES;
}


- (void)mapView:(GMSMapView *)pMapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    
    NSString *strcheck=[[NSUserDefaults standardUserDefaults]objectForKey:@"Notification"];
    
    if ([strcheck isEqualToString:@"YES"])
    {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Notification"];
    }
    else
    {
    
    
    _mapView_.delegate = self;
    
    /* move draggable pin */
    
    if (marker)
    {
       
        // stick it on map and start dragging from there..
        
        if (lastCameraPosition == nil) lastCameraPosition = position;
        
        latitude = position.target.latitude;
        
        longitude = position.target.longitude;
        
        NSString *str=[[NSUserDefaults standardUserDefaults]objectForKey:@"lati"];
        latitudet=[str floatValue];
        
        NSString *strw=[[NSUserDefaults standardUserDefaults]objectForKey:@"longi"];
        longituden=[strw floatValue];

        CLLocationCoordinate2D resultingCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
        CLLocationCoordinate2D expectedCoordinate = CLLocationCoordinate2DMake(latitudet, longituden);
       
        
        if(CLCOORDINATES_EQUAL( resultingCoordinate, expectedCoordinate)) {
            NSLog(@"equal");
            
        } else {
            _requestnowbutt.hidden=YES;
            footerview.hidden=YES;
            wheelchairbutt.hidden=YES;
            self.navigationController.navigationBar.hidden=YES;
            ridenow.hidden=YES;
            _viewcon.hidden=YES;
            _searchDropAddReff.hidden=NO;
        }
        
        
        [[NSUserDefaults standardUserDefaults]setFloat:latitude forKey:@"lati"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setFloat:longitude forKey:@"longi"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        lastCameraPosition = position;
        
        CLLocationCoordinate2D addressCoordinates = CLLocationCoordinate2DMake(latitude,longitude);
        
        GMSGeocoder* coder = [[GMSGeocoder alloc] init];
        
        self.searchDropAddRef.text = @"fetching address...";
        _searchDropAddReff.text = @"fetching address...";
        
        [coder reverseGeocodeCoordinate:addressCoordinates completionHandler:^(GMSReverseGeocodeResponse *results, NSError *error)
         {
            
            if (error)
            {
                
                NSLog(@"Error %@", error.description);
                
            }
            else {
                
                GMSAddress* address = [results firstResult];
                
                NSArray *arr = [address valueForKey:@"lines"];
                
                NSString *str1p = [NSString stringWithFormat:@"%lu",(unsigned long)[arr count]];
                
               
                
                if ([str1p isEqualToString:@"0"])
                {
                    self.searchDropAddRef.text = @"";
                    _searchDropAddReff.text = @"";
                    
                    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel) object:nil];
                    [self performSelector:@selector(numnel) withObject:nil afterDelay:1.0];
                }
                
                else if ([str1p isEqualToString:@"1"])
                {
                    
                    NSString *str22 = [arr objectAtIndex:0];
                    
                    self.searchDropAddRef.text = str22;
                    _searchDropAddReff.text = str22;
                    
                    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel) object:nil];
                    [self performSelector:@selector(numnel) withObject:nil afterDelay:1.0];
                    
                }
                
                else if ([str1p isEqualToString:@"2"]) {
                    
                    NSString *str22 = [arr objectAtIndex:0];
                    
                    NSString *str3 = [arr objectAtIndex:1];
                    
                    self.searchDropAddRef.text = [NSString stringWithFormat:@"%@,%@",str22,str3];
                    _searchDropAddReff.text = [NSString stringWithFormat:@"%@,%@",str22,str3];
                    
                    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel) object:nil];
                    [self performSelector:@selector(numnel) withObject:nil afterDelay:1.0];

                }
                
            }
            
        }];
        
    }
    }
    
  //  marker.map = _mapView_;
}


- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position
{
   // lastCameraPosition = nil; // reset pin moving, no ice skating pins ;)
    
    CGRect newFrame = self.viewcon.frame;
    newFrame.origin.x=0;
    newFrame.origin.y=64;
    [self.viewcon setFrame:newFrame];
    
    _requestnowbutt.hidden=NO;
    footerview.hidden=NO;
    wheelchairbutt.hidden=NO;
    self.navigationController.navigationBar.hidden=NO;
    ridenow.hidden=NO;
    _viewcon.hidden=NO;
    _searchDropAddReff.hidden=YES;
}



-(void)customBtnPressed
{
    [_popView showInView:self.view];
}


- (void)hideBtnTapped
{
    strgender=@"m";
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel) object:nil];
    [self performSelector:@selector(numnel) withObject:nil afterDelay:0.1];
    [Btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"m.png"]]  forState:UIControlStateNormal];
    [_popView dismiss];
}

- (void)hideBtnTapped1
{
    strgender=@"f";
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel) object:nil];
    [self performSelector:@selector(numnel) withObject:nil afterDelay:0.1];
    [Btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"f.png"]]  forState:UIControlStateNormal];
    [_popView dismiss];
}

- (void)hideBtnTapped2
{
    strgender=@"B";
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel) object:nil];
    [self performSelector:@selector(numnel) withObject:nil afterDelay:0.1];
    [Btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"fm.png"]]  forState:UIControlStateNormal];
    [_popView dismiss];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)wheelchairClicked
{
    if (isClicked==YES)
    {
      //  [wheelchairbutt setBackgroundImage:[UIImage imageNamed:@"wheelchair.png"] forState:UIControlStateNormal];
        
        isClicked=NO;
        wheelchairfacility=@"0";
         wheelchairbutt.backgroundColor=[UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0];
        
        NSString *message =@"With and without Wheel chair facility cars selected";
        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
        [toast show];
        int duration = 2; // in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel) object:nil];
        [self performSelector:@selector(numnel) withObject:nil afterDelay:2.0];
    }
    else if(isClicked==NO)
    {
     //   [wheelchairbutt setBackgroundImage:[UIImage imageNamed:@"wheelchair.png"] forState:UIControlStateNormal];
       
        wheelchairbutt.backgroundColor=[UIColor blueColor];
        isClicked=YES;
        
        wheelchairfacility=@"1";
        
        NSString *message =@"Wheel chair facility cars selected";
        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
        [toast show];
        int duration = 2; // in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });

        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel) object:nil];
        [self performSelector:@selector(numnel) withObject:nil afterDelay:2.0];
    }
    
}


-(void)PostdateToServerwithParameters:(NSMutableString *)parameters andApiExtension:(NSString *)ext
{
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {

    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,ext]]];
    request.HTTPMethod = @"POST";
    request.HTTPBody  = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                                   [DejalBezelActivityView removeViewAnimated:YES];
                               } else {
                                   [self parseJSONResponse:data];
                                   [DejalBezelActivityView removeViewAnimated:YES];
                               }
                           }];
    }
    
}



-(void)parseJSONResponse:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
   // NSLog(@"*****Cars types ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    sampleImgView.image=nil;
    sampleImgView1.image=nil;
    sampleImgView2.image=nil;
    sampleImgView3.image=nil;
    sampleImgView4.image=nil;
    sampleImgView5.image=nil;
    sampleImgView6.image=nil;
    sampleImgView7.image=nil;
    sampleImgView8.image=nil;
    sampleImgView9.image=nil;
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        DataArray=[NSMutableArray array];
        [DataArray addObjectsFromArray:[responseJSON valueForKey:@"data"]];
        carID =[[DataArray objectAtIndex:0] valueForKey:@"name"];
        strid=[NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:0] valueForKey:@"id"]];
        [[NSUserDefaults standardUserDefaults] setObject:carID forKey:@"Name"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:strid forKey:@"idd"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self footerview];
    }
}

-(void)footerview
{
    int x=0;
    
    Scrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-71, 80)];
    Scrollview.contentSize=CGSizeMake((DataArray.count)*((self.view.frame.size.width-71)/3), 80);
    Scrollview.showsHorizontalScrollIndicator=NO;
    Scrollview.scrollEnabled=YES;
    Scrollview.userInteractionEnabled=YES;
    
    button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    
    for (i=0; i<DataArray.count; i++)
    {
        UILabel *lblrate=[[UILabel alloc] initWithFrame:CGRectMake(x+8, 2, 80, 20)];
        lblrate.text=[[DataArray objectAtIndex:i] valueForKey:@"rate"];
        lblrate.textColor=[UIColor whiteColor];
        lblrate.font=[UIFont systemFontOfSize:10];
        [Scrollview addSubview:lblrate];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.selected = !i;
        btnSelected = btn.selected?btn:btnSelected;
        btn.frame = CGRectMake(x+10, lblrate.frame.size.height+2,40, 40);
        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-white.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"car-cat-voilet.png"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(butonclicked:) forControlEvents:UIControlEventTouchUpInside];
        [Scrollview addSubview:btn];
        
        UILabel *lblname=[[UILabel alloc] initWithFrame:CGRectMake(x+5, btn.frame.size.height+16, 50, 30)];
        lblname.text=[[DataArray objectAtIndex:i] valueForKey:@"name"];
        lblname.textColor=[UIColor whiteColor];
        lblname.font=[UIFont systemFontOfSize:10];
        lblname.textAlignment = NSTextAlignmentCenter;
        [Scrollview addSubview:lblname];
        
        x+=btn.frame.size.width+btn.frame.size.height;
    }
    
    [footerview addSubview:Scrollview];
}

-(void)firstne:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,nearCars]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"car_type=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"idd"]]];
    [profile appendString:[NSString stringWithFormat:@"&latitude=%f",latitude]];
    [profile appendString:[NSString stringWithFormat:@"&longitude=%f",longitude]];
    [profile appendString:[NSString stringWithFormat:@"&gender=%@",strgender]];
    [profile appendString:[NSString stringWithFormat:@"&wheel_chair=%@",wheelchairfacility]];
    
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
}


-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
    count=1;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel) object:nil];
    [self performSelector:@selector(numnel) withObject:nil afterDelay:0.1];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel2) object:nil];
    [self performSelector:@selector(numnel2) withObject:nil afterDelay:0.1];
}


#pragma mark
#pragma mark -- getAddressFromLatLong


-(NSString*)getAddressFromLatLong : (NSString *)latLng
{
    NSString *esc_addr =  [latLng stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@&sensor=true", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    NSMutableDictionary *data = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding]options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *dataArray = (NSMutableArray *)[data valueForKey:@"results" ];
    if (dataArray.count == 0)
    {
        NSString *message =@"Please enter a valid Address";
        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
        [toast show];
        int duration = 1; // in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });
        

    }
    else
    {
        for (id firstTime in dataArray) {
            NSString *jsonStr1 = [firstTime valueForKey:@"formatted_address"];
            _searchDropAddRef.text=jsonStr1;
           // [self getLocationFromAddressString6:_searchDropAddRef.text];
            return jsonStr1;
        }
    }
    return nil;
}



#pragma mark
#pragma mark -- RequestNow Clicked



- (IBAction)RequestNowClicked:(id)sender
{
    count=1;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel) object:nil];
    [self performSelector:@selector(numnel) withObject:nil afterDelay:0.1];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel2) object:nil];
    [self performSelector:@selector(numnel2) withObject:nil afterDelay:0.1];
    
//    [self numnel];
//    [self numnel2];
    
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)
    {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }
    else
    {
    
    if (_searchDropAddRef.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please select source location" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    else if (_searchDropAddRef2.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please select Destination location" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    else if (arrnearcardetails.count==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"No Cars available for the selected car type.Please select another car type" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else
    {
        self.view.userInteractionEnabled=NO;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,requestnow]]];
//        
//        request.HTTPMethod = @"POST";
//        
//        NSMutableString* profile = [NSMutableString string];
//        
//        
//        [profile appendString:[NSString stringWithFormat:@"car_type=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"idd"]]];
//        [profile appendString:[NSString stringWithFormat:@"&latitude=%f",[[NSUserDefaults standardUserDefaults]floatForKey:@"lati"]]];
//        [profile appendString:[NSString stringWithFormat:@"&longitude=%f",[[NSUserDefaults standardUserDefaults]floatForKey:@"longi"]]];
//        [profile appendString:[NSString stringWithFormat:@"&dest_lat=%f",[[NSUserDefaults standardUserDefaults]floatForKey:@"lati1"]]];
//        [profile appendString:[NSString stringWithFormat:@"&dest_lng=%f",[[NSUserDefaults standardUserDefaults]floatForKey:@"longi1"]]];
//        
//        [profile appendString:[NSString stringWithFormat:@"&gender=%@",strgender]];
//        [profile appendString:[NSString stringWithFormat:@"&wheel_chair=%@",wheelchairfacility]];
//        
//        
//        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
//        
//        [NSURLConnection sendAsynchronousRequest:request
//                                           queue:[NSOperationQueue mainQueue]
//                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                                   if (error) {
//                                       // Handle error
//                                       //[self handleError:error];
//                                   } else {
//                                       [self parsdate:data];
//                                   }
//                               }];
//        
        
        NSString *post = [NSString stringWithFormat:@"car_type=%@&latitude=%f&longitude=%f&dest_lat=%f&dest_lng=%f&gender=%@&wheel_chair=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"idd"], [[NSUserDefaults standardUserDefaults]floatForKey:@"lati"],[[NSUserDefaults standardUserDefaults]floatForKey:@"longi"],[[NSUserDefaults standardUserDefaults]floatForKey:@"lati1"],[[NSUserDefaults standardUserDefaults]floatForKey:@"longi1"],strgender,wheelchairfacility];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,requestnow];
        [request setURL:[NSURL URLWithString:strurl]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:postData];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async (dispatch_get_main_queue(), ^{
               
                if (error)
                {
                    
                } else
                {
                    if(data != nil) {
                        NSError *error=nil;
                        NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                        [self parsdate:responseJSON];
                        [DejalBezelActivityView removeView];
                    }
                }

                
            });
        }] resume];

        
        
    }
    }
}

-(void)parsdate:(NSMutableDictionary*)responseData
{
    //  NSError *err;
    
    NSMutableDictionary *responseJSON = responseData;   // NSLog(@"*****response details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
   
    
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
         self.view.userInteractionEnabled=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        NSString *strfarevalue=[NSString stringWithFormat:@"%@",[[[responseJSON valueForKey:@"data"] valueForKey:@"fares"] valueForKey:@"total_fare"]];
        NSLog(@"%@",strfarevalue);
        
        if ([strfarevalue isEqual:[NSString stringWithFormat:@"(\n)"]])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Select Proper source/Destination" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
             self.view.userInteractionEnabled=YES;
        }
        else
        {
        
        NSString *strpic=[NSString stringWithFormat:@"%@",_searchDropAddRef.text];
        NSString *strdes=[NSString stringWithFormat:@"%@",_searchDropAddRef2.text];
        
        [[NSUserDefaults standardUserDefaults]setObject:strpic forKey:@"pic"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:strdes forKey:@"des"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:strfarevalue forKey:@"farevalue"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        AvailableCabsViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"AvailableCabsViewController"];
        bookTax.TitleString =[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"];
        [self.navigationController pushViewController:bookTax animated:YES];
        }
    }
}


#pragma mark
#pragma mark -- ClickedButton CarType

-(IBAction)butonclicked:(UIButton *)sender
{
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {

    [DataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if (sender.tag== buttontag1+idx)
         {
            // sender.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
           //  [sender setImage:[UIImage imageNamed:@"green car.png"] forState:UIControlStateNormal];
             
             carID =[[DataArray objectAtIndex:idx] valueForKey:@"name"];
             strid=[[DataArray objectAtIndex:idx] valueForKey:@"id"];
             
             [[NSUserDefaults standardUserDefaults] setObject:carID forKey:@"Name"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [[NSUserDefaults standardUserDefaults] setObject:strid forKey:@"idd"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             for(UIButton *btn in Scrollview.subviews)
                 if([btn isKindOfClass:[UIButton class]])
                     btn.selected = NO;
             
             sender.selected = YES;
             
             btnSelected = sender;
         }
     }];
    
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        
   
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(nnext) object:nil];
    [self performSelector:@selector(nnext) withObject:nil afterDelay:0.1];
    }
    
   // [self nnext];
}


-(void)nnext
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,nearCars]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"car_type=%@", strid]];
    [profile appendString:[NSString stringWithFormat:@"&latitude=%f",latitude]];
    [profile appendString:[NSString stringWithFormat:@"&longitude=%f",longitude]];
    [profile appendString:[NSString stringWithFormat:@"&gender=%@",strgender]];
    [profile appendString:[NSString stringWithFormat:@"&wheel_chair=%@",wheelchairfacility]];
    
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
    
    NSLog(@"*****Near car details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    sampleImgView.image=nil;
    sampleImgView1.image=nil;
    sampleImgView2.image=nil;
    sampleImgView3.image=nil;
    sampleImgView4.image=nil;
    sampleImgView5.image=nil;
    sampleImgView6.image=nil;
    sampleImgView7.image=nil;
    sampleImgView8.image=nil;
    sampleImgView9.image=nil;

    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        [_mapView_ clear];
  //     [self getLocationFromAddressString4:_searchDropAddRef.text];
      //  [self getLocationFromAddressString5:_searchDropAddRef2.text];
        
        
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        
//        [alert show];
        
//        NSString *message =[responseJSON valueForKey:@"message"];
//        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:nil
//                                              otherButtonTitles:nil, nil];
//        [toast show];
//        int duration = 2; // in seconds
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            [toast dismissWithClickedButtonIndex:0 animated:YES];
//        });
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel) object:nil];
        [self performSelector:@selector(numnel) withObject:nil afterDelay:20.0];
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        arrnearcardetails=[responseJSON valueForKey:@"data"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrnearcardetails];
        
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"cardet"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        arrlocationscarslat=[responseJSON valueForKey:@"data"];
        arrlocationscarslog=[[responseJSON valueForKey:@"data"]valueForKey:@"longitude"];

       [_mapView_ clear];
 //      [self getLocationFromAddressString4:_searchDropAddRef.text];
//      [self getLocationFromAddressString5:_searchDropAddRef2.text];
        
        for(i = 0; i < arrlocationscarslat.count; i++)
        {
            double lati = [[[arrlocationscarslat valueForKey:@"latitude"]objectAtIndex:i] doubleValue];
            double longit = [[[arrlocationscarslat valueForKey:@"longitude"]objectAtIndex:i ] doubleValue];
            
            marker1 = [[GMSMarker alloc] init];
            marker1.position = CLLocationCoordinate2DMake(lati, longit);
            marker1.icon=[UIImage imageNamed:@"carjam.png"];
            marker1.icon = [self image:marker1.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
            marker1.title=[[arrlocationscarslat valueForKey:@"name"]objectAtIndex:i];
            marker1.snippet=[[arrlocationscarslat valueForKey:@"license_plate"]objectAtIndex:i];
            marker1.map = _mapView_;
        }
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel) object:nil];
        [self performSelector:@selector(numnel) withObject:nil afterDelay:10.0];
    }
}




-(void)numnel
{
    if (count==0)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numbernul) object:nil];
        [self performSelector:@selector(numbernul) withObject:nil afterDelay:1.0];
    }
    else if(count==1)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(num1:) object:nil];
        [self performSelector:@selector(num1:) withObject:nil afterDelay:1.0];
    }
}


-(void)numnel2
{
    if (count==0)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numbernul) object:nil];
        [self performSelector:@selector(numbernul) withObject:nil afterDelay:1.0];
    }
    else if(count==1)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(num1:) object:nil];
        [self performSelector:@selector(num1:) withObject:nil afterDelay:1.0];
    }
}



-(void)numbernul
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,nearCars]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"car_type=%@", strid]];
    [profile appendString:[NSString stringWithFormat:@"&latitude=%f",latitude]];
    [profile appendString:[NSString stringWithFormat:@"&longitude=%f",longitude]];
    [profile appendString:[NSString stringWithFormat:@"&gender=%@",strgender]];
    [profile appendString:[NSString stringWithFormat:@"&wheel_chair=%@",wheelchairfacility]];
    
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
    
//    NSLog(@"*****Near car details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    sampleImgView.image=nil;
    sampleImgView1.image=nil;
    sampleImgView2.image=nil;
    sampleImgView3.image=nil;
    sampleImgView4.image=nil;
    sampleImgView5.image=nil;
    sampleImgView6.image=nil;
    sampleImgView7.image=nil;
    sampleImgView8.image=nil;
    sampleImgView9.image=nil;
   
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        [_mapView_ clear];
   //     [self getLocationFromAddressString4:_searchDropAddRef.text];
        
        //[self getLocationFromAddressString5:_searchDropAddRef2.text];
        
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        
//        [alert show];
      
//        NSString *message =[responseJSON valueForKey:@"message"];
//        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:nil
//                                              otherButtonTitles:nil, nil];
//        [toast show];
//        int duration = 1; // in seconds
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            [toast dismissWithClickedButtonIndex:0 animated:YES];
//        });
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel) object:nil];
        [self performSelector:@selector(numnel) withObject:nil afterDelay:20.0];
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        arrnearcardetails=[responseJSON valueForKey:@"data"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrnearcardetails];
        
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"cardet"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        arrlocationscarslat=[responseJSON valueForKey:@"data"];
        arrlocationscarslog=[[responseJSON valueForKey:@"data"]valueForKey:@"longitude"];
    
        [_mapView_ clear];
 //       [self getLocationFromAddressString4:_searchDropAddRef.text];
        
//      [self getLocationFromAddressString5:_searchDropAddRef2.text];
        
        
        for(i = 0; i <arrlocationscarslat.count; i++)
        {
            if (i==0)
            {
                sampleImgView.image=nil;
                [arrpointlat removeAllObjects];
                [arrpointlong removeAllObjects];
                
                double lati = [[[arrlocationscarslat valueForKey:@"latitude"]objectAtIndex:0] doubleValue];
                double longit = [[[arrlocationscarslat valueForKey:@"longitude"]objectAtIndex:0 ] doubleValue];
                
                double latiold = [[[arrlocationscarslat valueForKey:@"old_latitude"]objectAtIndex:0] doubleValue];
                double longitold = [[[arrlocationscarslat valueForKey:@"old_longitude"]objectAtIndex:0] doubleValue];
                
                currLocation = [[CLLocation alloc]initWithLatitude:lati longitude:longit];
                prevCurrLocation = [[CLLocation alloc]initWithLatitude:latiold longitude:longitold];
                
                sampleImgView = [[UIImageView alloc]init];
                sampleImgView.tag=imageTAg+i;
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
//                    GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//                    
//                    rectangle.strokeWidth=5.0;
//                    
//                    rectangle.map = _mapView_;
                }
                @catch (NSException * e) {
                                    }
                j=1;
                [self angle:sampleImgView];
            }
            
           else if (i==1)
           {
                sampleImgView1.image=nil;
                
                [arrpointlat1 removeAllObjects];
                [arrpointlong1 removeAllObjects];
                
                double lati1 = [[[arrlocationscarslat valueForKey:@"latitude"]objectAtIndex:1] doubleValue];
                double longit1 = [[[arrlocationscarslat valueForKey:@"longitude"]objectAtIndex:1 ] doubleValue];
                
                double latiold1 = [[[arrlocationscarslat valueForKey:@"old_latitude"]objectAtIndex:1] doubleValue];
                double longitold1 = [[[arrlocationscarslat valueForKey:@"old_longitude"]objectAtIndex:1] doubleValue];
                
                currLocation1 = [[CLLocation alloc]initWithLatitude:lati1 longitude:longit1];
                prevCurrLocation1 = [[CLLocation alloc]initWithLatitude:latiold1 longitude:longitold1];
               
                sampleImgView1 = [[UIImageView alloc]init];
                sampleImgView1.tag=imageTAg+i;
                sampleImgView1.center = _mapView_.center;
                sampleImgView1.backgroundColor = [UIColor clearColor];
                [_mapView_ addSubview:sampleImgView1];
                
                CGPoint ImgCenter = sampleImgView1.center;
                CGRect frameRect = sampleImgView1.frame;
                
                frameRect.size.width = 30.0f;
                frameRect.size.height = 30.0f;
                
                sampleImgView1.center = ImgCenter;
                sampleImgView1.frame = frameRect;
                
                NSString *str=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", latiold1,  longitold1, lati1, longit1];
                
                NSURL *url=[[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                
                NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                
                NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                
                NSError* error;
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                
                NSArray* latestRoutes = [json objectForKey:@"routes"];
                
                NSString *points=[[[latestRoutes objectAtIndex:0] objectForKey:@"overview_polyline"] objectForKey:@"points"];
                
                @try {
                    temp= [self decodePolyLin:[points mutableCopy]];
                    
                    GMSMutablePath *path = [GMSMutablePath path];
                    
                    for(int idx = 0; idx < [temp count]; idx++)
                    {
                        CLLocation *location=[temp objectAtIndex:idx];
                        
                        [path addCoordinate:location.coordinate];
                        
                    }
                    // create the polyline based on the array of points.
//                    GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//                    
//                    rectangle.strokeWidth=5.0;
//                    
//                    rectangle.map = _mapView_;
                }
                @catch (NSException * e) {
                    
                }
                
                l=1;
                [self angl:sampleImgView1];
            }
            
           else if (i==2)
           {
               sampleImgView2.image=nil;
               
               [arrpointlat2 removeAllObjects];
               [arrpointlong2 removeAllObjects];
               
               double lati2 = [[[arrlocationscarslat valueForKey:@"latitude"]objectAtIndex:2] doubleValue];
               double longit2 = [[[arrlocationscarslat valueForKey:@"longitude"]objectAtIndex:2 ] doubleValue];
               
               double latiold2 = [[[arrlocationscarslat valueForKey:@"old_latitude"]objectAtIndex:2] doubleValue];
               double longitold2 = [[[arrlocationscarslat valueForKey:@"old_longitude"]objectAtIndex:2] doubleValue];
               
               currLocation2 = [[CLLocation alloc]initWithLatitude:lati2 longitude:longit2];
               prevCurrLocation2 = [[CLLocation alloc]initWithLatitude:latiold2 longitude:longitold2];
               
               sampleImgView2 = [[UIImageView alloc]init];
               sampleImgView2.tag=imageTAg+i;
               sampleImgView2.center = _mapView_.center;
               sampleImgView2.backgroundColor = [UIColor clearColor];
               [_mapView_ addSubview:sampleImgView2];
               
               CGPoint ImgCenter = sampleImgView2.center;
               CGRect frameRect = sampleImgView2.frame;
               
               frameRect.size.width = 30.0f;
               frameRect.size.height = 30.0f;
               
               sampleImgView2.center = ImgCenter;
               sampleImgView2.frame = frameRect;
               
               NSString *str=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", latiold2,  longitold2, lati2, longit2];
               
               NSURL *url=[[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
               
               NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
               
               NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
               
               NSError* error;
               NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
               
               NSArray* latestRoutes = [json objectForKey:@"routes"];
               
               NSString *points=[[[latestRoutes objectAtIndex:0] objectForKey:@"overview_polyline"] objectForKey:@"points"];
               
               @try {
                   // TODO: better parsing. Regular expression?
                  
                   temp= [self decodePolyLine1:[points mutableCopy]];
                   
                   GMSMutablePath *path = [GMSMutablePath path];
                   
                   for(int idx = 0; idx < [temp count]; idx++)
                   {
                       CLLocation *location=[temp objectAtIndex:idx];
                       
                       [path addCoordinate:location.coordinate];
                       
                   }
                   // create the polyline based on the array of points.
//                   GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//                   
//                   rectangle.strokeWidth=5.0;
//                   
//                   rectangle.map = _mapView_;
               }
               @catch (NSException * e) {
                  
               }
               
               a=1;
               [self angl2:sampleImgView2];
           }
           else if (i==3)
           {
               sampleImgView3.image=nil;
               
               [arrpointlat3 removeAllObjects];
               [arrpointlong3 removeAllObjects];
               
               double lati3 = [[[arrlocationscarslat valueForKey:@"latitude"]objectAtIndex:3] doubleValue];
               double longit3 = [[[arrlocationscarslat valueForKey:@"longitude"]objectAtIndex:3] doubleValue];
               
               double latiold3 = [[[arrlocationscarslat valueForKey:@"old_latitude"]objectAtIndex:3] doubleValue];
               double longitold3 = [[[arrlocationscarslat valueForKey:@"old_longitude"]objectAtIndex:3] doubleValue];
               
               currLocation3 = [[CLLocation alloc]initWithLatitude:lati3 longitude:longit3];
               prevCurrLocation3 = [[CLLocation alloc]initWithLatitude:latiold3 longitude:longitold3];
               
               sampleImgView3 = [[UIImageView alloc]init];
               sampleImgView3.tag=imageTAg+i;
               sampleImgView3.center = _mapView_.center;
               sampleImgView3.backgroundColor = [UIColor clearColor];
               [_mapView_ addSubview:sampleImgView3];
               
               CGPoint ImgCenter = sampleImgView3.center;
               CGRect frameRect = sampleImgView3.frame;
               
               frameRect.size.width = 30.0f;
               frameRect.size.height = 30.0f;
               
               sampleImgView3.center = ImgCenter;
               sampleImgView3.frame = frameRect;
               
               NSString *str=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", latiold3,  longitold3, lati3, longit3];
               
               NSURL *url=[[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
               
               NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
               
               NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
               
               NSError* error;
               NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
               
               NSArray* latestRoutes = [json objectForKey:@"routes"];
               
               NSString *points=[[[latestRoutes objectAtIndex:0] objectForKey:@"overview_polyline"] objectForKey:@"points"];
               
               @try {
                   // TODO: better parsing. Regular expression?
                   
                   temp= [self decodePolyLine2:[points mutableCopy]];
                   
                   GMSMutablePath *path = [GMSMutablePath path];
                   
                   for(int idx = 0; idx < [temp count]; idx++)
                   {
                       CLLocation *location=[temp objectAtIndex:idx];
                       
                       [path addCoordinate:location.coordinate];
                       
                   }
                   // create the polyline based on the array of points.
//                   GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//                   
//                   rectangle.strokeWidth=5.0;
//                   
//                   rectangle.map = _mapView_;
               }
               @catch (NSException * e) {
                   
               }
               
               c=1;
               [self angl3:sampleImgView3];
           }
           else if (i==4)
           {
               sampleImgView4.image=nil;
               
               [arrpointlat4 removeAllObjects];
               [arrpointlong4 removeAllObjects];
               
               double lati4 = [[[arrlocationscarslat valueForKey:@"latitude"]objectAtIndex:4] doubleValue];
               double longit4 = [[[arrlocationscarslat valueForKey:@"longitude"]objectAtIndex:4] doubleValue];
               
               double latiold4 = [[[arrlocationscarslat valueForKey:@"old_latitude"]objectAtIndex:4] doubleValue];
               double longitold4= [[[arrlocationscarslat valueForKey:@"old_longitude"]objectAtIndex:4] doubleValue];
               
               currLocation4 = [[CLLocation alloc]initWithLatitude:lati4 longitude:longit4];
               prevCurrLocation4 = [[CLLocation alloc]initWithLatitude:latiold4 longitude:longitold4];
               
               sampleImgView4 = [[UIImageView alloc]init];
               sampleImgView4.tag=imageTAg+i;
               sampleImgView4.center = _mapView_.center;
               sampleImgView4.backgroundColor = [UIColor clearColor];
               [_mapView_ addSubview:sampleImgView4];
               
               CGPoint ImgCenter = sampleImgView4.center;
               CGRect frameRect = sampleImgView4.frame;
               
               frameRect.size.width = 30.0f;
               frameRect.size.height = 30.0f;
               
               sampleImgView4.center = ImgCenter;
               sampleImgView4.frame = frameRect;
               
               NSString *str=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", latiold4,  longitold4, lati4, longit4];
               
               NSURL *url=[[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
               
               NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
               
               NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
               
               NSError* error;
               NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
               
               NSArray* latestRoutes = [json objectForKey:@"routes"];
               
               NSString *points=[[[latestRoutes objectAtIndex:0] objectForKey:@"overview_polyline"] objectForKey:@"points"];
               
               @try {
                   // TODO: better parsing. Regular expression?
                   
                   temp= [self decodePolyLine3:[points mutableCopy]];
                   
                   GMSMutablePath *path = [GMSMutablePath path];
                   
                   for(int idx = 0; idx < [temp count]; idx++)
                   {
                       CLLocation *location=[temp objectAtIndex:idx];
                       
                       [path addCoordinate:location.coordinate];
                       
                   }
                   // create the polyline based on the array of points.
//                   GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//                   
//                   rectangle.strokeWidth=5.0;
//                   
//                   rectangle.map = _mapView_;
               }
               @catch (NSException * e) {
                   
               }
               
               d=1;
               [self angl4:sampleImgView4];
           }
           else if (i==5)
           {
               sampleImgView5.image=nil;
               
               [arrpointlat5 removeAllObjects];
               [arrpointlong5 removeAllObjects];
               
               double lati5 = [[[arrlocationscarslat valueForKey:@"latitude"]objectAtIndex:5] doubleValue];
               double longit5 = [[[arrlocationscarslat valueForKey:@"longitude"]objectAtIndex:5] doubleValue];
               
               double latiold5 = [[[arrlocationscarslat valueForKey:@"old_latitude"]objectAtIndex:5] doubleValue];
               double longitold5= [[[arrlocationscarslat valueForKey:@"old_longitude"]objectAtIndex:5] doubleValue];
               
               currLocation5 = [[CLLocation alloc]initWithLatitude:lati5 longitude:longit5];
               prevCurrLocation5 = [[CLLocation alloc]initWithLatitude:latiold5 longitude:longitold5];
               
               sampleImgView5 = [[UIImageView alloc]init];
               sampleImgView5.tag=imageTAg+i;
               sampleImgView5.center = _mapView_.center;
               sampleImgView5.backgroundColor = [UIColor clearColor];
               [_mapView_ addSubview:sampleImgView5];
               
               CGPoint ImgCenter = sampleImgView4.center;
               CGRect frameRect = sampleImgView4.frame;
               
               frameRect.size.width = 30.0f;
               frameRect.size.height = 30.0f;
               
               sampleImgView5.center = ImgCenter;
               sampleImgView5.frame = frameRect;
               
               NSString *str=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", latiold5,  longitold5, lati5, longit5];
               
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
//                   GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//                   
//                   rectangle.strokeWidth=5.0;
//                   
//                   rectangle.map = _mapView_;
               }
               @catch (NSException * e) {
                   
               }
               
               e=1;
               [self angl5:sampleImgView5];
           }
           else if (i==6)
           {
               sampleImgView6.image=nil;
               
               [arrpointlat6 removeAllObjects];
               [arrpointlong6 removeAllObjects];
               
               double lati6 = [[[arrlocationscarslat valueForKey:@"latitude"]objectAtIndex:6] doubleValue];
               double longit6 = [[[arrlocationscarslat valueForKey:@"longitude"]objectAtIndex:6] doubleValue];
               
               double latiold6 = [[[arrlocationscarslat valueForKey:@"old_latitude"]objectAtIndex:6] doubleValue];
               double longitold6= [[[arrlocationscarslat valueForKey:@"old_longitude"]objectAtIndex:6] doubleValue];
               
               currLocation6 = [[CLLocation alloc]initWithLatitude:lati6 longitude:longit6];
               prevCurrLocation6 = [[CLLocation alloc]initWithLatitude:latiold6 longitude:longitold6];
               
               sampleImgView6 = [[UIImageView alloc]init];
               sampleImgView6.tag=imageTAg+i;
               sampleImgView6.center = _mapView_.center;
               sampleImgView6.backgroundColor = [UIColor clearColor];
               [_mapView_ addSubview:sampleImgView6];
               
               CGPoint ImgCenter = sampleImgView6.center;
               CGRect frameRect = sampleImgView6.frame;
               
               frameRect.size.width = 30.0f;
               frameRect.size.height = 30.0f;
               
               sampleImgView6.center = ImgCenter;
               sampleImgView6.frame = frameRect;
               
               NSString *str=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", latiold6,  longitold6, lati6, longit6];
               
               NSURL *url=[[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
               
               NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
               
               NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
               
               NSError* error;
               NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
               
               NSArray* latestRoutes = [json objectForKey:@"routes"];
               
               NSString *points=[[[latestRoutes objectAtIndex:0] objectForKey:@"overview_polyline"] objectForKey:@"points"];
               
               @try {
                   // TODO: better parsing. Regular expression?
                   
                   temp= [self decodePolyLine5:[points mutableCopy]];
                   
                   GMSMutablePath *path = [GMSMutablePath path];
                   
                   for(int idx = 0; idx < [temp count]; idx++)
                   {
                       CLLocation *location=[temp objectAtIndex:idx];
                       
                       [path addCoordinate:location.coordinate];
                       
                   }
                   // create the polyline based on the array of points.
//                   GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//                   
//                   rectangle.strokeWidth=5.0;
//                   
//                   rectangle.map = _mapView_;
               }
               @catch (NSException * e)
               {
                   
               }
               
               f=1;
               [self angl6:sampleImgView6];
           }
           else if (i==7)
           {
               sampleImgView7.image=nil;
               
               [arrpointlat7 removeAllObjects];
               [arrpointlong7 removeAllObjects];
               
               double lati7 = [[[arrlocationscarslat valueForKey:@"latitude"]objectAtIndex:7] doubleValue];
               double longit7 = [[[arrlocationscarslat valueForKey:@"longitude"]objectAtIndex:7] doubleValue];
               
               double latiold7 = [[[arrlocationscarslat valueForKey:@"old_latitude"]objectAtIndex:7] doubleValue];
               double longitold7= [[[arrlocationscarslat valueForKey:@"old_longitude"]objectAtIndex:7] doubleValue];
               
               currLocation7 = [[CLLocation alloc]initWithLatitude:lati7 longitude:longit7];
               prevCurrLocation7 = [[CLLocation alloc]initWithLatitude:latiold7 longitude:longitold7];
               
               sampleImgView7 = [[UIImageView alloc]init];
               sampleImgView7.tag=imageTAg+i;
               sampleImgView7.center = _mapView_.center;
               sampleImgView7.backgroundColor = [UIColor clearColor];
               [_mapView_ addSubview:sampleImgView7];
               
               CGPoint ImgCenter = sampleImgView7.center;
               CGRect frameRect = sampleImgView7.frame;
               
               frameRect.size.width = 30.0f;
               frameRect.size.height = 30.0f;
               
               sampleImgView7.center = ImgCenter;
               sampleImgView7.frame = frameRect;
               
               NSString *str=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", latiold7,  longitold7, lati7, longit7];
               
               NSURL *url=[[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
               
               NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
               
               NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
               
               NSError* error;
               NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
               
               NSArray* latestRoutes = [json objectForKey:@"routes"];
               
               NSString *points=[[[latestRoutes objectAtIndex:0] objectForKey:@"overview_polyline"] objectForKey:@"points"];
               
               @try {
                   // TODO: better parsing. Regular expression?
                   
                   temp= [self decodePolyLine6:[points mutableCopy]];
                   
                   GMSMutablePath *path = [GMSMutablePath path];
                   
                   for(int idx = 0; idx < [temp count]; idx++)
                   {
                       CLLocation *location=[temp objectAtIndex:idx];
                       
                       [path addCoordinate:location.coordinate];
                       
                   }
                   // create the polyline based on the array of points.
//                   GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//                   
//                   rectangle.strokeWidth=5.0;
//                   
//                   rectangle.map = _mapView_;
               }
               @catch (NSException * e) {
                   
               }
               
               m=1;
               [self angl7:sampleImgView7];
           }
           else if (i==8)
           {
               sampleImgView8.image=nil;
               
               [arrpointlat8 removeAllObjects];
               [arrpointlong8 removeAllObjects];
               
               double lati8 = [[[arrlocationscarslat valueForKey:@"latitude"]objectAtIndex:8] doubleValue];
               double longit8 = [[[arrlocationscarslat valueForKey:@"longitude"]objectAtIndex:8] doubleValue];
               
               double latiold8 = [[[arrlocationscarslat valueForKey:@"old_latitude"]objectAtIndex:8] doubleValue];
               double longitold8= [[[arrlocationscarslat valueForKey:@"old_longitude"]objectAtIndex:8] doubleValue];
               
               currLocation8 = [[CLLocation alloc]initWithLatitude:lati8 longitude:longit8];
               prevCurrLocation8 = [[CLLocation alloc]initWithLatitude:latiold8 longitude:longitold8];
               
               sampleImgView8 = [[UIImageView alloc]init];
               sampleImgView8.tag=imageTAg+i;
               sampleImgView8.center = _mapView_.center;
               sampleImgView8.backgroundColor = [UIColor clearColor];
               [_mapView_ addSubview:sampleImgView8];
               
               CGPoint ImgCenter = sampleImgView8.center;
               CGRect frameRect = sampleImgView8.frame;
               
               frameRect.size.width = 30.0f;
               frameRect.size.height = 30.0f;
               
               sampleImgView8.center = ImgCenter;
               sampleImgView8.frame = frameRect;
               
               NSString *str=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", latiold8,  longitold8, lati8, longit8];
               
               NSURL *url=[[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
               
               NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
               
               NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
               
               NSError* error;
               NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
               
               NSArray* latestRoutes = [json objectForKey:@"routes"];
               
               NSString *points=[[[latestRoutes objectAtIndex:0] objectForKey:@"overview_polyline"] objectForKey:@"points"];
               
               @try {
                   // TODO: better parsing. Regular expression?
                   
                   temp= [self decodePolyLine7:[points mutableCopy]];
                   
                   GMSMutablePath *path = [GMSMutablePath path];
                   
                   for(int idx = 0; idx < [temp count]; idx++)
                   {
                       CLLocation *location=[temp objectAtIndex:idx];
                       
                       [path addCoordinate:location.coordinate];
                       
                   }
                   // create the polyline based on the array of points.
//                   GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//                   
//                   rectangle.strokeWidth=5.0;
//                   
//                   rectangle.map = _mapView_;
               }
               @catch (NSException * e) {
                   
               }
               
               n=1;
               [self angl8:sampleImgView8];
           }
           else if (i==9)
           {
               sampleImgView9.image=nil;
               
               [arrpointlat9 removeAllObjects];
               [arrpointlong9 removeAllObjects];
               
               double lati9 = [[[arrlocationscarslat valueForKey:@"latitude"]objectAtIndex:9] doubleValue];
               double longit9 = [[[arrlocationscarslat valueForKey:@"longitude"]objectAtIndex:9] doubleValue];
               
               double latiold9 = [[[arrlocationscarslat valueForKey:@"old_latitude"]objectAtIndex:9] doubleValue];
               double longitold9= [[[arrlocationscarslat valueForKey:@"old_longitude"]objectAtIndex:9] doubleValue];
               
               currLocation9 = [[CLLocation alloc]initWithLatitude:lati9 longitude:longit9];
               prevCurrLocation9 = [[CLLocation alloc]initWithLatitude:latiold9 longitude:longitold9];
               
               sampleImgView9 = [[UIImageView alloc]init];
               sampleImgView9.tag=imageTAg+i;
               sampleImgView9.center = _mapView_.center;
               sampleImgView9.backgroundColor = [UIColor clearColor];
               [_mapView_ addSubview:sampleImgView9];
               
               CGPoint ImgCenter = sampleImgView9.center;
               CGRect frameRect = sampleImgView9.frame;
               
               frameRect.size.width = 30.0f;
               frameRect.size.height = 30.0f;
               
               sampleImgView9.center = ImgCenter;
               sampleImgView9.frame = frameRect;
               
               NSString *str=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", latiold9,  longitold9, lati9, longit9];
               
               NSURL *url=[[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
               
               NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
               
               NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
               
               NSError* error;
               NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
               
               NSArray* latestRoutes = [json objectForKey:@"routes"];
               
               NSString *points=[[[latestRoutes objectAtIndex:0] objectForKey:@"overview_polyline"] objectForKey:@"points"];
               
               @try {
                   // TODO: better parsing. Regular expression?
                   
                   temp= [self decodePolyLine8:[points mutableCopy]];
                   
                   GMSMutablePath *path = [GMSMutablePath path];
                   
                   for(int idx = 0; idx < [temp count]; idx++)
                   {
                       CLLocation *location=[temp objectAtIndex:idx];
                       
                       [path addCoordinate:location.coordinate];
                       
                   }
                   // create the polyline based on the array of points.
//                   GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//                   
//                   rectangle.strokeWidth=5.0;
//                   
//                   rectangle.map = _mapView_;
               }
               @catch (NSException * e) {
                   
               }
               
               o=1;
               [self angl9:sampleImgView9];
           }
 
        }
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(numnel) object:nil];
        [self performSelector:@selector(numnel) withObject:nil afterDelay:20.0];
    }
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
        
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:10.0];
       // marker1.icon=[UIImage imageNamed:@"carjam.png"];
        [CATransaction commit];
        
        
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
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(angle:) object:nil];
        [self performSelector:@selector(angle:) withObject:nil afterDelay:2.0];
        
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

-(void)angl:(UIImageView *)sender
{
    if (l<arrpointlat1.count)
    {
        [sampleImgView1 removeFromSuperview];
        double lati = [[arrpointlat1 objectAtIndex:l-1] doubleValue];
        double longit = [[arrpointlong1 objectAtIndex:l-1] doubleValue];
        
        double lati1 = [[arrpointlat1 objectAtIndex:l] doubleValue];
        double longit1 = [[arrpointlong1 objectAtIndex:l] doubleValue];
        
        prevCurrLocation1 = [[CLLocation alloc]initWithLatitude:lati longitude:longit];
        currLocation1 = [[CLLocation alloc]initWithLatitude:lati1 longitude:longit1];
        
        
        sampleImgView1 = [[UIImageView alloc]init];
        sampleImgView1.center = _mapView_.center;
        sampleImgView1.backgroundColor = [UIColor clearColor];
        [_mapView_ addSubview:sampleImgView1];
        
        
        CGPoint ImgCenter = sampleImgView1.center;
        CGRect frameRect = sampleImgView1.frame;
        
        frameRect.size.width = 30.0f;
        frameRect.size.height = 30.0f;
        sampleImgView1.image = [UIImage imageNamed:@"carjam.png"]; // place your own vehicle image
        
        sampleImgView1.center = ImgCenter;
        sampleImgView1.frame = frameRect;
        
        sampleImgView1.image = [UIImage imageNamed:@"carjam.png"];
       [sampleImgView1 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(prevCurrLocation1.coordinate.latitude, prevCurrLocation1.coordinate.longitude)]];
        
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:10.0];
     //   marker2.icon=[UIImage imageNamed:@"carjam.png"];
        [CATransaction commit];
        
        
        CGPoint anglepoint = [_mapView_.projection pointForCoordinate:currLocation1.coordinate];
        
        //     CGFloat angle = [self getAngle:anglepoint];
        
        CGPoint previousLocationPoint = [_mapView_.projection pointForCoordinate:prevCurrLocation1.coordinate];
        
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
            sampleImgView1.transform=rotationTransform;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView1 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation1.coordinate.latitude, currLocation1.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation1 = currLocation1;
        }
        else{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView1 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation1.coordinate.latitude, currLocation1.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation1 = currLocation1;
        }
        l++;
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(angl:) object:nil];
        [self performSelector:@selector(angl:) withObject:nil afterDelay:2.0];
        
    }
    else if (arrpointlat1.count==1)
    {
        [sampleImgView1 removeFromSuperview];
        double lati = [[arrpointlat1 objectAtIndex:0] doubleValue];
        double longit = [[arrpointlong1 objectAtIndex:0] doubleValue];
        
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(lati, longit);
       mark.icon=[UIImage imageNamed:@"carjam.png"];
        mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
        
    }
    else
    {
        sampleImgView1.image=nil;
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(currLocation1.coordinate.latitude, currLocation1.coordinate.longitude);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
        mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
    }
}

-(void)angl2:(UIImageView *)sender
{
    if (a<arrpointlat2.count)
    {
        [sampleImgView2 removeFromSuperview];
        double lati = [[arrpointlat2 objectAtIndex:a-1] doubleValue];
        double longit = [[arrpointlong2 objectAtIndex:a-1] doubleValue];
        
        double lati1 = [[arrpointlat2 objectAtIndex:a] doubleValue];
        double longit1 = [[arrpointlong2 objectAtIndex:a] doubleValue];
        
        prevCurrLocation2 = [[CLLocation alloc]initWithLatitude:lati longitude:longit];
        currLocation2 = [[CLLocation alloc]initWithLatitude:lati1 longitude:longit1];
        
        
        sampleImgView2 = [[UIImageView alloc]init];
        sampleImgView2.center = _mapView_.center;
        sampleImgView2.backgroundColor = [UIColor clearColor];
        [_mapView_ addSubview:sampleImgView2];
        
        
        CGPoint ImgCenter = sampleImgView2.center;
        CGRect frameRect = sampleImgView2.frame;
        
        frameRect.size.width = 30.0f;
        frameRect.size.height = 30.0f;
        sampleImgView2.image = [UIImage imageNamed:@"carjam.png"]; // place your own vehicle image
        
        sampleImgView2.center = ImgCenter;
        sampleImgView2.frame = frameRect;
        
        sampleImgView2.image = [UIImage imageNamed:@"carjam.png"];
        [sampleImgView2 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(prevCurrLocation2.coordinate.latitude, prevCurrLocation2.coordinate.longitude)]];
        
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:10.0];
     //   marker2.icon=[UIImage imageNamed:@"carjam.png"];
        [CATransaction commit];
        
        
        CGPoint anglepoint = [_mapView_.projection pointForCoordinate:currLocation2.coordinate];
        
        CGPoint previousLocationPoint = [_mapView_.projection pointForCoordinate:prevCurrLocation2.coordinate];
        
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
            sampleImgView2.transform=rotationTransform;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView2 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation2.coordinate.latitude, currLocation2.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation2 = currLocation2;
        }
        else{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView2 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation2.coordinate.latitude, currLocation2.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation2 = currLocation2;
        }
        a++;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(angl2:) object:nil];
        [self performSelector:@selector(angl2:) withObject:nil afterDelay:2.0];
    }
    
    else if (arrpointlat2.count==1)
    {
        [sampleImgView2 removeFromSuperview];
        double lati = [[arrpointlat2 objectAtIndex:0] doubleValue];
        double longit = [[arrpointlong2 objectAtIndex:0] doubleValue];
        
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(lati, longit);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
        mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
        
    }
    else
    {
        sampleImgView2.image=nil;
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(currLocation2.coordinate.latitude, currLocation2.coordinate.longitude);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
        mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
    }
}
-(void)angl3:(UIImageView *)sender
{
    if (c<arrpointlat3.count)
    {
        [sampleImgView3 removeFromSuperview];
        double lati = [[arrpointlat3 objectAtIndex:c-1] doubleValue];
        double longit = [[arrpointlong3 objectAtIndex:c-1] doubleValue];
        
        double lati1 = [[arrpointlat3 objectAtIndex:c] doubleValue];
        double longit1 = [[arrpointlong3 objectAtIndex:c] doubleValue];
        
        prevCurrLocation3 = [[CLLocation alloc]initWithLatitude:lati longitude:longit];
        currLocation3 = [[CLLocation alloc]initWithLatitude:lati1 longitude:longit1];
        
        
        sampleImgView3 = [[UIImageView alloc]init];
        sampleImgView3.center = _mapView_.center;
        sampleImgView3.backgroundColor = [UIColor clearColor];
        [_mapView_ addSubview:sampleImgView3];
        
        
        CGPoint ImgCenter = sampleImgView3.center;
        CGRect frameRect = sampleImgView3.frame;
        
        frameRect.size.width = 30.0f;
        frameRect.size.height = 30.0f;
        sampleImgView3.image = [UIImage imageNamed:@"carjam.png"]; // place your own vehicle image
        
        sampleImgView3.center = ImgCenter;
        sampleImgView3.frame = frameRect;
        
        sampleImgView3.image = [UIImage imageNamed:@"carjam.png"];
        [sampleImgView3 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(prevCurrLocation3.coordinate.latitude, prevCurrLocation3.coordinate.longitude)]];
        
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:10.0];
       // marker2.icon=[UIImage imageNamed:@"carjam.png"];
        [CATransaction commit];
        
        
        CGPoint anglepoint = [_mapView_.projection pointForCoordinate:currLocation3.coordinate];
        
        CGPoint previousLocationPoint = [_mapView_.projection pointForCoordinate:prevCurrLocation3.coordinate];
        
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
            sampleImgView3.transform=rotationTransform;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView3 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation3.coordinate.latitude, currLocation3.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation3 = currLocation3;
        }
        else{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView3 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation3.coordinate.latitude, currLocation3.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation3 = currLocation3;
        }
        c++;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(angl3:) object:nil];
        [self performSelector:@selector(angl3:) withObject:nil afterDelay:2.0];
    }
    
    else if (arrpointlat3.count==1)
    {
        [sampleImgView3 removeFromSuperview];
        double lati = [[arrpointlat3 objectAtIndex:0] doubleValue];
        double longit = [[arrpointlong3 objectAtIndex:0] doubleValue];
        
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(lati, longit);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
        mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
        
    }
    else
    {
        sampleImgView3.image=nil;
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(currLocation3.coordinate.latitude, currLocation3.coordinate.longitude);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
        mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
    }
}
-(void)angl4:(UIImageView *)sender
{
    if (d<arrpointlat4.count)
    {
        [sampleImgView4 removeFromSuperview];
        double lati = [[arrpointlat4 objectAtIndex:d-1] doubleValue];
        double longit = [[arrpointlong4 objectAtIndex:d-1] doubleValue];
        
        double lati1 = [[arrpointlat4 objectAtIndex:d] doubleValue];
        double longit1 = [[arrpointlong4 objectAtIndex:d] doubleValue];
        
        prevCurrLocation4 = [[CLLocation alloc]initWithLatitude:lati longitude:longit];
        currLocation4 = [[CLLocation alloc]initWithLatitude:lati1 longitude:longit1];
        
        
        sampleImgView4 = [[UIImageView alloc]init];
        sampleImgView4.center = _mapView_.center;
        sampleImgView4.backgroundColor = [UIColor clearColor];
        [_mapView_ addSubview:sampleImgView4];
        
        
        CGPoint ImgCenter = sampleImgView4.center;
        CGRect frameRect = sampleImgView4.frame;
        
        frameRect.size.width = 30.0f;
        frameRect.size.height = 30.0f;
        sampleImgView4.image = [UIImage imageNamed:@"carjam.png"]; // place your own vehicle image
        
        sampleImgView4.center = ImgCenter;
        sampleImgView4.frame = frameRect;
        
        sampleImgView4.image = [UIImage imageNamed:@"carjam.png"];
        [sampleImgView4 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(prevCurrLocation4.coordinate.latitude, prevCurrLocation4.coordinate.longitude)]];
        
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:10.0];
        // marker2.icon=[UIImage imageNamed:@"carjam.png"];
        [CATransaction commit];
        
        
        CGPoint anglepoint = [_mapView_.projection pointForCoordinate:currLocation4.coordinate];
        
        CGPoint previousLocationPoint = [_mapView_.projection pointForCoordinate:prevCurrLocation4.coordinate];
        
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
            sampleImgView4.transform=rotationTransform;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView4 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation4.coordinate.latitude, currLocation4.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation4 = currLocation4;
        }
        else{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView4 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation4.coordinate.latitude, currLocation4.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation4 = currLocation4;
        }
        d++;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(angl4:) object:nil];
        [self performSelector:@selector(angl4:) withObject:nil afterDelay:2.0];
    }
    
    else if (arrpointlat4.count==1)
    {
        [sampleImgView4 removeFromSuperview];
        double lati = [[arrpointlat4 objectAtIndex:0] doubleValue];
        double longit = [[arrpointlong4 objectAtIndex:0] doubleValue];
        
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(lati, longit);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
        mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
        
    }
    else
    {
        sampleImgView4.image=nil;
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(currLocation4.coordinate.latitude, currLocation4.coordinate.longitude);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
        mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
    }
}
-(void)angl5:(UIImageView *)sender
{
    if (e<arrpointlat5.count)
    {
        [sampleImgView5 removeFromSuperview];
        double lati = [[arrpointlat5 objectAtIndex:e-1] doubleValue];
        double longit = [[arrpointlong5 objectAtIndex:e-1] doubleValue];
        
        double lati1 = [[arrpointlat5 objectAtIndex:e] doubleValue];
        double longit1 = [[arrpointlong5 objectAtIndex:e] doubleValue];
        
        prevCurrLocation5 = [[CLLocation alloc]initWithLatitude:lati longitude:longit];
        currLocation5 = [[CLLocation alloc]initWithLatitude:lati1 longitude:longit1];
        
        
        sampleImgView5 = [[UIImageView alloc]init];
        sampleImgView5.center = _mapView_.center;
        sampleImgView5.backgroundColor = [UIColor clearColor];
        [_mapView_ addSubview:sampleImgView5];
        
        
        CGPoint ImgCenter = sampleImgView5.center;
        CGRect frameRect = sampleImgView5.frame;
        
        frameRect.size.width = 30.0f;
        frameRect.size.height = 30.0f;
        sampleImgView5.image = [UIImage imageNamed:@"carjam.png"]; // place your own vehicle image
        
        sampleImgView5.center = ImgCenter;
        sampleImgView5.frame = frameRect;
        
        sampleImgView5.image = [UIImage imageNamed:@"carjam.png"];
        [sampleImgView5 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(prevCurrLocation5.coordinate.latitude, prevCurrLocation5.coordinate.longitude)]];
        
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:10.0];
        // marker2.icon=[UIImage imageNamed:@"carjam.png"];
        [CATransaction commit];
        
        
        CGPoint anglepoint = [_mapView_.projection pointForCoordinate:currLocation5.coordinate];
        
        CGPoint previousLocationPoint = [_mapView_.projection pointForCoordinate:prevCurrLocation5.coordinate];
        
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
            sampleImgView5.transform=rotationTransform;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView5 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation5.coordinate.latitude, currLocation5.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation5 = currLocation5;
        }
        else{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView5 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation5.coordinate.latitude, currLocation5.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation5 = currLocation5;
        }
        e++;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(angl5:) object:nil];
        [self performSelector:@selector(angl5:) withObject:nil afterDelay:2.0];
    }
    
    else if (arrpointlat5.count==1)
    {
        [sampleImgView5 removeFromSuperview];
        double lati = [[arrpointlat5 objectAtIndex:0] doubleValue];
        double longit = [[arrpointlong5 objectAtIndex:0] doubleValue];
        
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(lati, longit);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
         mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
        
    }
    else
    {
        sampleImgView5.image=nil;
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(currLocation5.coordinate.latitude, currLocation5.coordinate.longitude);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
         mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
    }
}

-(void)angl6:(UIImageView *)sender
{
    if (f<arrpointlat6.count)
    {
        [sampleImgView6 removeFromSuperview];
        double lati = [[arrpointlat6 objectAtIndex:f-1] doubleValue];
        double longit = [[arrpointlong6 objectAtIndex:f-1] doubleValue];
        
        double lati1 = [[arrpointlat6 objectAtIndex:f] doubleValue];
        double longit1 = [[arrpointlong6 objectAtIndex:f] doubleValue];
        
        prevCurrLocation6 = [[CLLocation alloc]initWithLatitude:lati longitude:longit];
        currLocation6 = [[CLLocation alloc]initWithLatitude:lati1 longitude:longit1];
        
        
        sampleImgView6 = [[UIImageView alloc]init];
        sampleImgView6.center = _mapView_.center;
        sampleImgView6.backgroundColor = [UIColor clearColor];
        [_mapView_ addSubview:sampleImgView6];
        
        
        CGPoint ImgCenter = sampleImgView6.center;
        CGRect frameRect = sampleImgView6.frame;
        
        frameRect.size.width = 30.0f;
        frameRect.size.height = 30.0f;
        sampleImgView6.image = [UIImage imageNamed:@"carjam.png"]; // place your own vehicle image
        
        sampleImgView6.center = ImgCenter;
        sampleImgView6.frame = frameRect;
        
        sampleImgView6.image = [UIImage imageNamed:@"carjam.png"];
        [sampleImgView6 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(prevCurrLocation6.coordinate.latitude, prevCurrLocation6.coordinate.longitude)]];
        
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:10.0];
        // marker2.icon=[UIImage imageNamed:@"carjam.png"];
        [CATransaction commit];
        
        
        CGPoint anglepoint = [_mapView_.projection pointForCoordinate:currLocation6.coordinate];
        
        CGPoint previousLocationPoint = [_mapView_.projection pointForCoordinate:prevCurrLocation6.coordinate];
        
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
            sampleImgView6.transform=rotationTransform;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView6 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation6.coordinate.latitude, currLocation6.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation6 = currLocation6;
        }
        else{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView6 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation6.coordinate.latitude, currLocation6.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation6 = currLocation6;
        }
        f++;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(angl6:) object:nil];
        [self performSelector:@selector(angl6:) withObject:nil afterDelay:2.0];
    }
    
    else if (arrpointlat6.count==1)
    {
        [sampleImgView6 removeFromSuperview];
        double lati = [[arrpointlat6 objectAtIndex:0] doubleValue];
        double longit = [[arrpointlong6 objectAtIndex:0] doubleValue];
        
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(lati, longit);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
         mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
        
    }
    else
    {
        sampleImgView6.image=nil;
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(currLocation6.coordinate.latitude, currLocation6.coordinate.longitude);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
         mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
    }
}
-(void)angl7:(UIImageView *)sender
{
    if (m<arrpointlat7.count)
    {
        [sampleImgView7 removeFromSuperview];
        double lati = [[arrpointlat7 objectAtIndex:m-1] doubleValue];
        double longit = [[arrpointlong7 objectAtIndex:m-1] doubleValue];
        
        double lati1 = [[arrpointlat7 objectAtIndex:m] doubleValue];
        double longit1 = [[arrpointlong7 objectAtIndex:m] doubleValue];
        
        prevCurrLocation7 = [[CLLocation alloc]initWithLatitude:lati longitude:longit];
        currLocation7 = [[CLLocation alloc]initWithLatitude:lati1 longitude:longit1];
        
        
        sampleImgView7 = [[UIImageView alloc]init];
        sampleImgView7.center = _mapView_.center;
        sampleImgView7.backgroundColor = [UIColor clearColor];
        [_mapView_ addSubview:sampleImgView7];
        
        
        CGPoint ImgCenter = sampleImgView7.center;
        CGRect frameRect = sampleImgView7.frame;
        
        frameRect.size.width = 30.0f;
        frameRect.size.height = 30.0f;
        sampleImgView7.image = [UIImage imageNamed:@"carjam.png"]; // place your own vehicle image
        
        sampleImgView7.center = ImgCenter;
        sampleImgView7.frame = frameRect;
        
        sampleImgView7.image = [UIImage imageNamed:@"carjam.png"];
        [sampleImgView7 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(prevCurrLocation7.coordinate.latitude, prevCurrLocation7.coordinate.longitude)]];
        
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:10.0];
        // marker2.icon=[UIImage imageNamed:@"carjam.png"];
        [CATransaction commit];
        
        
        CGPoint anglepoint = [_mapView_.projection pointForCoordinate:currLocation7.coordinate];
        
        CGPoint previousLocationPoint = [_mapView_.projection pointForCoordinate:prevCurrLocation7.coordinate];
        
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
            sampleImgView7.transform=rotationTransform;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView7 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation7.coordinate.latitude, currLocation7.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation7 = currLocation7;
        }
        else{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView7 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation7.coordinate.latitude, currLocation7.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation7 = currLocation7;
        }
        m++;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(angl7:) object:nil];
        [self performSelector:@selector(angl7:) withObject:nil afterDelay:2.0];
    }
    
    else if (arrpointlat7.count==1)
    {
        [sampleImgView7 removeFromSuperview];
        double lati = [[arrpointlat7 objectAtIndex:0] doubleValue];
        double longit = [[arrpointlong7 objectAtIndex:0] doubleValue];
        
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(lati, longit);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
         mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
        
    }
    else
    {
        sampleImgView7.image=nil;
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(currLocation7.coordinate.latitude, currLocation7.coordinate.longitude);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
         mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
    }
}
-(void)angl8:(UIImageView *)sender
{
    if (n<arrpointlat8.count)
    {
        [sampleImgView8 removeFromSuperview];
        double lati = [[arrpointlat8 objectAtIndex:n-1] doubleValue];
        double longit = [[arrpointlong8 objectAtIndex:n-1] doubleValue];
        
        double lati1 = [[arrpointlat8 objectAtIndex:n] doubleValue];
        double longit1 = [[arrpointlong8 objectAtIndex:n] doubleValue];
        
        prevCurrLocation8 = [[CLLocation alloc]initWithLatitude:lati longitude:longit];
        currLocation8 = [[CLLocation alloc]initWithLatitude:lati1 longitude:longit1];
        
        
        sampleImgView8 = [[UIImageView alloc]init];
        sampleImgView8.center = _mapView_.center;
        sampleImgView8.backgroundColor = [UIColor clearColor];
        [_mapView_ addSubview:sampleImgView8];
        
        
        CGPoint ImgCenter = sampleImgView8.center;
        CGRect frameRect = sampleImgView8.frame;
        
        frameRect.size.width = 30.0f;
        frameRect.size.height = 30.0f;
        sampleImgView8.image = [UIImage imageNamed:@"carjam.png"]; // place your own vehicle image
        
        sampleImgView8.center = ImgCenter;
        sampleImgView8.frame = frameRect;
        
        sampleImgView8.image = [UIImage imageNamed:@"carjam.png"];
        [sampleImgView8 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(prevCurrLocation8.coordinate.latitude, prevCurrLocation8.coordinate.longitude)]];
        
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:10.0];
        // marker2.icon=[UIImage imageNamed:@"carjam.png"];
        [CATransaction commit];
        
        
        CGPoint anglepoint = [_mapView_.projection pointForCoordinate:currLocation8.coordinate];
        
        CGPoint previousLocationPoint = [_mapView_.projection pointForCoordinate:prevCurrLocation8.coordinate];
        
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
            sampleImgView8.transform=rotationTransform;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView8 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation8.coordinate.latitude, currLocation8.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation8 = currLocation8;
        }
        else{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView8 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation8.coordinate.latitude, currLocation8.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation8 = currLocation8;
        }
        n++;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(angl8:) object:nil];
        [self performSelector:@selector(angl8:) withObject:nil afterDelay:2.0];
    }
    
    else if (arrpointlat8.count==1)
    {
        [sampleImgView8 removeFromSuperview];
        double lati = [[arrpointlat8 objectAtIndex:0] doubleValue];
        double longit = [[arrpointlong8 objectAtIndex:0] doubleValue];
        
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(lati, longit);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
         mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
        
    }
    else
    {
        sampleImgView8.image=nil;
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(currLocation8.coordinate.latitude, currLocation8.coordinate.longitude);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
         mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
    }
}
-(void)angl9:(UIImageView *)sender
{
    if (o<arrpointlat9.count)
    {
        [sampleImgView9 removeFromSuperview];
        double lati = [[arrpointlat9 objectAtIndex:o-1] doubleValue];
        double longit = [[arrpointlong9 objectAtIndex:o-1] doubleValue];
        
        double lati1 = [[arrpointlat9 objectAtIndex:o] doubleValue];
        double longit1 = [[arrpointlong9 objectAtIndex:o] doubleValue];
        
        prevCurrLocation9 = [[CLLocation alloc]initWithLatitude:lati longitude:longit];
        currLocation9 = [[CLLocation alloc]initWithLatitude:lati1 longitude:longit1];
        
        
        sampleImgView9 = [[UIImageView alloc]init];
        sampleImgView9.center = _mapView_.center;
        sampleImgView9.backgroundColor = [UIColor clearColor];
        [_mapView_ addSubview:sampleImgView9];
        
        
        CGPoint ImgCenter = sampleImgView9.center;
        CGRect frameRect = sampleImgView9.frame;
        
        frameRect.size.width = 30.0f;
        frameRect.size.height = 30.0f;
        sampleImgView9.image = [UIImage imageNamed:@"carjam.png"]; // place your own vehicle image
        
        sampleImgView9.center = ImgCenter;
        sampleImgView9.frame = frameRect;
        
        sampleImgView9.image = [UIImage imageNamed:@"carjam.png"];
        [sampleImgView9 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(prevCurrLocation9.coordinate.latitude, prevCurrLocation9.coordinate.longitude)]];
        
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:10.0];
        // marker2.icon=[UIImage imageNamed:@"carjam.png"];
        [CATransaction commit];
        
        
        CGPoint anglepoint = [_mapView_.projection pointForCoordinate:currLocation9.coordinate];
        
        CGPoint previousLocationPoint = [_mapView_.projection pointForCoordinate:prevCurrLocation9.coordinate];
        
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
            sampleImgView9.transform=rotationTransform;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView9 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation9.coordinate.latitude, currLocation9.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation9 = currLocation9;
        }
        else{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0f];
            [sampleImgView9 setCenter:[_mapView_.projection pointForCoordinate:CLLocationCoordinate2DMake(currLocation9.coordinate.latitude, currLocation9.coordinate.longitude)]];
            [UIView commitAnimations];
            prevCurrLocation9 = currLocation9;
        }
        o++;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(angl9:) object:nil];
        [self performSelector:@selector(angl9:) withObject:nil afterDelay:2.0];
    }
    
    else if (arrpointlat9.count==1)
    {
        [sampleImgView9 removeFromSuperview];
        double lati = [[arrpointlat9 objectAtIndex:0] doubleValue];
        double longit = [[arrpointlong9 objectAtIndex:0] doubleValue];
        
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(lati, longit);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
         mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
        
    }
    else
    {
        sampleImgView9.image=nil;
        GMSMarker *mark=[[GMSMarker alloc]init];
        mark.position=CLLocationCoordinate2DMake(currLocation9.coordinate.latitude, currLocation9.coordinate.longitude);
        mark.icon=[UIImage imageNamed:@"carjam.png"];
         mark.icon = [self image:mark.icon scaledToSize:CGSizeMake(30.0f, 30.0f)];
        mark.map=_mapView_;
    }
}


-(void)num1:(id)sender
{
    return;
    
}





-(void)parseJSONResponse1:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"*****Cars types ******* %@", responseJSON);
    
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
        DataArray=[NSMutableArray array];
        [DataArray addObjectsFromArray:[responseJSON valueForKey:@"data"]];
        carID =[[DataArray objectAtIndex:0] valueForKey:@"name"];
        
        [[NSUserDefaults standardUserDefaults] setObject:carID forKey:@"Name"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
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
            
            for(i=0;i<currentLocationAddArr.count;i++)
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
            thePlacemark1 = [placemarks lastObject];
            
            latitude=coordinate.latitude;
            longitude=coordinate.longitude;
            
            
            NSLog(@"Before latitude:%f",latitude);
            NSLog(@"Before longitude:%f",longitude);
            
            [[NSUserDefaults standardUserDefaults]setFloat:latitude forKey:@"lati"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setFloat:longitude forKey:@"longi"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                                    longitude:longitude
                                                                         zoom:19];
            self.mapView_.camera=camera;
//            _mapView_.myLocationEnabled = NO;
            
//            marker = [[GMSMarker alloc] init];
//            marker.position = CLLocationCoordinate2DMake(latitude, longitude);
//            marker.title=strAdd;
//            marker.snippet=strAdd1;
//            marker.map = _mapView_;
//            marker.icon = [UIImage imageNamed:@"newpin.png"];

          //  [self getDesLocationwithtext:_searchDropAddRef2.text];
        }
    }];
}


-(void)getDesLocationwithtext:(NSString *)text
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
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
            
            for(i=0;i<currentLocationAddArr.count;i++)
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
            
            thePlacemark = [placemarks lastObject];
            
            latitude1=coordinate.latitude;
            longitude1=coordinate.longitude;
            
            [[NSUserDefaults standardUserDefaults]setFloat:latitude1 forKey:@"lati1"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setFloat:longitude1 forKey:@"longi1"];
            [[NSUserDefaults standardUserDefaults]synchronize];
//            [_mapView_ clear];
//            
//            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude1
//                                                                    longitude:longitude1
//                                                                         zoom:12];
//            self.mapView_.camera=camera;
//            _mapView_.myLocationEnabled = YES;
//            
//            marker = [[GMSMarker alloc] init];
//            marker.position = CLLocationCoordinate2DMake(latitude1, longitude1);
//            marker.map = _mapView_;
//            marker.title=strAdd;
//            marker.snippet=strAdd1;
//            [self getCurentLocationwithtext2:_searchDropAddRef.text];
        }
        
    }];
}
-(void)getCurentLocationwithtext2:(NSString*)text
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
            
            for(i=0;i<currentLocationAddArr.count;i++)
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
            thePlacemark1 = [placemarks lastObject];
            
            latitude=coordinate.latitude;
            longitude=coordinate.longitude;
            
            [[NSUserDefaults standardUserDefaults]setFloat:latitude forKey:@"lati"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setFloat:longitude forKey:@"longi"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                                    longitude:longitude
                                                                         zoom:19];
            self.mapView_.camera=camera;
            _mapView_.myLocationEnabled = YES;
            
            marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(latitude, longitude);
            marker.title=strAdd;
            marker.snippet=strAdd1;
            marker.map = _mapView_;
             [self draw];
        }
    }];
}

#pragma mark- Polyline Route

-(void)draw
{
    NSString *baseUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", latitude,  longitude, latitude1, longitude1];
    
    NSURL *url = [NSURL URLWithString:[baseUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    NSLog(@"Url: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(!connectionError){
            NSDictionary *result        = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            routes             = [result objectForKey:@"routes"];
            if ((routes.count == 0)) {
                //                [self showMessage:@"Please choose your valid location"
                //                        withTitle:@"Warning"];
            }else{
                NSDictionary *firstRoute    = [routes objectAtIndex:0];
                NSString *encodedPath       = [firstRoute[@"overview_polyline"] objectForKey:@"points"];
                
                polyPath       = [GMSPolyline polylineWithPath:[GMSPath pathFromEncodedPath:encodedPath]];
                polyPath.strokeColor        = [UIColor blueColor];
                polyPath.strokeWidth        = 2.0f;
                polyPath.map                = _mapView_;
            }
        }
    }];
    
}


-(void)getCurentLocationwithtextr:(NSString*)text
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
            
            for(i=0;i<currentLocationAddArr.count;i++)
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
            thePlacemark1 = [placemarks lastObject];
            
            latitude=coordinate.latitude;
            longitude=coordinate.longitude;
            
            [[NSUserDefaults standardUserDefaults]setFloat:latitude forKey:@"lati"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setFloat:longitude forKey:@"longi"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                                    longitude:longitude
                                                                         zoom:19];
            self.mapView_.camera=camera;
            _mapView_.myLocationEnabled = YES;
            
            marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(latitude, longitude);
            marker.title=strAdd;
            marker.snippet=strAdd1;
            marker.map = _mapView_;
            
            [self getDesLocationwithtextr:_searchDropAddRef2.text];
        }
    }];
}


-(void)getDesLocationwithtextr:(NSString *)text
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
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
            
            for(i=0;i<currentLocationAddArr.count;i++)
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
            
            thePlacemark = [placemarks lastObject];
            
            latitude1=coordinate.latitude;
            longitude1=coordinate.longitude;
            
            [[NSUserDefaults standardUserDefaults]setFloat:latitude1 forKey:@"lati1"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSUserDefaults standardUserDefaults]setFloat:longitude1 forKey:@"longi1"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude1
                                                                    longitude:longitude1
                                                                         zoom:19];
            self.mapView_.camera=camera;
            _mapView_.myLocationEnabled = YES;
            
            marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(latitude1, longitude1);
            marker.map = _mapView_;
            marker.title=strAdd;
            marker.snippet=strAdd1;
            [self draw];
        }
        
    }];
}

#pragma mark
#pragma mark -- BookLater Clicked

- (IBAction)BooklaterClicked:(id)sender
{
    BooklaterViewController *book=[self.storyboard instantiateViewControllerWithIdentifier:@"BooklaterViewController"];
    [self.navigationController pushViewController:book animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }

    
    //Optional Properties
    
    _searchDropAddRef.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    
    _searchDropAddRef.autoCompleteBoldFontName = @"HelveticaNeue";
    
    _searchDropAddRef.autoCompleteTableCornerRadius=0.0;
    
    _searchDropAddRef.autoCompleteRowHeight=35;
    
    _searchDropAddRef.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
    
    _searchDropAddRef.autoCompleteFontSize=14;
    
    _searchDropAddRef.autoCompleteTableBorderWidth=1.0;
    
    _searchDropAddRef.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    
    _searchDropAddRef.autoCompleteShouldHideOnSelection=YES;
    
    _searchDropAddRef.autoCompleteShouldHideClosingKeyboard=YES;
    
    _searchDropAddRef.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    
    _searchDropAddRef.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_searchDropAddRef.frame.size.width)*0.01, _searchDropAddRef.frame.size.height+85.0, self.view.frame.size.width-0.1, 200.0);
    
    
    _searchDropAddRef2.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    
    _searchDropAddRef2.autoCompleteBoldFontName = @"HelveticaNeue";
    
    _searchDropAddRef2.autoCompleteTableCornerRadius=0.0;
    
    _searchDropAddRef2.autoCompleteRowHeight=35;
    
    _searchDropAddRef2.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
    
    _searchDropAddRef2.autoCompleteFontSize=14;
    
    _searchDropAddRef2.autoCompleteTableBorderWidth=1.0;
    
    _searchDropAddRef2.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    
    _searchDropAddRef2.autoCompleteShouldHideOnSelection=YES;
    
    _searchDropAddRef2.autoCompleteShouldHideClosingKeyboard=YES;
    
    _searchDropAddRef2.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    
    _searchDropAddRef2.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_searchDropAddRef2.frame.size.width)*0.01, _searchDropAddRef2.frame.size.height+120.0, self.view.frame.size.width-0.02, 200.0);
    
    
    _searchDropAddReff.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    
    _searchDropAddReff.autoCompleteBoldFontName = @"HelveticaNeue";
    
    _searchDropAddReff.autoCompleteTableCornerRadius=0.0;
    
    _searchDropAddReff.autoCompleteRowHeight=35;
    
    _searchDropAddReff.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
    
    _searchDropAddReff.autoCompleteFontSize=14;
    
    _searchDropAddReff.autoCompleteTableBorderWidth=1.0;
    
    _searchDropAddReff.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    
    _searchDropAddReff.autoCompleteShouldHideOnSelection=YES;
    
    _searchDropAddReff.autoCompleteShouldHideClosingKeyboard=YES;
    
    _searchDropAddReff.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    
    _searchDropAddReff.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_searchDropAddReff.frame.size.width)*0.01, _searchDropAddReff.frame.size.height+40.0, self.view.frame.size.width-0.02, 200.0);
    
    
    _searchDropAddReff1.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    
    _searchDropAddReff1.autoCompleteBoldFontName = @"HelveticaNeue";
    
    _searchDropAddReff1.autoCompleteTableCornerRadius=0.0;
    
    _searchDropAddReff1.autoCompleteRowHeight=35;
    
    _searchDropAddReff1.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
    
    _searchDropAddReff1.autoCompleteFontSize=14;
    
    _searchDropAddReff1.autoCompleteTableBorderWidth=1.0;
    
    _searchDropAddReff1.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    
    _searchDropAddReff1.autoCompleteShouldHideOnSelection=YES;
    
    _searchDropAddReff1.autoCompleteShouldHideClosingKeyboard=YES;
    
    _searchDropAddReff1.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    
    _searchDropAddReff1.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_searchDropAddReff1.frame.size.width)*0.01, _searchDropAddReff1.frame.size.height+70.0, self.view.frame.size.width-0.02, 200.0);
    
}



#pragma mark - Place search Textfield Delegates

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict
{
    [self.view endEditing:YES];
    [self getCurentLocationwithtext:_searchDropAddRef.text];
    [self getDesLocationwithtext:_searchDropAddRef2.text];
    
//    [self getLocationFromAddressString:_searchDropAddRef.text];
//    [self getLocationFromAddressString2:_searchDropAddRef2.text];
}

-(void) getLocationFromAddressString: (NSString*) addressStr
{
  
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanFloat:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanFloat:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    
    [[NSUserDefaults standardUserDefaults]setFloat:latitude forKey:@"lati"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setFloat:longitude forKey:@"longi"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [_mapView_ clear];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
                                                                 zoom:19];
    self.mapView_.camera=camera;
    
    marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
    marker.title=_searchDropAddRef.text;
   // marker.snippet=[strnam objectAtIndex:1];
    marker.map = _mapView_;
    [self getLocationFromAddressString2:_searchDropAddRef2.text];
}

-(void) getLocationFromAddressString2: (NSString*) addressStr
{
    
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanFloat:&latitude1];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanFloat:&longitude1];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude1;
    center.longitude = longitude1;
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    
    
    [[NSUserDefaults standardUserDefaults]setFloat:latitude1 forKey:@"lati1"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setFloat:longitude1 forKey:@"longi1"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [_mapView_ clear];
    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude1
//                                                            longitude:longitude1
//                                                                 zoom:17];
//    self.mapView_.camera=camera;
    marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latitude1, longitude1);
    marker.title=_searchDropAddRef2.text;
   // marker.snippet=[strnam objectAtIndex:1];
    marker.map = _mapView_;
    [self getLocationFromAddressString3:_searchDropAddRef.text];
}

-(void) getLocationFromAddressString3: (NSString*) addressStr
{
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanFloat:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanFloat:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    
    [[NSUserDefaults standardUserDefaults]setFloat:latitude forKey:@"lati"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setFloat:longitude forKey:@"longi"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
//                                                            longitude:longitude
//                                                                 zoom:12];
//    self.mapView_.camera=camera;
    marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
    marker.title=_searchDropAddRef.text;;
    marker.map = _mapView_;
    [self draw];
}
-(void) getLocationFromAddressString4: (NSString*) addressStr
{
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanFloat:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanFloat:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    
    [[NSUserDefaults standardUserDefaults]setFloat:latitude forKey:@"lati"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setFloat:longitude forKey:@"longi"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
//                                                            longitude:longitude
//                                                                 zoom:12];
//    self.mapView_.camera=camera;
//    marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
//    marker.title=_searchDropAddRef.text;
//    marker.icon = [UIImage imageNamed:@"newpin.png"];
//    marker.map = _mapView_;
    
//    CGPoint point = _mapView_.center;
//    GMSCameraUpdate *camera =[GMSCameraUpdate setTarget:[_mapView_.projection coordinateForPoint:point]];
//    [_mapView_ animateWithCameraUpdate:camera];
}

-(void) getLocationFromAddressString5: (NSString*) addressStr
{
    
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanFloat:&latitude1];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanFloat:&longitude1];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude1;
    center.longitude = longitude1;
    
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    
    
    [[NSUserDefaults standardUserDefaults]setFloat:latitude1 forKey:@"lati1"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setFloat:longitude1 forKey:@"longi1"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latitude1, longitude1);
    marker.title=_searchDropAddRef2.text;
    marker.map = _mapView_;
  //  [self draw];
}


-(void) getLocationFromAddressString6: (NSString*) addressStr
{
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result)
    {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanFloat:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanFloat:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    NSLog(@"View Controller get Location Latitude : %f",center.latitude);
    NSLog(@"View Controller get Location Longitude : %f",center.longitude);
    
    [[NSUserDefaults standardUserDefaults]setFloat:latitude forKey:@"lati"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setFloat:longitude forKey:@"longi"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                                longitude:longitude
                                                                     zoom:19];
    self.mapView_.camera=camera;
    marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
    marker.title=_searchDropAddRef.text;
    marker.icon = [UIImage imageNamed:@"newpin.png"];
    marker.map = _mapView_;
}


-(void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField
{

}

-(void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField
{
    
}

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index
{
    
    if(index%2==0){
        
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        
    }else{
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
}

#pragma mark DecodePolyline Routes

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
   //     printf("[%f,", [latitude2 doubleValue]);
   //     printf("%f]", [longitude2 doubleValue]);

        [arrpointlat addObject:latitude2];
        [arrpointlong addObject:longitude2];
        
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude2 floatValue] longitude:[longitude2 floatValue]] ;
        [array addObject:loc];
    }
   // NSLog(@"array:%@",arrpointlat);
   // NSLog(@"array:%@",arrpointlong);
    return array;
}


-(NSMutableArray *)decodePolyLin: (NSMutableString *)encoded {
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
     //   printf("[%f,", [latitude2 doubleValue]);
     //   printf("%f]", [longitude2 doubleValue]);
        [arrpointlat1 addObject:latitude2];
        [arrpointlong1 addObject:longitude2];
        
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude2 floatValue] longitude:[longitude2 floatValue]] ;
        [array addObject:loc];
    }
  //  NSLog(@"array1:%@",arrpointlat1);
  //  NSLog(@"array1:%@",arrpointlong1);
    return array;
}

-(NSMutableArray *)decodePolyLine1: (NSMutableString *)encoded {
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
    //    printf("[%f,", [latitude2 doubleValue]);
    //    printf("%f]", [longitude2 doubleValue]);
        
        [arrpointlat2 addObject:latitude2];
        [arrpointlong2 addObject:longitude2];
        
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude2 floatValue] longitude:[longitude2 floatValue]] ;
        [array addObject:loc];
    }
 //   NSLog(@"array2:%@",arrpointlat2);
 //   NSLog(@"array2%@",arrpointlong2);
    return array;
}
-(NSMutableArray *)decodePolyLine2: (NSMutableString *)encoded {
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
    //    printf("[%f,", [latitude2 doubleValue]);
    //    printf("%f]", [longitude2 doubleValue]);
        
        [arrpointlat3 addObject:latitude2];
        [arrpointlong3 addObject:longitude2];
        
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude2 floatValue] longitude:[longitude2 floatValue]] ;
        [array addObject:loc];
    }
  //  NSLog(@"array2:%@",arrpointlat3);
  //  NSLog(@"array2%@",arrpointlong3);
    return array;
}
-(NSMutableArray *)decodePolyLine3: (NSMutableString *)encoded {
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
      //  printf("[%f,", [latitude2 doubleValue]);
      //  printf("%f]", [longitude2 doubleValue]);
        
        [arrpointlat4 addObject:latitude2];
        [arrpointlong4 addObject:longitude2];
        
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude2 floatValue] longitude:[longitude2 floatValue]] ;
        [array addObject:loc];
    }
 //   NSLog(@"array2:%@",arrpointlat4);
 //   NSLog(@"array2%@",arrpointlong4);
    return array;
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
        NSNumber *latitude2 = [[NSNumber alloc] initWithFloat:lattt * 1e-5] ;
        NSNumber *longitude2 = [[NSNumber alloc] initWithFloat:lng * 1e-5] ;
      //  printf("[%f,", [latitude2 doubleValue]);
     //   printf("%f]", [longitude2 doubleValue]);
        
        [arrpointlat5 addObject:latitude2];
        [arrpointlong5 addObject:longitude2];
        
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude2 floatValue] longitude:[longitude2 floatValue]] ;
        [array addObject:loc];
    }
 //   NSLog(@"array2:%@",arrpointlat5);
 //   NSLog(@"array2%@",arrpointlong5);
    return array;
}
-(NSMutableArray *)decodePolyLine5: (NSMutableString *)encoded {
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
   //     printf("[%f,", [latitude2 doubleValue]);
   //     printf("%f]", [longitude2 doubleValue]);
        
        [arrpointlat6 addObject:latitude2];
        [arrpointlong6 addObject:longitude2];
        
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude2 floatValue] longitude:[longitude2 floatValue]] ;
        [array addObject:loc];
    }
 //   NSLog(@"array2:%@",arrpointlat6);
 //   NSLog(@"array2%@",arrpointlong6);
    return array;
}
-(NSMutableArray *)decodePolyLine6: (NSMutableString *)encoded {
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
  //      printf("[%f,", [latitude2 doubleValue]);
  //      printf("%f]", [longitude2 doubleValue]);
        
        [arrpointlat7 addObject:latitude2];
        [arrpointlong7 addObject:longitude2];
        
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude2 floatValue] longitude:[longitude2 floatValue]] ;
        [array addObject:loc];
    }
//    NSLog(@"array2:%@",arrpointlat7);
//    NSLog(@"array2%@",arrpointlong7);
    return array;
}
-(NSMutableArray *)decodePolyLine7: (NSMutableString *)encoded {
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
     //   printf("[%f,", [latitude2 doubleValue]);
     //   printf("%f]", [longitude2 doubleValue]);
        
        [arrpointlat8 addObject:latitude2];
        [arrpointlong8 addObject:longitude2];
        
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude2 floatValue] longitude:[longitude2 floatValue]] ;
        [array addObject:loc];
    }
 //   NSLog(@"array2:%@",arrpointlat8);
 //   NSLog(@"array2%@",arrpointlong8);
    return array;
}
-(NSMutableArray *)decodePolyLine8: (NSMutableString *)encoded {
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
    //    printf("[%f,", [latitude2 doubleValue]);
   //     printf("%f]", [longitude2 doubleValue]);
        
        [arrpointlat9 addObject:latitude2];
        [arrpointlong9 addObject:longitude2];
        
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude2 floatValue] longitude:[longitude2 floatValue]] ;
        [array addObject:loc];
    }
  //  NSLog(@"array2:%@",arrpointlat9);
  //  NSLog(@"array2%@",arrpointlong9);
    return array;
}

- (IBAction)CurrentLocationClick:(id)sender
{
    [_mapView_ clear];
    [_currentlocationbutt setImage:[UIImage imageNamed:@"location-2.png"] forState:UIControlStateNormal];
    locationManager = [[CLLocationManager alloc] init];
    [self startLocationUpdates];
    latitude = locationManager.location.coordinate.latitude;
    longitude =locationManager.location.coordinate.longitude;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:19];
    //plotting the google map
    
    CGPoint point = _mapView_.center;
    GMSCameraUpdate *camera1 =[GMSCameraUpdate setTarget:[_mapView_.projection coordinateForPoint:point]];
    [_mapView_ animateWithCameraUpdate:camera1];
    self.mapView_.camera=camera;
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




#pragma mark
#pragma mark -- RequestNow Clicked



- (IBAction)pickupbuttClicked:(id)sender
{
//    self.navigationController.navigationBar.hidden=YES;
//    
//    popview = [[ UIView alloc]init];
//    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
//    [self.view addSubview:popview];
//    
//    footerview2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height)];
//    footerview2.backgroundColor = [UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
//    [popview addSubview:footerview2];
//    
//    
//    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview2.frame.size.width, 10)];
//    lab1.backgroundColor=[UIColor darkGrayColor];
//    [footerview2 addSubview:lab1];
//    
//    
//    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, footerview2.frame.size.width, 50)];
//    lab.text=@"PickUp Location";
//    lab.textColor=[UIColor whiteColor];
//    lab.backgroundColor=[UIColor darkGrayColor];
//    lab.textAlignment=NSTextAlignmentCenter;
//    lab.font=[UIFont boldSystemFontOfSize:16];
//    [footerview2 addSubview:lab];
//    
//    UIButton *butt11=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
//    [butt11 setTitle:@"Cancel" forState:UIControlStateNormal];
//    butt11.titleLabel.font = [UIFont systemFontOfSize:15];
//    butt11.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [butt11 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [butt11 addTarget:self action:@selector(Cancelclicked:) forControlEvents:UIControlEventTouchUpInside];
//    [footerview2 addSubview:butt11];
//    
//
//    mvplacesearchpick=[[UITextField alloc]initWithFrame:CGRectMake(5, 70, self.view.frame.size.width-10, 35)];
//    [mvplacesearchpick setBorderStyle:UITextBorderStyleBezel];
//     mvplacesearchpick.font=[UIFont systemFontOfSize:14];
//     mvplacesearchpick.placeholder=@"Enter Your PickUp Location";
//    mvplacesearchpick.delegate=self;
//    [footerview2 addSubview:mvplacesearchpick];
//    
//    
//    locationTbl=[[UITableView alloc]initWithFrame:CGRectMake(5, 105, self.view.frame.size.width-10, 200)];
//    locationTbl.delegate=self;
//    locationTbl.dataSource=self;
//    locationTbl.tag=1;
//    locationTbl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    locationTbl.hidden=YES;
//    [footerview2 addSubview:locationTbl];
    
    PickTextViewController *pick=[self.storyboard instantiateViewControllerWithIdentifier:@"PickTextViewController"];
    [self.navigationController pushViewController:pick animated:YES];

}


-(IBAction)Cancelclicked:(id)sender
{
     self.navigationController.navigationBar.hidden=NO;
    
    CGRect newFrame = self.viewcon.frame;
    newFrame.origin.x=0;
    newFrame.origin.y=64;
    [self.viewcon setFrame:newFrame];
    
    _requestnowbutt.hidden=NO;
    footerview.hidden=NO;
    wheelchairbutt.hidden=NO;
    self.navigationController.navigationBar.hidden=NO;
    ridenow.hidden=NO;
    _viewcon.hidden=NO;
    _searchDropAddReff.hidden=YES;
    
    [footerview2 removeFromSuperview];
    popview.hidden = YES;
}

- (void)anymethod:(NSNotification *)notification
{
    NSLog(@"%@", notification.userInfo);
        
    NSDictionary *dict=notification.userInfo;
        
    _searchDropAddRef.text=[dict valueForKey:@"Data"];
        
    [self getCurentLocationwithtext:_searchDropAddRef.text];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Notification"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)anymethod2:(NSNotification *)notification
{
    NSLog(@"%@", notification.userInfo);
    
    NSDictionary *dict=notification.userInfo;
    
    _searchDropAddRef2.text=[dict valueForKey:@"Data"];
    
    [self getDesLocationwithtext:_searchDropAddRef2.text];
    
   // [self getCurentLocationwithtext:_searchDropAddRef.text];
}


- (IBAction)DesbuttClicked:(id)sender
{
    DesTextViewController *pick=[self.storyboard instantiateViewControllerWithIdentifier:@"DesTextViewController"];
    [self.navigationController pushViewController:pick animated:YES];
}



#pragma - mark -
#pragma - mark Tableview delegate methodes

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrLocations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"Cell1";
    static NSString *CellIdentifier2 = @"Cell2";
   
    
    UITableViewCell *cell;
    
    if (tableView.tag==1) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier1];
        }
        
         cell.textLabel.text=[arrLocations objectAtIndex:indexPath.row];
        
    }else if (tableView.tag==2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil) {
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
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [mvplacesearchpick resignFirstResponder];
        mvplacesearchpick.text=[arrLocations objectAtIndex:indexPath.row];
        
        self.navigationController.navigationBar.hidden=NO;

        [locationTbl setHidden:YES];
        [footerview2 removeFromSuperview];
        popview.hidden = YES;
        
        CGRect newFrame = self.viewcon.frame;
        newFrame.origin.x=0;
        newFrame.origin.y=64;
        [self.viewcon setFrame:newFrame];
        
        _requestnowbutt.hidden=NO;
        footerview.hidden=NO;
        wheelchairbutt.hidden=NO;
        self.navigationController.navigationBar.hidden=NO;
        ridenow.hidden=NO;
        _viewcon.hidden=NO;
        _searchDropAddReff.hidden=YES;
        _searchDropAddRef.text=mvplacesearchpick.text;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self getCurentLocationwithtext:_searchDropAddRef.text];
        });
        
        
        
       
        
    }else if (tableView.tag==2)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [mvplacesearchpick resignFirstResponder];
        mvplacesearchpick.text=[arrLocations objectAtIndex:indexPath.row];
        [locationTbl setHidden:YES];
        
        [self getCurentLocationwithtext:mvplacesearchpick.text];
    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == mvplacesearchpick)
    {
        
        NSString *str=[mvplacesearchpick.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
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
//    else if (textField==_txtRest)
//    {
//        NSString *str=[_txtRest.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//        
//        NSString *apiURLStr =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=geocode&location=%f,%f&radius=500&key=AIzaSyC3R8hg9HZgayqCocCmbqDth8-JEtlrtzs",str,core_latitude,core_longitude];
//        
//        
//        
//        // NSLog(@"apiURLStr %@",apiURLStr);
//        
//        NSString *sampleURL = [NSString stringWithContentsOfURL:[NSURL URLWithString:apiURLStr] encoding:NSUTF8StringEncoding error:nil];
//        
//        NSDictionary *dict;
//        
//        dict=[sampleURL JSONValue];
//        
//        
//        // NSLog(@"dict %@",dict);
//        
//        arrLocations=[[dict valueForKey:@"predictions"]valueForKey:@"description"];
//        
//        // NSLog(@"arrLocations %@",arrLocations);
//        
//        if([arrLocations count]>0)
//        {
//            
//            locationTbl2.dataSource=self;
//            locationTbl2.delegate=self;
//            [locationTbl2 reloadData];
//            [locationTbl2 setHidden:NO];
//        }
//        
//        else
//        {
//            [locationTbl2 setHidden:YES];
//        }
    
        
        
 //   }
    
    
    return YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
