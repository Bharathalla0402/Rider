//
//  UpcomingdetailsViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 21/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"

@import GoogleMaps;

@interface UpcomingdetailsViewController : UIViewController<MKMapViewDelegate,GMSMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    MKCoordinateRegion region;
    NSMutableArray *arrdetails;
    UILabel *labid;
    NSArray *currentLocationAddArr;
    NSString *strProtiens,*strCalroies,*strfats,*strAdd,*strAdd1,*strCal;
    
    float			latitude;
    float			longitude;
    
    float			latitude1;
    float			longitude1;
    
    double lat;
    double longi;
    
    int count;
    
    
    NSMutableArray *arrdriverlocation;
}
@property(nonatomic, strong) IBOutlet MKMapView *mapView;
@property(nonatomic,retain) NSString *strpickup;
@property(nonatomic,retain) NSString *strDestination;
@property(nonatomic,retain) NSString *strdate;
@property(nonatomic,retain) NSString *strtime;
@property(nonatomic,retain) NSString *strstatus;
@property(nonatomic,retain) NSString *strtripid;
@property (nonatomic, assign)double latitudep; //latitude is a field of type double
@property (nonatomic, assign)double longitudep;
@property (weak, nonatomic) IBOutlet UIButton *Cancelridebut;

@property (weak, nonatomic) IBOutlet UILabel *lblpickup;
@property (weak, nonatomic) IBOutlet UILabel *lbldes;
@property (weak, nonatomic) IBOutlet UILabel *lbldate;
@property (weak, nonatomic) IBOutlet UILabel *lbltime;
@property (weak, nonatomic) IBOutlet UILabel *lblstatus;

@property (nonatomic, retain) MKPolyline *routeLine; //your line
@property (nonatomic, retain) MKPolylineView *routeLineView; //overlay view

@end
