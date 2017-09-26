//
//  BooklaterViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 09/04/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVPlaceSearchTextField.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
@import GoogleMaps;

@interface BooklaterViewController : UIViewController<PlaceSearchTextFieldDelegate,MKMapViewDelegate,GMSMapViewDelegate,CLLocationManagerDelegate>
{
    
    CLLocationManager *locationManager;
    MKCoordinateRegion region;
    CLPlacemark *thePlacemark;
    CLPlacemark *thePlacemark1;
    MKRoute *routeDetails;
    
    float			core_latitude;
    float			core_longitude;
    
    float			latitude;
    float			longitude;
    
    float			latitude1;
    float			longitude1;
    
    NSArray* routes;
    
    NSArray *currentLocationAddArr;

    
    UIDatePicker *datePicker;
    UIBarButtonItem *rightBtn;
    UIView *popview;
    NSString *strProtiens,*strCalroies,*strfats,*strAdd,*strAdd1,*strCal;
    
}

@property (weak, nonatomic) IBOutlet UIButton *CancelClicked;
@property (weak, nonatomic) IBOutlet UIButton *DoneClicked;
@property (weak, nonatomic) IBOutlet UITextField *DatePicker;
@property (weak, nonatomic) IBOutlet UITextField *timepicker;


@property (nonatomic, retain) MKPolyline *routeLine; //your line
@property (nonatomic, retain) MKPolylineView *routeLineView; //overlay view

@property(nonatomic, strong) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *searchDropAddRef;
@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *searchDropAddRef2;

@property (weak, nonatomic) IBOutlet UITextView *steps;
@property (strong, nonatomic) NSString *allSteps;

@end
