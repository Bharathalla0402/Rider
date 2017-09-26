//
//  DetailtripViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 23/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "DetailtripViewController.h"
#import "UpcomingRidesViewController.h"
#import "SidebarViewController.h"

@interface DetailtripViewController ()

@end

@implementation DetailtripViewController
@synthesize strpickup,strDestination,strtime,strdate,strstatus,strtripid,mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    [self getCurentLocationwithtext:_lblpickup.text];
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

- (IBAction)doneClicked:(id)sender
{
    SidebarViewController *cancel=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:cancel animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Details";
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
