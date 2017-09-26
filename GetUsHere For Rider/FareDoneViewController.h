//
//  FareDoneViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 02/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJSON.h"
#import "JSON.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"

@import GoogleMaps;

@interface FareDoneViewController : UIViewController<MKMapViewDelegate,UITableViewDataSource,UITableViewDelegate,GMSMapViewDelegate>
{
    CLLocationManager *locationManager;
    MKCoordinateRegion region;
    
    NSMutableArray *arrLocations;
    float			core_latitude;
    float			core_longitude;
    
    float			latitude;
    float			longitude;
    
    
    
    float			latitude1;
    float			longitude1;
    float			latitude2;
    float			longitude2;
    
    NSArray *currentLocationAddArr;
    NSString *strProtiens,*strCalroies,*strfats,*strAdd,*strAdd1,*strCal;
    
    
    NSString *str1;
    NSString *str2;
    NSString *lat;
    NSString *log;
    
    NSArray *routes;
    GMSPolyline *polyPath;
    

    
    
    NSMutableArray *arrfaredetails;
    NSMutableArray *arrlength;
     CLGeocoder *geocoder;
    
    IBOutlet UITableView *tabl;
    
    IBOutlet UITableView *account;
    
    NSMutableArray *tollname;
    NSMutableArray *tollfare;
    
     UIView *footerview;
    
    NSMutableArray *arrairportdet;
    
    GMSMarker *marker;
     NSArray *temp;
    
    NSMutableArray *arrpointlat5;
    NSMutableArray *arrpointlong5;
}



@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UILabel *txtkm;
@property (weak, nonatomic) IBOutlet UILabel *txttolls;

@property (weak, nonatomic) IBOutlet UILabel *txtbasefare;
@property (weak, nonatomic) IBOutlet UILabel *txtkmfare;
@property (weak, nonatomic) IBOutlet UILabel *txttollfare;
@property (weak, nonatomic) IBOutlet UILabel *txttotalfare;

@property (weak, nonatomic) IBOutlet UILabel *lablwhrerefrom;

@property (weak, nonatomic) IBOutlet UILabel *lblairporttolls;
@property (weak, nonatomic) IBOutlet UILabel *lblairporttollsfare;


@property (weak, nonatomic) IBOutlet UINavigationBar *nav;


@property (weak, nonatomic) IBOutlet GMSMapView *mapView_;

@property(nonatomic, strong) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *txtpick;
@property (weak, nonatomic) IBOutlet UILabel *txtdes;
@property (weak, nonatomic) IBOutlet UILabel *txtfare;

@property (nonatomic, retain) MKPolyline *routeLine; //your line
@property (nonatomic, retain) MKPolylineView *routeLineView; //overlay view
@property (weak, nonatomic) IBOutlet UITextView *steps;
@property (strong, nonatomic) NSString *allSteps;
//@property (weak, nonatomic) IBOutlet GMSMapView *mapview_;
@end
