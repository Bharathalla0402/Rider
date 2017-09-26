//
//  BooklaterViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 09/04/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "BooklaterViewController.h"
#import "BookTaxiViewController.h"

@interface BooklaterViewController ()

@end

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@implementation BooklaterViewController
@synthesize mapView;

static NSString * const KMapPlacesApiKey = @"AIzaSyBvSrqJcwzr2hAeUIf1V6TWzISzMs35QbI";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"Book Later";
    
    
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
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    _CancelClicked.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _DoneClicked.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    
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
    
   

}

- (IBAction)DatepickerClicked:(id)sender
{
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];

    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(10, 270,300, 230)];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.hidden=NO;
    datePicker.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    [datePicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    datePicker.date=[NSDate date];
    [datePicker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
    [popview addSubview:datePicker];
}

-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];
    //assign text to label
    _DatePicker.text=str;
}

-(void)save:(id)sender
{
    self.navigationItem.rightBarButtonItem=nil;
    [datePicker removeFromSuperview];
    [popview removeFromSuperview];
}


- (IBAction)TimePickerClicked:(id)sender
{
    popview = [[UIView alloc]init];
    popview.frame = CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];

    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(10, 270,300, 230)];
    datePicker.datePickerMode=UIDatePickerModeTime;
    datePicker.hidden=NO;
    datePicker.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    [datePicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    datePicker.date=[NSDate date];
    [datePicker addTarget:self action:@selector(LabelTitl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    
    self.navigationItem.rightBarButtonItem=rightBtn;
    
    [popview addSubview:datePicker];
}

-(void)LabelTitl:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"hh:mm a"];
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];
    //assign text to label
    _timepicker.text=str;
}



- (IBAction)DoneClicked:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:@"Link will update soon" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)CancelClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
            [mapView removeAnnotations:mapView.annotations];
            latitude=coordinate.latitude;
            longitude=coordinate.longitude;
            [self drawMap];
            
            if (_searchDropAddRef2.text.length!=0)
            {
                [self getDesLocationwithtext:_searchDropAddRef2.text];
            }
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
            
            thePlacemark = [placemarks lastObject];
            [mapView removeAnnotations:mapView.annotations];
            latitude1=coordinate.latitude;
            longitude1=coordinate.longitude;
            [self drawMa];
            [self getCurentLocationwitht:_searchDropAddRef.text];
        }
        
    }];
}

-(void)getCurentLocationwitht:(NSString*)text
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
            [self drawMap];
            [self getDesLocationwith:_searchDropAddRef2.text];
            
        }
        
    }];
}
-(void)getDesLocationwith:(NSString *)text
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
            
            thePlacemark = [placemarks lastObject];
            latitude1=coordinate.latitude;
            longitude1=coordinate.longitude;
            [self drawMa];
            
             [self routeDirections];
        }
        
    }];
}



-(void)drawMap
{
    CLLocationCoordinate2D location;
    location.latitude=latitude;
    location.longitude=longitude;
    region.center=location;
    MKCoordinateSpan span1;
    span1.latitudeDelta=4.0;
    span1.longitudeDelta=4.0;
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
    CLLocationCoordinate2D location;
    location.latitude=latitude1;
    location.longitude=longitude1;
    region.center=location;
    MKCoordinateSpan span1;
    span1.latitudeDelta=4.0;
    span1.longitudeDelta=4.0;
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
        MKAnnotationView *annView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
        annView.image=[UIImage imageNamed:@"pin.png"];
        annView.canShowCallout=YES;
        return annView;
}


-(void)viewDidAppear:(BOOL)animated{
    
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
    
    _searchDropAddRef.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_searchDropAddRef.frame.size.width)*0.01, _searchDropAddRef.frame.size.height+120.0, self.view.frame.size.width-0.1, 200.0);
    
    
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
    
    _searchDropAddRef2.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_searchDropAddRef2.frame.size.width)*0.01, _searchDropAddRef2.frame.size.height+175.0, self.view.frame.size.width-0.02, 200.0);
    
}



#pragma mark - Place search Textfield Delegates

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict{
    
    [self.view endEditing:YES];
    
    
    [self getCurentLocationwithtext:_searchDropAddRef.text];
    
   
    
    //  NSLog(@"SELECTED ADDRESS :%@",responseDict);
    
}

-(void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField{
    
    
    
}

-(void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField{
    
    
    
}

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index{
    
    if(index%2==0){
        
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        
    }else{
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    
    
}

-(void)routeDirections
{
    [mapView removeOverlays:mapView.overlays];

    MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:thePlacemark];
    MKPlacemark *placemark1 = [[MKPlacemark alloc] initWithPlacemark:thePlacemark1];
    
    [directionsRequest setSource:[[MKMapItem alloc] initWithPlacemark:placemark1]];
    
    [directionsRequest setDestination:[[MKMapItem alloc] initWithPlacemark:placemark]];
    
    directionsRequest.transportType = MKDirectionsTransportTypeAutomobile;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error %@", error.description);
        }
        
        else {
            routeDetails = response.routes.lastObject;
            [self.mapView addOverlay:routeDetails.polyline];
            
            self.allSteps = @"";
            
            for (int i = 0; i < routeDetails.steps.count; i++) {
                MKRouteStep *step = [routeDetails.steps objectAtIndex:i];
                NSString *newStep = step.instructions;
                self.allSteps = [self.allSteps stringByAppendingString:newStep];
                self.allSteps = [self.allSteps stringByAppendingString:@"\n\n"];
                self.steps.text = self.allSteps;
            }
        }
    }];
    //}
}


-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {//Its Draw the route Direction
    MKPolylineRenderer  * routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:routeDetails.polyline];
    routeLineRenderer.strokeColor = [UIColor redColor];
    routeLineRenderer.lineWidth = 3;
    return routeLineRenderer;
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
