//
//  FareEstimateViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 01/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJSON.h"
#import "JSON.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
@import GoogleMaps;


//typedef enum : NSUInteger {
//    GUTableViewTyp,
//    GUTableViewType,
//    GUTableViewType,
//} GUTableViewType;


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


@interface FareEstimateViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,CLLocationManagerDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *arrcar;
    NSMutableArray *arrcares;
    UITableView *tabl;
    UITableView *CartypeTable;
    UITableView *pickup;
    UITableView *des;
    
    NSString *address;
    CLLocation *pinLocation;
   
    CLLocationManager *locationManager;
     CLGeocoder *geocoder;
    
    NSMutableArray *arrLocations;
    float			core_latitude;
    float			core_longitude;
    
    float			latitude;
    float			longitude;
    
    
    float			latitude1;
    float			longitude1;
    
    NSArray *currentLocationAddArr;
    NSString *strProtiens,*strCalroies,*strfats,*strAdd,*strAdd1,*strCal;
    IBOutlet UITableView *locationTbl;
    IBOutlet UITableView *locationTbl2;
    
     GMSPlacesClient *_placesClient;
    
    
    CLPlacemark *thePlacemark;
    CLPlacemark *thePlacemark1;
    MKRoute *routeDetails;
}
@property (weak, nonatomic) IBOutlet UIImageView *desflag;
@property (weak, nonatomic) IBOutlet UIImageView *sourceflag;

@property (weak, nonatomic) IBOutlet UITextView *steps;
@property (strong, nonatomic) NSString *allSteps;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property(nonatomic, strong) IBOutlet MKMapView *mapView;

//@property (strong, nonatomic) IBOutlet MVPlaceSearchTextField *txtdes;

@property(nonatomic,retain) NSString *catID;
@property (weak, nonatomic) IBOutlet UITextField *txtCarType;
@property(strong,nonatomic)IBOutlet UIPickerView *select_item;

@property (weak, nonatomic) IBOutlet UITextField *txtCar;


@property (weak, nonatomic) IBOutlet UITextField *txtRestaurant;

@property (weak, nonatomic) IBOutlet UITextField *txtRest;

@property (weak, nonatomic) IBOutlet UIImageView *txtw;

@property (weak, nonatomic) IBOutlet UIButton *DoneClicked;
@property (weak, nonatomic) IBOutlet UIButton *CancelClicked;

@property (nonatomic, retain) MKPolyline *routeLine; //your line
@property (nonatomic, retain) MKPolylineView *routeLineView; //overlay view

//@property(nonatomic,strong) IBOutlet UISearchBar *txtRestaurant;
//@property(nonatomic,strong) IBOutlet UISearchBar *txtRest;
@end
